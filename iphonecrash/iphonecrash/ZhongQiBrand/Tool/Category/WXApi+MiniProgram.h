//
//  WXApi+MiniProgram.h
//  ZhongQiBrand
//
//  Created by ios2 on 2019/11/13.
//  Copyright © 2019 CY. All rights reserved.
//

#import "WXApi.h"

@interface WXApi (MiniProgram)
/**
拉起小程序
 path :路径  /pages/home/home?sid = fdsffdsf & itemid = fdsfjj 类似指定参数
 */
+(void)openMiniProgramWithPath:(NSString *)path
				 andCompletion:(void(^)(BOOL isSucess))completion;

@end

