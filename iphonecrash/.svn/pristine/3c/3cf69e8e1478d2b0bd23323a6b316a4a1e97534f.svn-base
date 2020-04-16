//
//  HomeResponse.m
//  ZhongQiBrand
//
//  Created by ios2 on 2019/11/4.
//  Copyright © 2019 CY. All rights reserved.
//

#import "HomeResponse.h"
@implementation HomebrandModel
@end

@implementation HomeNewsModel

@end

@implementation HomeVoteModel

@end

@implementation HomeResponse

+ (NSDictionary *)modelContainerPropertyGenericClass {
	return @{
			 @"brands" : [HomebrandModel class],
			 @"hotList":[HomeVoteModel class],
			 @"newslist":[HomeNewsModel class]
			 };
}
+ (NSDictionary *)modelCustomPropertyMapper {
	return @{@"hotList" : @"votelist"};
}

@end
