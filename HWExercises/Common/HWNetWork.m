//
//  HWNetWork.m
//  HWExercises
//
//  Created by sxmaps_w on 2017/5/22.
//  Copyright © 2017年 wqb. All rights reserved.
//

#import "HWNetWork.h"
#import "HWManagerTool.h"

#define KIP @"https://xxx.xxxx.xxx"

//首页
#define KHomeInfo [NSString stringWithFormat:@"%@/index/homeInfo", KIP]

@implementation HWNetWork

//首页
+ (void)postHomeInfoWithUserid:(NSString *)userid success:(void (^)(id json))success failure:(void (^)(NSError *error))failure
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setObject:userid forKey:@"userid"];
    
    [HWManagerTool postWithURL:KHomeInfo params:params success:^(id json) {
        if (success) {
            success(json);
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}

@end
