//
//  UMSocialManager+UMLogin.m
//  PPWBrand
//
//  Created by ios2 on 2019/4/29.
//  Copyright © 2019 ShanZhou. All rights reserved.
//

#import "UMSocialManager+UMLogin.h"
static char  wxLoginResponse_key = '\0';

@implementation UMSocialManager (UMLogin)

-(void)setWxLoginResponse:(void (^)(id))WxLoginResponse
{
	objc_setAssociatedObject(self, &wxLoginResponse_key, WxLoginResponse, OBJC_ASSOCIATION_COPY_NONATOMIC);
}
-(void(^)(id))WxLoginResponse
{
	return  objc_getAssociatedObject(self, &wxLoginResponse_key);
}

@end
