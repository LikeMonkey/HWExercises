//
//  HWNetWork.h
//  HWExercises
//
//  Created by sxmaps_w on 2017/5/22.
//  Copyright © 2017年 wqb. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HWNetWork : NSObject

//首页
+ (void)postHomeInfoWithUserid:(NSString *)userid success:(void (^)(id json))success failure:(void (^)(NSError *error))failure;

@end
