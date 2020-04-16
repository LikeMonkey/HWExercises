//
//  AppDelegate.m
//  ZhongQiBrand
//
//  Created by ios2 on 2019/9/16.
//  Copyright © 2019 CY. All rights reserved.
//

#import "AppDelegate.h"
#import "WkCrashProgress.h"
#import "AppDelegate+Thirdpart.h"
#import "GuideViewController.h"
#import "CommonTools.h"
#import "BaseModel.h"

@interface AppDelegate ()

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [NSThread sleepForTimeInterval:0.5];

//    [self wordOfCommand];  //检查是剪切板文字
//   [self ceckNetWork];         //开启网络检测进行版本检测

    [WkCrashProgress progressWKContentViewCrash];  //防止WKwebView 崩溃
    [self initUMSDKOptions:launchOptions];         //开启友盟分享SDK
    
    LightStatusBar
    [[UIApplication sharedApplication]setStatusBarHidden:NO];
    [[UIView appearance]setExclusiveTouch:YES];
    
    [IQKeyboardManager sharedManager].enable = YES;
    [IQKeyboardManager sharedManager].overrideKeyboardAppearance = YES;
    [IQKeyboardManager sharedManager].shouldResignOnTouchOutside = YES;
    
    UIWindow *window = [[UIWindow alloc]init];
    window.frame = [UIScreen mainScreen].bounds;
    window.backgroundColor = [UIColor whiteColor];
    [window makeKeyAndVisible];
    [window makeKeyWindow];
    self.window = window;
    
    if (@available(iOS 11.0, *)) {
        [UIScrollView appearance].contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        [UITableView appearance].estimatedRowHeight = 0;
        [UITableView appearance].estimatedSectionFooterHeight = 0;
        [UITableView appearance].estimatedSectionHeaderHeight = 0;
    }
    
    if (!IS_Guide) {
        GuideViewController *guideVc = [[GuideViewController alloc]init];
        self.window.rootViewController =guideVc;
    }else{
        Class vcClass = NSClassFromString(@"BrandTabBarController");
        vcClass = (vcClass == nil )?[UITabBarController class]:vcClass;
        UIViewController *rootVc = [[vcClass alloc]init];
        self.window.rootViewController = rootVc;
    }
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

-(void)ceckNetWork {
    // 监听网络状况
    [self checkVerson:NO];
    AFNetworkReachabilityManager *mgr = [AFNetworkReachabilityManager sharedManager];
    WS(ws);
    [mgr setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        if (status != AFNetworkReachabilityStatusUnknown) {
            // 查看商店是否有新版本
            [ws checkVerson:YES];
        }
    }];
    [mgr startMonitoring];
}

-(void)checkVerson:(BOOL)isNetChange {
    if (self.isUpdateVerson) {
        [[CommonTools shareInstance]versionForAppid:APP_ID andIsMast:YES andBlock:nil];
    }else{
        NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
        NSString *app_Version = [infoDictionary objectForKey:@"CFBundleShortVersionString"];
        TokenModel *tokenModel = [TokenModel new];
        NSMutableDictionary *params = [tokenModel.dictionary mutableCopy];
        params[@"version"] = app_Version;
        [RequestBaseTool getUrlStr:AppendAPI(APPURL_prefix, @"") andParms:params andCompletion:^(id obj) {
            
            BaseModel *model = [[BaseModel alloc]initWithDictionary:obj];
            if ([model.status isEqualToString:@"1"]) {
                NSDictionary *data = (NSDictionary *)obj[@"data"];
                NSString *forceupdate = [NSString stringWithFormat:@"%@",data[@"forceupdate"]];
                if ([forceupdate isEqualToString:@"1"]) {
                    self.isUpdateVerson = YES;
                    [[CommonTools shareInstance]versionForAppid:APP_ID andIsMast:YES andBlock:nil];
                }else{
                    if (!isNetChange) {
                        [[CommonTools shareInstance]versionForAppid:APP_ID andIsMast:NO andBlock:nil];
                    }
                }
            }
        } Error:^(NSError *errror) {
        }];
    }
}
@end


