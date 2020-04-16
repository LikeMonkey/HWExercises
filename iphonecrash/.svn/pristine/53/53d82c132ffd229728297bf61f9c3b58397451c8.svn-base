//
//  JoinInputCache.m
//  ZhongQiBrand
//
//  Created by ios2 on 2019/10/22.
//  Copyright © 2019 CY. All rights reserved.
//

#import "JoinInputCache.h"

@implementation JoinInputCache

+(instancetype)share
{
	static JoinInputCache*cache = nil;
	static dispatch_once_t onceToken;
	dispatch_once(&onceToken, ^{
		cache = [[JoinInputCache alloc]init];
	});
	return cache;
}

@end
