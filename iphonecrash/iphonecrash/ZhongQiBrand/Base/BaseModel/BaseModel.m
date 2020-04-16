//
//  BaseModel.m
//  VoteCloud
//
//  Created by ios2 on 2019/8/1.
//  Copyright © 2019 CY. All rights reserved.
//

#import "BaseModel.h"


@implementation BaseModel
-(instancetype)initWithDictionary:(NSDictionary *)dic
{
	self = [super init];
	if (self) {
		[self yy_modelSetWithDictionary:dic];
	}
	return self;
}
	//对象序列化
-(NSData *)ecode
{
	return   [NSKeyedArchiver archivedDataWithRootObject:self];
}
	//对象反对象序列化
+(instancetype)decodeWithData:(NSData *)data {
	if (data) {
		return [NSKeyedUnarchiver unarchiveObjectWithData:data];
	}else{
		return  nil;
	}
}
#pragma mark 对象序列化使用
- (void)encodeWithCoder:(NSCoder *)aCoder
{
	[self yy_modelEncodeWithCoder:aCoder];
}
- (id)initWithCoder:(NSCoder *)aDecoder
{
	return [self yy_modelInitWithCoder:aDecoder];
}

// =================

-(void)setTime:(NSString *)time
{
	_time = time;
	if ([time integerValue] != NSNotFound&&time) {
		[NSString saveCurrentTimeWithServerSpace:time];
	}
}
-(void)setStatus:(NSString *)status {
	_status = status;
	if ([status isEqualToString:@"2"]) {
		[[NSUserDefaults standardUserDefaults]setBool:NO forKey:IsLogin];
		[[NSUserDefaults standardUserDefaults] synchronize];
		[MessageManager updateCount:0];
		[self showLogin];
	}
}
-(void)showLogin {
	UIViewController *loginVc =[[NSClassFromString(@"LoginViewController") alloc]init];
	if (loginVc) {
		UIWindow *window = [[UIApplication sharedApplication].delegate window];
		UINavigationController *nav = [[NSClassFromString(@"VoteNavigationController") alloc]initWithRootViewController:loginVc];
		[window.rootViewController presentViewController:nav animated:YES completion:nil];
	}
}

@end


/*
 //映射key
 + (NSDictionary *)modelCustomPropertyMapper {
 return @{@"name" : @"n",
 @"page" : @"p",
 @"desc" : @"ext.desc",
 @"bookID" : @[@"id",@"ID",@"book_id"]};
 }
 */

/*
 //映射类 在容器内的
 + (NSDictionary *)modelContainerPropertyGenericClass {
 return @{@"shadows" : [Shadow class]};
 }
 */




