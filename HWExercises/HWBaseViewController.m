//
//  HWBaseViewController.m
//  HWExercises
//
//  Created by sxmaps_w on 2017/5/22.
//  Copyright © 2017年 wqb. All rights reserved.
//

#import "HWBaseViewController.h"
#import "HWNavTitleView.h"
#import "UIBarButtonItem+HW.h"

@interface HWBaseViewController ()

@end

@implementation HWBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //隐藏导航栏下面黑线
    [self getLineViewInNavigationBar:self.navigationController.navigationBar].hidden = YES;
    
    //设置导航栏背景图
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageWithColor:[UIColor blackColor]] forBarMetrics:UIBarMetricsDefault];
    
    //设置状态栏背景图
    [self creatStatusView];
    
    //设置状态栏文字颜色为白色
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent animated:NO];
    
    //默认视图背景色
    self.view.backgroundColor = KWhiteColor;
    
    //检测网络
    [self AFNetworkStatus];
}

//找到导航栏最下面黑线视图
- (UIImageView *)getLineViewInNavigationBar:(UIView *)view
{
    if ([view isKindOfClass:UIImageView.class] && view.bounds.size.height <= 1.0) return (UIImageView *)view;
    
    for (UIView *subview in view.subviews) {
        UIImageView *imageView = [self getLineViewInNavigationBar:subview];
        if (imageView) return imageView;
    }
    
    return nil;
}

//创建状态栏背景
- (void)creatStatusView
{
    UIImageView *statusView = [[UIImageView alloc] initWithFrame:CGRectMake(0, - 20, KMainW, 20)];
    statusView.image = [UIImage imageWithColor:[UIColor blackColor]];
    [self.navigationController.navigationBar addSubview:statusView];
    self.statusView = statusView;
}

//设置导航栏标题
- (void)setNavTitle:(NSString *)navTitle
{
    _navTitle = navTitle;
    
    self.navigationItem.titleView = [[HWNavTitleView alloc] initWithString:navTitle frame:CGRectMake(0, 0, 200, 44)];
}

//快捷设置导航栏标题，显示返回按钮，添加返回按钮点击事件
- (void)setNavTitle:(NSString *)title backAction:(SEL)action
{
    [self setNavTitle:title];
    
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithImage:[UIImage imageNamed:@"navbar_back"] andHighlightedImage:[UIImage imageNamed:@"navbar_back"] target:self action:action];
}

//快捷设置导航栏标题，显示返回按钮，默认返回按钮事件为返回上一级
- (void)addBackBtnAndTitle:(NSString *)title
{
    if (title != nil) [self setNavTitle:title];

    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithImage:[UIImage imageNamed:@"navbar_back"] andHighlightedImage:[UIImage imageNamed:@"navbar_back"] target:self action:@selector(back)];
}

//默认返回事件
- (void)back
{
    [self.navigationController popViewControllerAnimated:YES];
}

//没有网络返回
- (void)noNetWorkBack
{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        if (self.currentNetworkStatus < 1) {
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [self.navigationController popViewControllerAnimated:YES];
            });
        }
    });
}

//显示信息，并在设定延时后返回上级界面
- (void)backWithShowMessage:(NSString *)message afterDelay:(CGFloat)delay
{
    [HWProgressHUD showMessage:message];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delay * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self back];
    });
}

//检测网络
- (void)AFNetworkStatus
{
    //创建网络监测者
    AFNetworkReachabilityManager *manager = [AFNetworkReachabilityManager sharedManager];
    
    [manager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        _currentNetworkStatus = status;
        if (_network) _network(status);
        switch (status) {
            case AFNetworkReachabilityStatusNotReachable:
                [HWProgressHUD showMessage:@"哎呀，没有网络啦~"];
                break;
                
            default:
                break;
        }
    }] ;
    
    //开始检测
    [manager startMonitoring];
}

@end
