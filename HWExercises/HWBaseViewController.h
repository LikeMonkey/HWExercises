//
//  HWBaseViewController.h
//  HWExercises
//
//  Created by sxmaps_w on 2017/5/22.
//  Copyright © 2017年 wqb. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HWBaseViewController : UIViewController

//状态栏
@property (nonatomic, weak) UIImageView *statusView;

//导航栏标题
@property (nonatomic, copy) NSString *navTitle;

//网络改变回调Block，-1未知、0无网络、1蜂窝数据网络、2WiFi
@property (nonatomic, copy) void(^ network)(AFNetworkReachabilityStatus status);

//当前网络状态，-1未知、0无网络、1蜂窝数据网络、2WiFi
@property (nonatomic, assign) AFNetworkReachabilityStatus currentNetworkStatus;

//快捷设置导航栏标题，显示返回按钮，添加返回按钮点击事件
- (void)setNavTitle:(NSString *)title backAction:(SEL)action;

//快捷设置导航栏标题，显示返回按钮，默认返回按钮事件为返回上一级
- (void)addBackBtnAndTitle:(NSString *)title;

//返回事件
- (void)back;

//没有网络返回
- (void)noNetWorkBack;

//显示信息，并在设定延时后返回上级界面
- (void)backWithShowMessage:(NSString *)message afterDelay:(CGFloat)delay;

@end
