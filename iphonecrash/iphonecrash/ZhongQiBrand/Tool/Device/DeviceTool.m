//
//  DeviceTool.m
//  VoteCloud
//
//  Created by ios2 on 2019/8/10.
//  Copyright © 2019 CY. All rights reserved.
//

#import "DeviceTool.h"

@implementation DeviceTool

+(BOOL)isPhoneX {
	BOOL iPhoneX = NO;
	if (UIDevice.currentDevice.userInterfaceIdiom != UIUserInterfaceIdiomPhone) {
		//判断是否是手机
		return iPhoneX;
	}
	if (@available(iOS 11.0, *)) {
		UIWindow *mainWindow = [[[UIApplication sharedApplication] delegate] window];
		if (mainWindow.safeAreaInsets.bottom > 0.0) {
			iPhoneX = YES;
		}
	}
	return iPhoneX;
}

static CGFloat pixelOne = -1.0f;
+ (CGFloat)pixelOne {
    if (pixelOne < 0) {
        pixelOne = 1 / [[UIScreen mainScreen] scale];
    }
    return pixelOne;
}
+(BOOL)isReview
{
	NSString *review =  Review_Code;
	if (review) {
		if ([review isEqualToString:@"0"]) {
			return YES;
		}else{
			return NO;
		}
	}else{
		return YES;
	}
}

+(void)requestReviewWithCompletion:(void(^)(BOOL sucess))completion
{
	NSString *review =  Review_Code;
	if (review) {
		!completion?:completion(YES);
		return;
	}
	NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
	NSString *app_Version = [infoDictionary objectForKey:@"CFBundleShortVersionString"];
	TokenModel *model = [[TokenModel alloc]init];
	NSMutableDictionary *mdic = [model.dictionary mutableCopy];
	mdic[@"version"]  =  app_Version;
	[RequestBaseTool getUrlStr:AppendAPI(APPURL_prefix, @"")
					  andParms:mdic
				 andCompletion:^(id obj) {
					 NSString *status = [NSString stringWithFormat:@"%@",obj[@"status"]];
					 if ([status isEqualToString:@"1"]) {
						 NSString*is_check = [NSString stringWithFormat:@"%@",obj[@"data"][@"is_check"]];
						 [[NSUserDefaults standardUserDefaults]setObject:is_check forKey:@"review"];
						 [[NSUserDefaults standardUserDefaults] synchronize];
						 !completion?:completion(YES);
					 }else{
						 !completion?:completion(NO);
					 }
	} Error:^(NSError *errror) {
		!completion?:completion(NO);
	}];
}

@end
