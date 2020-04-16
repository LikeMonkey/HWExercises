//
//  ZhongQiBrandCloudMacro.h
//  ZhongQiBrand
//
//  Created by 孙程 on 2019/9/16.
//  Copyright © 2019 CY. All rights reserved.
//

#ifndef ZhongQiBrandCloudMacro_h
#define ZhongQiBrandCloudMacro_h

#if __OBJC__

#import "DeviceTool.h"

#define WS(ws) __weak __typeof(self) ws = self
#define SS(ss) __strong __typeof(ws)ss = ws

#define LightStatusBar \
UIStatusBarStyle style = [UIApplication sharedApplication].statusBarStyle;\
if (style == UIStatusBarStyleDefault) {\
[[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent animated:YES];\
}\

#define BlackStatusBar \
UIStatusBarStyle style = [UIApplication sharedApplication].statusBarStyle;\
if (style == UIStatusBarStyleLightContent) {\
[[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault animated:YES];\
}\

#define kGetImage(imageName) [UIImage imageNamed:imageName inBundle:nil compatibleWithTraitCollection:nil]
#define kStringWithFormat(obj) [NSString stringWithFormat:@"%@",obj]

// ================  布局 ==================

#define TabBarHeight ([DeviceTool isPhoneX]?83:49)

#define NavBarHeight ([DeviceTool isPhoneX]?88:64)

#define MAINScreenHeight [UIScreen mainScreen].bounds.size.height
#define MAINScreenWidth [UIScreen mainScreen].bounds.size.width

#define scaleX MIN([UIScreen mainScreen].bounds.size.width,[UIScreen mainScreen].bounds.size.height)/375.0f
#define scaleY MAX([UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)/667.0f

#define TabbarSafeBottomMargin ([DeviceTool isPhoneX] ? 34.f : 0.f)

//像素比例转化
#define px_scale(x) (x)/2.0f*scaleX

//数据判空 ------------
#define NullString(str) ([str isKindOfClass:[NSNull class]] || str == nil || [str length] < 1 ? YES : NO )

#define ArrayIsEmpty(array) (array == nil || [array isKindOfClass:[NSNull class]] || array.count == 0)

#define DicIsEmpty(dict) ([dict isKindOfClass:[NSNull class]] || [dict isEqual:[NSNull null]])
// 主题颜色
#define  ThemeColor ([UIColor colorWithHexString:@"#E10000"])

// 大版本号
#define AppVersion [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"]

/// 获取一个像素
#define PixelOne [DeviceTool pixelOne]

// 用户信息
#define IsLogin  @"islogin"
#define UserName @"username"
#define UserIcon @"usericon"
#define UAuth @"uauth"
#define UserId @"UserId"
#define UopenId @"openId"
#define UserChatNum @"userChatNum"

#define U_AUTH   [[NSUserDefaults standardUserDefaults] objectForKey:@"uauth"]
#define IS_LOGIN  [[NSUserDefaults standardUserDefaults] boolForKey:@"islogin"]
#define USER_ID   [[NSUserDefaults standardUserDefaults] objectForKey:@"UserId"]
#define USER_NAME [[NSUserDefaults standardUserDefaults] objectForKey:@"username"]
#define USER_ICON [[NSUserDefaults standardUserDefaults] objectForKey:@"usericon"]
#define USER_ChAT_NUM [[NSUserDefaults standardUserDefaults] objectForKey:@"userChatNum"]

#define IS_PayAgreenment [[NSUserDefaults standardUserDefaults]boolForKey:@"isPayAgreenment"]

#define SavePayAgreenment {\
[[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"isPayAgreenment"];\
[[NSUserDefaults standardUserDefaults] synchronize];\
}

#define SaveDissPayAgreenment {\
[[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"isPayAgreenment"];\
[[NSUserDefaults standardUserDefaults] synchronize];\
}

#define Review_Code [[NSUserDefaults standardUserDefaults]objectForKey:@"review"]

#define IS_Guide \
[[NSUserDefaults standardUserDefaults]boolForKey:@"Vote_IS_guide"]

#define SAVE_Guide \
[[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"Vote_IS_guide"];\
[[NSUserDefaults standardUserDefaults] synchronize];


#define Nex_vote_timeLine [[NSUserDefaults standardUserDefaults]objectForKey:@"last_voteTimeLine"]


//正式环境下关闭打印

#ifdef DEBUG
#define NSLog(fmt, ...) NSLog((@"%s [Line %d] " fmt), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__);
#else
#define NSLog(...);
#endif


#endif

#endif /* ZhongQiBrandCloudMacro_h */
