//
//  XFWkwebView.h
//  WKWebView
//
//  Created by XiaoFeng on 2016/11/24.
//  Copyright © 2016年 XiaoFeng. All rights reserved.
//  QQ:1028708571 欢迎骚扰
//  github链接:https://github.com/XFIOSXiaoFeng/WKWebView

#import <UIKit/UIKit.h>
#import "BaseViewController.h"
#import "WKHybirdModel.h"

@interface XFWkwebView : BaseViewController

@property(nonatomic,assign)BOOL hiddenLoading;
//连接地址
@property (nonatomic,copy)NSString *linkUrl;
//未加载的颜色
@property (nonatomic,strong)UIColor *trackColor;
//进度的颜色
@property (nonatomic,strong)UIColor *progressColor;

@property (nonatomic, strong) WKWebView *wkWebView;
/**
 加载纯外部链接网页

 @param string URL地址
 */
- (void)loadWebURLSring:(NSString *)string;
/**
 加载本地网页
 @param string 本地HTML文件名
 */
- (void)loadWebHTMLSring:(NSString *)string;

/**
 加载外部链接POST请求(注意检查 XFWKJSPOST.html 文件是否存在 )
 @param string 需要POST的URL地址
 @param postData post请求块
 */
- (void)POSTWebURLSring:(NSString *)string postData:(NSString *)postData;

//=================================================
//添加js 交互的方法名
-(void)addJsFunctionName:(NSString *)name;
//接收到JS调用方法时候调用可以在子类中实现
-(void)didReciveJsMessage:(id)data withJsName:(NSString *)name;
//=================================================

//滚动视图滚动调用
-(void)webViewDidScroll:(UIScrollView *)scrollView;
//=================================================

//子类可以实现的方法
-(void)didStartLoading:(WKWebView *)webView;
-(void)didFinishedLoad:(WKWebView *)webView;
-(void)wkwebViewLoadFail:(WKWebView *)webView;
-(void)requestFailWithUrl:(NSURL *)url;

-(void)aleteWithMsg:(NSString *)msg withCompletion:(void(^)(void))completion;

-(void)aleteSureCancelWithMsg:(NSString *)msg withCompletion:(void(^)(BOOL))completion;

//=================================================

@end
