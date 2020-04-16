//
//  WDAlert.h
//  WineComment
//
//  Created by 何伟东 on 13-7-5.
//  Copyright (c) 2013年 何伟东. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MBProgressHUD.h"

@interface WDAlert : NSObject<MBProgressHUDDelegate>{
    MBProgressHUD *HUD;
}
+ (WDAlert *)shareAlert;

-(void)showProgressInWindow;

//必须设置了进度类型才可设置
-(void)updateProgress:(CGFloat)progress;


- (void)showLodingWithTitle:(NSString*)title message:(NSString*)message withView:(UIView *)view;
- (void)showLodingWithTitle:(NSString*)title withView:(UIView *)view;
- (void)showLodingWithTitle:(NSString*)title message:(NSString*)message;
- (void)showLodingWithTitle:(NSString*)title;
- (void)showLodingWithTitle:(NSString*)title delay:(NSTimeInterval)time;
- (void)hiddenHUD;

+ (void)alertWithMessage:(NSString *)message title:(NSString*)title;
+ (void)alertWithMessage:(NSString *)message;
+ (void)showAlertWithMessage:(NSString*)message time:(NSTimeInterval)time;
+ (void) hideTabBar:(UITabBarController *) tabbarcontroller;
+ (void) showTabBar:(UITabBarController *) tabbarcontroller;
@end

//显示 Toast  消息
#define SHOW_MSG(msg,s){\
[WDAlert  showAlertWithMessage:msg time:s];\
}

//显示加载中的HUD
#define SHOW_LOAD {\
WDAlert * alert = [WDAlert shareAlert];\
[alert showLodingWithTitle:@""];\
}

//在某个View 上显示
#define SHOW_LOAD_INVIEW(msg,v){\
WDAlert * alert = [WDAlert shareAlert];\
[alert showLodingWithTitle:msg];\
}
//隐藏转子 ---
#define HIDDEN_HUD {\
WDAlert * alert = [WDAlert shareAlert];\
[alert hiddenHUD];\
}

#define SHOW_Progress {\
WDAlert * hud = [WDAlert shareAlert];\
[hud showProgressInWindow];\
}

#define UPDATE_Pogress(s) {\
WDAlert * alete = [WDAlert shareAlert];\
[alete updateProgress:s];\
}
