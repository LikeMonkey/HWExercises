//
//  HotListResponse.m
//  ZhongQiBrand
//
//  Created by ios2 on 2019/11/4.
//  Copyright © 2019 CY. All rights reserved.
//

#import "HotListResponse.h"

@implementation HotListModel

@end


@implementation HotListResponse
+ (NSDictionary *)modelContainerPropertyGenericClass {
	return @{@"data" : [HotListModel class]};
}
@end
