//
//  UMSocialManager+UMLogin.h
//  PPWBrand
//
//  Created by ios2 on 2019/4/29.
//  Copyright © 2019 ShanZhou. All rights reserved.
//

#import <UMShare/UMShare.h>

@interface UMSocialManager (UMLogin)

@property (nonatomic,copy)void(^WxLoginResponse)(id responde);


@end