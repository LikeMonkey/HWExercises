//
//  XFWkwebView.m
//  WKWebView
//
//  Created by XiaoFeng on 2016/11/24.
//  Copyright © 2016年 XiaoFeng. All rights reserved.
//  QQ:1028708571 欢迎骚扰
//  github链接:https://github.com/XFIOSXiaoFeng/WKWebView

#define MainScreen_Width [UIScreen mainScreen].bounds.size.width

#define MainScreen_Height [UIScreen mainScreen].bounds.size.height

#import "XFWkwebView.h"

typedef enum{
    loadWebURLString = 0,
    loadWebHTMLString,
    POSTWebURLString,
}wkWebLoadType;

static void *XFWkwebBrowserContext = &XFWkwebBrowserContext;

@interface XFWkwebView ()<WKNavigationDelegate,WKUIDelegate,WKScriptMessageHandler,UINavigationControllerDelegate,UINavigationBarDelegate,UIScrollViewDelegate,WKHybirdDelegate>


//设置加载进度条
@property (nonatomic,strong) UIProgressView *progressView;

//仅当第一次的时候加载本地JS
@property(nonatomic,assign) BOOL needLoadJSPOST;

//网页加载的类型
@property(nonatomic,assign) wkWebLoadType loadType;

//保存的网址链接
@property (nonatomic, copy) NSString *URLString;
//保存POST请求体
@property (nonatomic, copy) NSString *postData;
//保存请求链接
@property (nonatomic)NSMutableArray* snapShotsArray;
//返回按钮
@property (nonatomic)UIBarButtonItem* customBackBarItem;
//关闭按钮
@property (nonatomic)UIBarButtonItem* closeButtonItem;

//用来接收数据使用
@property (nonatomic,strong)WKHybirdModel *hybirdModel;

//记录 js 的名字
@property (nonatomic,strong)NSMutableArray *jsNames;

@end

@implementation XFWkwebView

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:animated];
	[[UIApplication sharedApplication]setStatusBarHidden:NO];
	_wkWebView.scrollView.delegate = self;
	BlackStatusBar;
}
-(void)viewWillDisappear:(BOOL)animated
{
	[super viewWillDisappear:animated];
	_wkWebView.scrollView.delegate = nil;
}
-(void)viewDidAppear:(BOOL)animated
{
	[super viewDidAppear:animated];
}
-(void)setTrackColor:(UIColor *)trackColor
{
	_trackColor = trackColor;
	[self.progressView setTrackTintColor:trackColor];
}
-(void)setProgressColor:(UIColor *)progressColor
{
	_progressColor = progressColor;
	[self.progressView setProgressTintColor:progressColor];
}
- (void)viewDidLoad {
    [super viewDidLoad];
	[self initNavView];
    self.view.backgroundColor = [UIColor whiteColor];
    //添加到主控制器上
    [self.view addSubview:self.wkWebView];
    //添加进度条
    [self.view addSubview:self.progressView];
    if (@available(iOS 11.0,*)) {
        self.wkWebView.scrollView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }else{
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
	//加载web页面
	if (!NullString(self.linkUrl)) {
		[self loadWebURLSring:self.linkUrl];
	}
	[self performSelector:@selector(webViewloadURLType) withObject:nil afterDelay:1];
	__weak typeof(self)ws = self;
	[self.view.lgPlaceholder setActionBlock:^(LgPlaceholderState state) {
		if (state != LgPlaceLoadingState) {
//			[ws showPlaceViewWithType:LgPlaceLoadingState];
			NSDictionary *requestDic = (NSDictionary *)ws.snapShotsArray.lastObject;
			NSURLRequest *request = requestDic[@"request"];
			if (request) {
				[ws.wkWebView loadRequest:request];
			}
		}
	}];
	if (!_hiddenLoading) {
		[self showPlaceViewWithType:LgPlaceLoadingState];
	}
	[self updateNavigationItems];
}
-(void)viewWillLayoutSubviews
{
	[super viewWillLayoutSubviews];
	self.view.lgPlaceholder.top = self.navView.maxY  + 2.0;
	self.progressView.frame = CGRectMake(0, self.navView.maxY, CGRectGetWidth(self.view.frame), 2);
	self.wkWebView.frame = CGRectMake(0, self.navView.maxY, CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame) - self.navView.maxY);
	[self.view bringSubviewToFront:self.progressView];
}
-(void)showPlaceViewWithType:(LgPlaceholderState)type
{
	self.view.lgPlaceholder.state = type;
}
- (void)roadLoadClicked
{
    [self.wkWebView reload];
}
-(void)navBackAction:(id)sender
{
   [self customBackItemClicked];
}
-(void)customBackItemClicked{
    if (self.wkWebView.goBack)
      {
        [self.wkWebView goBack];
    }else{
        [self.navigationController popViewControllerAnimated:YES];
    }
}
-(void)closeItemClicked{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark ================ 加载方式 ================

- (void)webViewloadURLType{
    switch (self.loadType) {
        case loadWebURLString:{
            //创建一个NSURLRequest 的对象
            NSURLRequest * Request_zsj = [NSURLRequest requestWithURL:[NSURL URLWithString:self.URLString] cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:15];
            //加载网页
            [self.wkWebView loadRequest:Request_zsj];
            break;
        }
        case loadWebHTMLString:{
            [self loadHostPathURL:self.URLString];
            break;
        }
        case POSTWebURLString:{
            // JS发送POST的Flag，为真的时候会调用JS的POST方法
            self.needLoadJSPOST = YES;
            //POST使用预先加载本地JS方法的html实现，请确认XFWKJSPOST存在
            [self loadHostPathURL:@"XFWKJSPOST"];
            break;
        }
    }
}

- (void)loadHostPathURL:(NSString *)url{
    //获取JS所在的路径
    NSString *path = [[NSBundle mainBundle] pathForResource:url ofType:@"html"];
    //获得html内容
    NSString *html = [[NSString alloc] initWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
    //加载js
    [self.wkWebView loadHTMLString:html baseURL:[[NSBundle mainBundle] bundleURL]];
}

// 调用JS发送POST请求
- (void)postRequestWithJS {
    // 拼装成调用JavaScript的字符串
    NSString *jscript = [NSString stringWithFormat:@"post('%@',{%@});", self.URLString, self.postData];
    // 调用JS代码
    [self.wkWebView evaluateJavaScript:jscript completionHandler:^(id object, NSError * _Nullable error) {

    }];
}
- (void)loadWebURLSring:(NSString *)string
{
    self.URLString = string;
    self.loadType = loadWebURLString;
}
- (void)loadWebHTMLSring:(NSString *)string
{
    self.URLString = string;
    self.loadType = loadWebHTMLString;
}
- (void)POSTWebURLSring:(NSString *)string postData:(NSString *)postData
{
    self.URLString = string;
    self.postData = postData;
    self.loadType = POSTWebURLString;
}
#pragma mark ================ 自定义返回/关闭按钮 ================

-(void)updateNavigationItems {
    if (self.wkWebView.canGoBack) {
		self.navigationItem.leftBarButtonItems = @[self.customBackBarItem,self.closeButtonItem];
    }else{
        [self.navigationItem setLeftBarButtonItems:@[self.customBackBarItem]];
    }
}
//请求链接处理
-(void)pushCurrentSnapshotViewWithRequest:(NSURLRequest*)request{
    //    NSLog(@"push with request %@",request);
    NSURLRequest* lastRequest = (NSURLRequest*)[[self.snapShotsArray lastObject] objectForKey:@"request"];
    
    //如果url是很奇怪的就不push
//    if ([request.URL.absoluteString isEqualToString:@"about:blank"]) {
//        //        NSLog(@"about blank!! return");
//        return;
//    }
    //如果url一样就不进行push
    if ([lastRequest.URL.absoluteString isEqualToString:request.URL.absoluteString]) {
        return;
    }
    UIView* currentSnapShotView = [self.wkWebView snapshotViewAfterScreenUpdates:YES];
    [self.snapShotsArray addObject:
     @{@"request":request,@"snapShotView":currentSnapShotView}];
}

#pragma mark ================ WKNavigationDelegate ================

//这个是网页加载完成，导航的变化
-(void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation{
	[self didFinishedLoad:webView];
	[webView evaluateJavaScript:@"document.documentElement.style.webkitUserSelect='none';" completionHandler:nil];
    /*
     主意：这个方法是当网页的内容全部显示（网页内的所有图片必须都正常显示）的时候调用（不是出现的时候就调用），，否则不显示，或则部分显示时这个方法就不调用。
     */
    // 判断是否需要加载（仅在第一次加载）
    if (self.needLoadJSPOST) {
        // 调用使用JS发送POST请求的方法
        [self postRequestWithJS];
        // 将Flag置为NO（后面就不需要加载了）
        self.needLoadJSPOST = NO;
    }
    // 获取加载网页的标题
    if (self.navigationItem.title==nil) {
          self.navigationItem.title = self.wkWebView.title;
    }
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
    [self updateNavigationItems];

	if (![Server netWorkAvailable]) {
		[self showPlaceViewWithType:LgPlaceNonetState];
		return;
	}
	NSString *bodyText = @"document.body.innerText";
	__weak typeof(self)ws = self;
	[webView evaluateJavaScript:bodyText completionHandler:^(id _Nullable data, NSError * _Nullable error) {
		if (data) {
			if ([data isKindOfClass:[NSString class]]) {
				NSString *bodyString = (NSString *)data;
				if (NullString(bodyString)) {
					[ws showPlaceViewWithType:LgPlaceNoDataState];
				}else{
					[ws showPlaceViewWithType:LgPlaceNormalState];
				}
			}
		}else{
			[ws showPlaceViewWithType:LgPlaceNoDataState];
		}
	}];
}

//开始加载
-(void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation{
    //开始加载的时候，让加载进度条显示
    self.progressView.hidden = NO;
	[self didStartLoading:webView];
}

//内容返回时调用
-(void)webView:(WKWebView *)webView didCommitNavigation:(WKNavigation *)navigation{}

//服务器请求跳转的时候调用
-(void)webView:(WKWebView *)webView didReceiveServerRedirectForProvisionalNavigation:(WKNavigation *)navigation{}

//服务器开始请求的时候调用
- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler {
    switch (navigationAction.navigationType) {
        case WKNavigationTypeLinkActivated: {
            [self pushCurrentSnapshotViewWithRequest:navigationAction.request];
            break;
        }
        case WKNavigationTypeFormSubmitted: {
            [self pushCurrentSnapshotViewWithRequest:navigationAction.request];
            break;
        }
        case WKNavigationTypeBackForward: {
            break;
        }
        case WKNavigationTypeReload: {
            break;
        }
        case WKNavigationTypeFormResubmitted: {
            break;
        }
        case WKNavigationTypeOther: {
            [self pushCurrentSnapshotViewWithRequest:navigationAction.request];
            break;
        }
        default: {
            break;
        }
    }
    [self updateNavigationItems];
    decisionHandler(WKNavigationActionPolicyAllow);
}

// 内容加载失败时候调用
-(void)webView:(WKWebView *)webView didFailProvisionalNavigation:(WKNavigation *)navigation withError:(NSError *)error{
    NSLog(@"页面加载超时");
	[self wkwebViewLoadFail:webView];
	[self updateNavigationItems];
	if (error.userInfo[@"NSErrorFailingURLStringKey"]) {
		self.progressView.hidden = YES;
		if ([Server netWorkAvailable]) {
			NSURL *url = [NSURL URLWithString:error.userInfo[@"NSErrorFailingURLStringKey"]];
			if ([[UIApplication sharedApplication]canOpenURL:url]) {
					//使用safir打开
				[self requestFailWithUrl:url];
			}
		}else{
			SHOW_MSG(@"请检查网络", 0.4);
		}
	}
	if (![Server netWorkAvailable]) {
		[self showPlaceViewWithType:LgPlaceNonetState];
		return;
	}
	NSString *bodyText = @"document.body.innerText";
	__weak typeof(self)ws = self;
	[webView evaluateJavaScript:bodyText completionHandler:^(id _Nullable data, NSError * _Nullable error) {
		if (data) {
			if ([data isKindOfClass:[NSString class]]) {
				NSString *bodyString = (NSString *)data;
				if (NullString(bodyString)) {
					[ws showPlaceViewWithType:LgPlaceNoDataState];
				}else{
					[ws showPlaceViewWithType:LgPlaceNormalState];
				}
			}
		}else{
			[ws showPlaceViewWithType:LgPlaceNoDataState];
		}
	}];
}

//跳转失败的时候调用
-(void)webView:(WKWebView *)webView didFailNavigation:(WKNavigation *)navigation withError:(NSError *)error{
	NSLog(@"跳转失败:%@",error);
}
//进度条
-(void)webViewWebContentProcessDidTerminate:(WKWebView *)webView{
	[self updateNavigationItems];
}

#pragma mark ================ WKUIDelegate ================

// 获取js 里面的提示
-(void)webView:(WKWebView *)webView runJavaScriptAlertPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(void))completionHandler{
	if ([self respondsToSelector:@selector(aleteWithMsg:withCompletion:)]) {
		[self aleteWithMsg:message withCompletion:completionHandler];
	}else{
		UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:message preferredStyle:UIAlertControllerStyleAlert];
		[alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
			completionHandler();
		}]];
		[self presentViewController:alert animated:YES completion:NULL];
	}
}

// js 信息的交流
-(void)webView:(WKWebView *)webView runJavaScriptConfirmPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(BOOL))completionHandler{

	if ([self respondsToSelector:@selector(aleteSureCancelWithMsg:withCompletion:)]) {
		[self aleteSureCancelWithMsg:message withCompletion:completionHandler];
	}else{
		UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:message preferredStyle:UIAlertControllerStyleAlert];
		[alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
		}]];
		[alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
			completionHandler(NO);
		}]];
		[self presentViewController:alert animated:YES completion:NULL];
	}
}

// 交互。可输入的文本。
-(void)webView:(WKWebView *)webView runJavaScriptTextInputPanelWithPrompt:(NSString *)prompt defaultText:(NSString *)defaultText initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(NSString * _Nullable))completionHandler{
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"textinput" message:@"请输入内容" preferredStyle:UIAlertControllerStyleAlert];
    [alert addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        //textField.textColor = [UIColor redColor];
    }];
    [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        completionHandler([[alert.textFields lastObject] text]);
    }]];
    
    [self presentViewController:alert animated:YES completion:NULL];
    
}

//KVO监听进度条
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    
    if ([keyPath isEqualToString:NSStringFromSelector(@selector(estimatedProgress))] && object == self.wkWebView) {
        [self.progressView setAlpha:1.0f];
        BOOL animated = self.wkWebView.estimatedProgress > self.progressView.progress;
        [self.progressView setProgress:self.wkWebView.estimatedProgress animated:animated];
        
        // Once complete, fade out UIProgressView
        if(self.wkWebView.estimatedProgress >= 1.0f) {
            [UIView animateWithDuration:0.3f delay:0.3f options:UIViewAnimationOptionCurveEaseOut animations:^{
                [self.progressView setAlpha:0.0f];
            } completion:^(BOOL finished) {
                [self.progressView setProgress:0.0f animated:NO];
            }];
			[self updateNavigationItems];
        }
    }
}

#pragma mark ================ WKScriptMessageHandler ================

//拦截执行网页中的JS方法
- (void)userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(WKScriptMessage *)message
{
    //服务器固定格式写法 window.webkit.messageHandlers.名字.postMessage(内容);
    //客户端写法 message.name isEqualToString:@"名字"]
	__weak typeof(self)ws = self;
	dispatch_async(dispatch_get_main_queue(), ^{
		[ws didReciveJsMessage:message.body withJsName:message.name];
	});
}
//子类中实现 ====
-(void)didReciveJsMessage:(id)data withJsName:(NSString *)name {}

#pragma mark ================ 懒加载 ================

- (WKWebView *)wkWebView{
    if (!_wkWebView) {
        //设置网页的配置文件
        WKWebViewConfiguration * Configuration = [[WKWebViewConfiguration alloc]init];
        //允许视频播放
        if (@available (iOS 9.0,*)) {
            Configuration.allowsAirPlayForMediaPlayback = YES;
        }
        // 允许在线播放
        Configuration.allowsInlineMediaPlayback = YES;
        // 允许可以与网页交互，选择视图
        Configuration.selectionGranularity = WKSelectionGranularityCharacter;
        // web内容处理池
        Configuration.processPool = [[WKProcessPool alloc] init];
        //自定义配置,一般用于 js调用oc方法(OC拦截URL中的数据做自定义操作)
        WKUserContentController * UserContentController = [[WKUserContentController alloc]init];
        
        // 添加消息处理，注意：self指代的对象需要遵守WKScriptMessageHandler协议，结束时需要移除
        // 是否支持记忆读取
        Configuration.suppressesIncrementalRendering = YES;
        // 允许用户更改网页的设置
        Configuration.userContentController = UserContentController;
        _wkWebView = [[WKWebView alloc] initWithFrame:CGRectMake(0, 0, MainScreen_Width, MainScreen_Height-NavBarHeight) configuration:Configuration];
        _wkWebView.opaque = NO; //去掉下面黑线
        _wkWebView.backgroundColor = [UIColor clearColor];
        // 设置代理
        _wkWebView.navigationDelegate = self;
		_wkWebView.scrollView.delegate = self;
        _wkWebView.UIDelegate = self;
        //kvo 添加进度监控
        [_wkWebView addObserver:self forKeyPath:NSStringFromSelector(@selector(estimatedProgress)) options:0 context:nil];
        //开启手势触摸
        _wkWebView.allowsBackForwardNavigationGestures = YES;
        // 设置 可以前进 和 后退
        //适应你设定的尺寸
        [_wkWebView sizeToFit];
		if (@available(iOS 9.0,*)) {
			_wkWebView.allowsLinkPreview = NO;
		}
    }
    return _wkWebView;
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
	[self webViewDidScroll:scrollView];
}
//子类可实现
-(void)webViewDidScroll:(UIScrollView *)scrollView{};

-(UIBarButtonItem*)customBackBarItem
{
    if (!_customBackBarItem) {
        UIImage* backItemHlImage = [[UIImage imageNamed:@"all_fahuia_btn"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        _customBackBarItem = [[UIBarButtonItem alloc]initWithImage:backItemHlImage style:UIBarButtonItemStylePlain target:self action:@selector(customBackItemClicked)];
    }
    return _customBackBarItem;
}

- (UIProgressView *)progressView{
    if (!_progressView) {
        _progressView = [[UIProgressView alloc]initWithProgressViewStyle:UIProgressViewStyleDefault];
        _progressView.frame = CGRectMake(0, 0, self.view.bounds.size.width, 2);
    }
    return _progressView;
}

-(UIBarButtonItem*)closeButtonItem
{
    if (!_closeButtonItem) {
        _closeButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"关闭" style:UIBarButtonItemStylePlain target:self action:@selector(closeItemClicked)];
        _closeButtonItem.tintColor = [UIColor blackColor];
    }
    return _closeButtonItem;
}

-(NSMutableArray*)snapShotsArray
{
    if (!_snapShotsArray) {
        _snapShotsArray = [NSMutableArray array];
    }
    return _snapShotsArray;
}

-(NSMutableArray *)jsNames {
	if (!_jsNames) {
		_jsNames = [[NSMutableArray alloc]init];
	 }
	return _jsNames;
}

-(WKHybirdModel *)hybirdModel {
	if (!_hybirdModel) {
		_hybirdModel = [[WKHybirdModel alloc]init];
		_hybirdModel.delegate = self;
	 }
	return _hybirdModel;
}
//注意，观察的移除
-(void)dealloc {
	[_wkWebView removeObserver:self forKeyPath:NSStringFromSelector(@selector(estimatedProgress))];
	[self removeJsFunction];

}
//移除所有的js
-(void)removeJsFunction
{
	for (NSString *name in self.jsNames) {
		[_wkWebView.configuration.userContentController removeScriptMessageHandlerForName:name];
	}
}
-(void)addJsFunctionName:(NSString *)name
{
	if (_wkWebView.configuration) {
		if ([self.jsNames containsObject:name]&&NullString(name)) return;
		[self.jsNames addObject:name];
		[_wkWebView.configuration.userContentController addScriptMessageHandler:self.hybirdModel name:name];
	}
}

// ====================================
-(void)didStartLoading:(WKWebView *)webView{};
-(void)didFinishedLoad:(WKWebView *)webView{};
-(void)wkwebViewLoadFail:(WKWebView *)webView{};
-(void)requestFailWithUrl:(NSURL *)url{};
// ====================================
@end
