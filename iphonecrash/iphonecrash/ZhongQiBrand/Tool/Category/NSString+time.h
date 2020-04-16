//
//  NSString+time.h
//  PPWBrand
//
//  Created by ios2 on 2019/4/19.
//  Copyright © 2019 ShanZhou. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (time)
//当前时间和服务器时间差
+(NSString *)spaceTimeLine;
//存储当前时间和服务器时间差值
+(void)saveCurrentTimeWithServerSpace:(NSString *)searverTime;
//本地时间 到s
+(NSString *)localTimeLine;
//时间戳转 时间
-(NSString *)newsTime;

-(NSString *)publicTime;

@end



