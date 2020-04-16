//
//  LoginViewController.m
//  ZhongQiBrand
//
//  Created by ios2 on 2019/9/18.
//  Copyright © 2019 CY. All rights reserved.
//

#import "LoginViewController.h"
#import <WXApi.h>
#import <UMShare/UMShare.h>
#import "UMSocialManager+UMLogin.h"
#import "LoginInfoModel.h"
@interface LoginViewController ()

@property (nonatomic, strong) UIImageView *icon;
@property (nonatomic, strong) UILabel *descripLabel;
@property (nonatomic, strong) UIButton *loginBtn;
@property (nonatomic, strong) UIButton *chooseBtn;
@property (nonatomic, strong) UILabel *seeAgreementLabel;
@property (nonatomic, strong) UIButton *closeBtn;
@property (nonatomic, strong)NSURLSessionDataTask *task;

@end

@implementation LoginViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    BlackStatusBar;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIImage *image = [UIImage imageNamed:@"login_bg_img"];
    self.view.layer.contents = (id)image.CGImage;
    [self setupUI];
}

/** 视图初始化 */
- (void)setupUI {
    
    BlackStatusBar
    [self.view addSubview:self.closeBtn];
    [self.view addSubview:self.icon];
    [self.view addSubview:self.descripLabel];
    [self.view addSubview:self.loginBtn];
    [self.view addSubview:self.chooseBtn];
    [self.view addSubview:self.seeAgreementLabel];
    
    [self.closeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15 * scaleX);
        make.top.mas_equalTo([DeviceTool isPhoneX] ? 55 * scaleX : 31 * scaleX);
        make.width.height.mas_equalTo(22 * scaleX);
    }];
    
    [self.icon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(0);
        make.top.mas_equalTo([DeviceTool isPhoneX] ? 139 * scaleX : 115 * scaleX);
        make.width.mas_equalTo(120 * scaleX);
        make.height.mas_equalTo(151 * scaleX);
    }];
    
    [self.descripLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(0);
        make.top.equalTo(self.icon.mas_bottom).offset(26 * scaleX);
        make.left.mas_equalTo(15 * scaleX);
        make.right.mas_equalTo(-15 * scaleX);
    }];
    
    [self.loginBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(246 * scaleX);
        make.height.mas_equalTo(60 * scaleX);
        make.centerX.mas_equalTo(0);
        make.top.equalTo(self.descripLabel.mas_bottom).offset(120 * scaleX);
    }];

    [self.chooseBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(95 * scaleX);
        make.top.equalTo(self.loginBtn.mas_bottom).offset(10 * scaleX);
        make.width.mas_equalTo(10 * scaleX);
        make.height.mas_equalTo(10 * scaleX);
    }];
    
    [self.seeAgreementLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.loginBtn.mas_bottom).offset(5 * scaleX);
        make.centerX.equalTo(self.loginBtn);
        make.width.mas_equalTo(200 * scaleX);
    }];
}

-(void)wechatLogin
{
    if ([WXApi isWXAppInstalled]) {
        [[UMSocialManager defaultManager]getUserInfoWithPlatform:(UMSocialPlatformType_WechatSession) currentViewController:self completion:^(id result, NSError *error) {
            if (error) {
                if (error.code == 2009) {
                    SHOW_MSG(@"取消登录", 0.5);
                }else{
                    SHOW_MSG(@"登录失败", 0.5);
                }
            }
            else{
                NSLog(@"--");
            }
        }];
    }else{
        SendAuthReq* req =[[SendAuthReq alloc ] init ] ;
        req.scope = @"snsapi_userinfo" ;
        req.state = @"中企品牌网" ;
        req.openID = @"wxe7f5625252e90280";
		[WXApi sendAuthReq:req viewController:self delegate:[UIApplication sharedApplication].delegate completion:^(BOOL success) {
			NSLog(@"输出回调");
		}];
    }
    __weak typeof(self)ws = self;
    [[UMSocialManager defaultManager]setWxLoginResponse:^(id responde) {
        if ([responde isKindOfClass:[SendAuthResp class]]) {
            SendAuthResp *auth = (SendAuthResp *)responde;
            [ws login:auth.code andIsReview:NO];
        }
    }];
}

-(void)saveUserInfo
{
	[[NSUserDefaults standardUserDefaults]setObject:@"dc018daf835c7f98e8fbb8a4e1b24d6e" forKey:UAuth];
	[[NSUserDefaults standardUserDefaults]setObject:@"oJkebv4enxCzhGxPTMFmsSyo6nrE" forKey:UopenId];
	[[NSUserDefaults standardUserDefaults]setObject:@"26" forKey:UserId];
	[[NSUserDefaults standardUserDefaults] setBool:YES forKey:IsLogin];
	[[NSUserDefaults standardUserDefaults]synchronize]; //同步更新
	[self dismissViewControllerAnimated:YES completion:nil];
}
- (void)login:(NSString *)code andIsReview:(BOOL)isReview {
#if DEBUG
	[self saveUserInfo]; //测试数据
	return;
#endif

    TokenModel *token =[TokenModel new];
    token.method = @"login";
    NSMutableDictionary *mDic = [token.dictionary mutableCopy];
    mDic[@"code"] = code;
    !_task?:[_task cancel];
	__weak typeof(self)ws = self;
    _task =  [RequestBaseTool postUrlStr:AppendAPI(APPURL_prefix, Login_prefix)
                                andParms:mDic
                           andCompletion:^(id obj) {
                               NSLog(@"输出结果：|%@",obj);
                               LoginInfoModel *model = [[LoginInfoModel alloc]initWithDictionary:obj];
							   if ([model.status isEqualToString:@"1"]) {
								   [[NSUserDefaults standardUserDefaults]setObject:model.auth forKey:UAuth];
								   [[NSUserDefaults standardUserDefaults]setObject:model.openid forKey:UopenId];
								   [[NSUserDefaults standardUserDefaults]setObject:model.ouid forKey:UserId];
								   [[NSUserDefaults standardUserDefaults] setBool:YES forKey:IsLogin];
								   [[NSUserDefaults standardUserDefaults]synchronize]; //同步更新
								   [ws dismissViewControllerAnimated:YES completion:nil];
							   }else{
								   SHOW_MSG(model.msg, 0.5);
							   }
                           } Error:^(NSError *errror) {
                               if (errror.code != -900) {
                                   SHOW_MSG(@"请重试", 0.5);
                               }
                           }];
}

- (void)btnClik:(UIButton *)btn {
    if (btn.tag == 100) {
        // 微信登录
        [self wechatLogin];
    }
    else if (btn.tag == 101){
        // 登录即表示同意
    }
    else if (btn.tag == 102){
        // 查看协议
       
    }
    else if (btn.tag == 103){
        // 退出
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}

#pragma mark - 懒加载
- (UIImageView *)icon{
    if (!_icon) {
        _icon = [[UIImageView alloc] init];
        _icon.image = [UIImage imageNamed:@"login_logo_img"];
        _icon.contentMode = UIViewContentModeScaleAspectFit;
    }
    return _icon;
}

- (UILabel *)descripLabel {
    if (!_descripLabel) {
        _descripLabel = [[UILabel alloc]init];
        _descripLabel.textColor = [UIColor blackColor];
        _descripLabel.textAlignment = NSTextAlignmentCenter;
        _descripLabel.text = @"登录后即可继续当前操作";
        _descripLabel.font = [UIFont systemFontOfSize:17];
    }
    return _descripLabel;
}

- (UIButton *)loginBtn{
    if (!_loginBtn) {
        
        _loginBtn = [[UIButton alloc] init];
        
        [_loginBtn setTitle:@"微信快速登录" forState:UIControlStateNormal];
        _loginBtn.titleLabel.font = [UIFont boldSystemFontOfSize:20];
        [_loginBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_loginBtn setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];

        [_loginBtn setBackgroundImage:[UIImage imageNamed:@"wechat_login_btn"] forState:UIControlStateNormal];
        _loginBtn.contentVerticalAlignment = UIControlContentVerticalAlignmentTop;
        _loginBtn.titleEdgeInsets = UIEdgeInsetsMake(13 * scaleX, 0, 0, 0);
		_loginBtn.tag = 100;
        [_loginBtn addTarget:self action:@selector(btnClik:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _loginBtn;
}

- (UIButton *)chooseBtn {
    if (!_chooseBtn) {
        _chooseBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_chooseBtn setImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
        [_chooseBtn setImage:[UIImage imageNamed:@""] forState:UIControlStateSelected];
        _chooseBtn.tag = 101;
        [_chooseBtn addTarget:self action:@selector(btnClik:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _chooseBtn;
}

- (UILabel *)seeAgreementLabel {
    if (!_seeAgreementLabel) {
        _seeAgreementLabel = [[UILabel alloc]init];
        _seeAgreementLabel.textAlignment = NSTextAlignmentLeft;
        _seeAgreementLabel.font = [UIFont systemFontOfSize:13.f];
        
        NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:@"同意《中企品牌网服务协议》"];
        [str addAttribute:NSForegroundColorAttributeName value:[UIColor blackColor] range:NSMakeRange(0,2)];
        
        [str addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithHexString:@"#FE534D"] range:NSMakeRange(2,11)];
        _seeAgreementLabel.attributedText = str;
    }
    return _seeAgreementLabel;
}

- (UIButton *)closeBtn{
    if (!_closeBtn) {
        _closeBtn = [[UIButton alloc] init];
        [_closeBtn setImage:[UIImage imageNamed:@"login_close_icon"] forState:UIControlStateNormal];
        _closeBtn.tag = 103;
        [_closeBtn addTarget:self action:@selector(btnClik:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _closeBtn;
}

@end
