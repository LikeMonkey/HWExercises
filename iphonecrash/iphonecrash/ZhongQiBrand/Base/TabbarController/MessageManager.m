//
//  MessageManager.m
//  VoteCloud
//
//  Created by ios2 on 2019/8/14.
//  Copyright © 2019 CY. All rights reserved.
//

#import "MessageManager.h"
//#import "UserModel.h"

@interface MessageManager ()

@property (nonatomic,strong)NSMutableDictionary *cache;

@end

@implementation MessageManager

+(instancetype)manager
{
	static MessageManager *manager = nil;
	static dispatch_once_t onceToken;
	dispatch_once(&onceToken, ^{
		manager = [[MessageManager alloc]init];
	});
	return manager;
}
-(instancetype)init
{
	self = [super init];
	if (self) {
		//设置初始值为 0 防止为 NSNotFound
		_messageCount = 0;
        [self updateRedPoint];
	}
	return self;
}

- (void)updateRedPoint{
//    TokenModel *model = [TokenModel new];
//    NSMutableDictionary *parms = [model.dictionary mutableCopy];
//    [RequestBaseTool getUrlStr:AppendAPI(APPURL_prefix, User_prefix)
//                      andParms:parms andCompletion:^(id obj) {
//                          BaseModel *baseModel = [[BaseModel alloc]initWithDictionary:obj];
//                          if ([baseModel.status isEqualToString:@"1"]) {
//                              NSDictionary *data = (NSDictionary *)obj[@"data"];
//                              UserModel *userModel = [[UserModel alloc] initWithDictionary:data];
//                              [MessageManager updateCount:userModel.num];
//                          }else{
//                              SHOW_MSG(baseModel.msg, 0.5);
//                          }
//                      } Error:^(NSError *errror) {
//                          if (errror.code != -900) {
//
//                          }
//                      }];
}

+(void)updateCount:(NSInteger)msgCount
{
	MessageManager *message = [MessageManager manager];
	@synchronized (message) {
		message.messageCount = msgCount;
	}
	[message.cache enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
		void(^block)(void) = obj;
		!block?:block();
	}];
}
+(void)addKey:(NSObject *)key andBlock:(void (^)(void))block
{
	MessageManager *message = [MessageManager manager];
	@synchronized (message) {
		[message.cache setValue:block forKey:key.description];
	}
}
+(void)removeKey:(NSObject *)key
{
	MessageManager *message = [MessageManager manager];
	@synchronized (message) {
		[message.cache removeObjectForKey:key.description];
	}
}
-(NSMutableDictionary *)cache
{
	if (!_cache) {
		_cache = [[NSMutableDictionary alloc]init];
	 }
	return _cache;
}

@end
