//
//  VoteModel.m
//  ZhongQiBrand
//
//  Created by 孙程 on 2019/9/17.
//  Copyright © 2019 CY. All rights reserved.
//

#import "VoteModel.h"

@implementation VoteModel

/*
 //图片
 @property (nonatomic,strong)NSString *thumb;
 //票数
 @property (nonatomic,strong)NSString *toupiao;
 //trend
 @property (nonatomic,strong)NSString *trend;
 */


	//映射key
+ (NSDictionary *)modelCustomPropertyMapper {
	return @{@"icon" : @"thumb",
			 @"votenum" : @"toupiao",
			 @"updown" : @"trend"
			 };
}

@end

//响应数据
@implementation VoteRequestResponse
+ (NSDictionary *)modelContainerPropertyGenericClass {
	return @{@"data" : [VoteModel class]};
}
@end

