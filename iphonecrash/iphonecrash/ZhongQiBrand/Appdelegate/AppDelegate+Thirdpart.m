//
//  AppDelegate+Thirdpart.m
//  VoteCloud
//
//  Created by ios2 on 2019/8/11.
//  Copyright © 2019 CY. All rights reserved.
//

#import "AppDelegate+Thirdpart.h"
#import "NSURL+Params.h"
#import "UMSocialManager+UMLogin.h"
//#import <AlipaySDK/AlipaySDK.h>
#import <Bugly/Bugly.h>

@implementation AppDelegate (Thirdpart)

-(void)initUMSDKOptions:(NSDictionary *)launchOptions
{
    NSString *channel = @"App Store";
#if DEBUG
    channel = @"Development";
#endif
    BuglyConfig *config = [[BuglyConfig alloc]init];
    config.channel = channel;
    NSString *appid = @"74c1f1a9bc";
    [Bugly startWithAppId:appid config:config];
    [UMConfigure initWithAppkey:USHARE_APPKEY channel:channel];
    
    // Push组件基本功能配置
    UMessageRegisterEntity * entity = [[UMessageRegisterEntity alloc] init];
    //type是对推送的几个参数的选择，可以选择一个或者多个。默认是三个全部打开，即：声音，弹窗，角标
    entity.types = UMessageAuthorizationOptionBadge|UMessageAuthorizationOptionSound|UMessageAuthorizationOptionAlert;
    if (@available(iOS 10.0, *)) {
        [UNUserNotificationCenter currentNotificationCenter].delegate=self;
    } else {
    }
    [UMessage registerForRemoteNotificationsWithLaunchOptions:launchOptions Entity:entity     completionHandler:^(BOOL granted, NSError * _Nullable error) {
        if (granted) {
        }else{
        }
    }];
    
    //配置分享参数  ------
    [self configUSharePlatforms];
}
- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
{
    if ([url.scheme isEqualToString:@"520Alipay"]) {
        [self alipayResponse:url];
        return YES;
    }else if ([url.scheme isEqualToString:@"Vvotecloud"]) {
        [self openVoteWithUrl:url];
    }else{
        if ([url.scheme isEqualToString:WX_APPKEY]){
            if (![url.host containsString:@"wapoauth"]) {
                [WXApi handleOpenURL:url delegate:self];
            }
        } else{
            BOOL isTure = [[UMSocialManager defaultManager] handleOpenURL:url];
            if (!isTure) {
                if ([url.scheme isEqualToString:WX_APPKEY]) {
                    return  [WXApi handleOpenURL:url delegate:self];
                }
            }
        }
    }
    return YES;
}
// NOTE: 9.0以后使用新API接口
- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary *)options
{
    if ([url.scheme isEqualToString:@"520Alipay"]) {
        [self alipayResponse:url];
        return YES;
    }else if ([url.scheme isEqualToString:@"vvotecloud"]) {
        [self openVoteWithUrl:url];
    }else{
        if ([url.scheme isEqualToString:WX_APPKEY]){
            if (![url.host containsString:@"wapoauth"]) {
                [WXApi handleOpenURL:url delegate:self];
            }
        } else{
            BOOL isTure = [[UMSocialManager defaultManager] handleOpenURL:url options:options];
            if (!isTure) {
                if ([url.scheme isEqualToString:WX_APPKEY]) {
                    return  [WXApi handleOpenURL:url delegate:self];
                }
            }
        }
    }
    return YES;
}

-(void)alipayResponse:(NSURL*)url
{
    //    [[AlipaySDK defaultService]processOrderWithPaymentResult:url standbyCallback:^(NSDictionary *resultDic) {
    //        NSString *resultStatus = [NSString stringWithFormat:@"%@",resultDic[@"resultStatus"]];
    //        if ([resultStatus isEqualToString:@"9000"]) {
    //            //支付支付成功
    //            [[NSNotificationCenter defaultCenter]postNotificationName:Aliy_PayResultNotificationName object:@"1"];
    //        }else{
    //            //支付失败
    //            [[NSNotificationCenter defaultCenter]postNotificationName:Aliy_PayResultNotificationName object:@"0"];
    //        }
    //    }];
}
	//需要在 application:continueUserActivity:restorationHandler:中调用。
- (BOOL)application:(UIApplication *)application continueUserActivity:(NSUserActivity *)userActivity restorationHandler:(void (^)(NSArray<id<UIUserActivityRestoring>> * _Nullable))restorationHandler
{
	[WXApi handleOpenUniversalLink:userActivity delegate:self];
	return YES;
}
-(void)onResp:(BaseResp*)resp {
    if ([resp isKindOfClass:[SendAuthResp class]]) {
        if (resp.errCode == WXErrCodeUserCancel) {
            SHOW_MSG(@"取消登录", 0.5);
        }else if (resp.errCode == WXErrCodeAuthDeny){
            SHOW_MSG(@"验证失败", 0.5);
        }else if (resp.errCode == WXSuccess){
            UMSocialManager * manager = [UMSocialManager defaultManager];
            if (manager.WxLoginResponse) {
                manager.WxLoginResponse(resp);
            }
        }
    }else if([resp isKindOfClass:NSClassFromString(@"PayResp")]){
        [[NSNotificationCenter defaultCenter]postNotificationName:WX_PayResultNotificationName object:resp];
    }
}
-(void)openVoteWithUrl:(NSURL *)url
{
    if (!IS_Guide)return;
    NSDictionary *parmart =  [url parameter];
    if ([url.host isEqualToString:@"520votecloud.com"]) {
        NSString *sid = [NSString stringWithFormat:@"%@",parmart[@"sid"]];
        if (!NullString(sid)) {
            UIViewController *vc = [[NSClassFromString(@"MainVoteViewController") alloc]init];
            if (vc) {
                [vc setValue:sid forKey:@"voteId"];
                UINavigationController *nav  = [UIApplication sharedApplication].visibleNavigationController;
                [nav pushViewController:vc animated:YES];
            }
        }
    }
    NSLog(@"连接 binghuodao5g 访问地址 http://192.168.1.22 通过连接打开APP 测试 : |%@",parmart);
}

#pragma mark 获取到devicetoken
- (void)application:(UIApplication *)application
didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    //拿到deviceToken
    if (deviceToken) {
        if (![deviceToken isKindOfClass:[NSData class]]) return;
        NSString *token;
        const unsigned *tokenBytes = [deviceToken bytes];
        token = [NSString stringWithFormat:@"%08x%08x%08x%08x%08x%08x%08x%08x",
                 ntohl(tokenBytes[0]), ntohl(tokenBytes[1]), ntohl(tokenBytes[2]),
                 ntohl(tokenBytes[3]), ntohl(tokenBytes[4]), ntohl(tokenBytes[5]),
                 ntohl(tokenBytes[6]), ntohl(tokenBytes[7])];
        if (token) {
            [[NSUserDefaults standardUserDefaults] setObject:token forKey:@"Token"];
            [[NSUserDefaults standardUserDefaults] synchronize];
        }
    }
    if(IS_LOGIN){
        NSString *userId = USER_ID?USER_ID:@"";
        if (userId) {
            [UMessage setAlias:userId type:@"520vote" response:^(id  _Nullable responseObject, NSError * _Nullable error) {
                NSLog(@"绑定结果");
            }];
        }
    }
    [UMessage registerDeviceToken:deviceToken];                  //注册友盟deviceToken
}
- (void)configUSharePlatforms {
    [WXApi registerApp:WX_APPKEY universalLink:@"https://api.voteyun.com/"];
    [UMSocialGlobal shareInstance].isUsingHttpsWhenShareContent = NO;
    /* 设置微信的appKey和appSecret */
    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_WechatSession appKey:WX_APPKEY appSecret:WX_APPSECRET redirectURL:@"http://mobile.umeng.com/social"];
    /*
     * 移除相应平台的分享，如微信收藏
     */
    [[UMSocialManager defaultManager] removePlatformProviderWithPlatformTypes:@[@(UMSocialPlatformType_WechatFavorite)]];
}
-(BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url
{
    return  [[UMSocialManager defaultManager] handleOpenURL:url];
}
#pragma aut 点击推送的情况
-(void)didReceiveNotificationResponse:(NSDictionary *)response
                withCompletionHandler:(void (^)(UNNotificationPresentationOptions))completionHandler
API_AVAILABLE(ios(10.0)){
    [self receiveNotificationWithNotiInfo:response];
}
//iOS10以下使用这两个方法接收通知，
-(void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler
{
    if([[[UIDevice currentDevice] systemVersion]intValue] < 10){
        [UMessage setAutoAlert:NO];
        [UMessage didReceiveRemoteNotification:userInfo];
        [self receiveNotificationWithNotiInfo:userInfo];
        completionHandler(UIBackgroundFetchResultNewData);
    }
}
//iOS10新增：处理前台收到通知的代理方法
-(void)userNotificationCenter:(UNUserNotificationCenter *)center willPresentNotification:(UNNotification *)notification withCompletionHandler:(void (^)(UNNotificationPresentationOptions))completionHandler API_AVAILABLE(ios(10.0)){
    
    NSDictionary * userInfo = notification.request.content.userInfo;
    if([notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
        [UMessage setAutoAlert:NO];
        //必须加这句代码
        [UMessage didReceiveRemoteNotification:userInfo];
        [self foregroundReceiveNotificationWithNotiInfo:userInfo];
    }else{
        [self foregroundReceiveNotificationWithNotiInfo:userInfo];
    }
    completionHandler(UNNotificationPresentationOptionSound);
}

//iOS10新增：处理后台点击通知的代理方法
-(void)userNotificationCenter:(UNUserNotificationCenter *)center didReceiveNotificationResponse:(UNNotificationResponse *)response withCompletionHandler:(void (^)())completionHandler API_AVAILABLE(ios(10.0)){
    NSDictionary * userInfo = response.notification.request.content.userInfo;
    if([response.notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
        [UMessage didReceiveRemoteNotification:userInfo];
        //用户触发
        [self receiveNotificationWithNotiInfo:userInfo];
    }else{
        //不是用户触发
        [self receiveNotificationWithNotiInfo:userInfo];
    }
    completionHandler(UNNotificationPresentationOptionSound);
}
////后台接收到推送
- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo
{
    [UMessage didReceiveRemoteNotification:userInfo];
    [self receiveNotificationWithNotiInfo:userInfo];
}

-(void)foregroundReceiveNotificationWithNotiInfo:(id)userInfo
{
    //应用在前台推送
    [[NSNotificationCenter defaultCenter]postNotificationName:@"didReceviPushNotificationServer" object:nil];
    NSLog(@"应用在前台接收到推送");
}
-(void)receiveNotificationWithNotiInfo:(id)userInfo
{
    NSLog(@"应用在后台点击推送响应");
}


@end

