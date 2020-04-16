//
//  WXApi+MiniProgram.m
//  ZhongQiBrand
//
//  Created by ios2 on 2019/11/13.
//  Copyright © 2019 CY. All rights reserved.
//

#import "WXApi+MiniProgram.h"
@implementation WXApi (MiniProgram)

+(void)openMiniProgramWithPath:(NSString *)path andCompletion:(void(^)(BOOL isSucess))completion
{
	WXLaunchMiniProgramReq *launchMiniProgramReq = [WXLaunchMiniProgramReq object];
	launchMiniProgramReq.userName = @"gh_193fb60c2478";  //拉起的小程序的username
	if (path) {
		launchMiniProgramReq.path=path;   //拉起小程序页面的可带参路径，不填默认拉起小程序首页
	}else{
		launchMiniProgramReq.path=@"/pages/home/home";   //拉起小程序页面的可带参路径，不填默认拉起小程序首页
	}
	launchMiniProgramReq.miniProgramType=WXMiniProgramTypeRelease; //拉起小程序的类型
																   //    WXMiniProgramTypeRelease = 0,       //**< 正式版  */
																   //    WXMiniProgramTypeTest = 1,        //**< 开发版  */
																   //    WXMiniProgramTypePreview = 2,         //**< 体验版  */
	[WXApi sendReq:launchMiniProgramReq completion:^(BOOL success) {
		!completion?:completion(success);
	}];
}
@end
