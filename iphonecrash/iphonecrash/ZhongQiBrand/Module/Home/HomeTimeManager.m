//
//  HomeTimeManager.m
//  ZhongQiBrand
//
//  Created by ios2 on 2019/11/4.
//  Copyright © 2019 CY. All rights reserved.
//

#import "HomeTimeManager.h"

@interface HomeTimeManager()
@property (nonatomic,strong)NSMutableDictionary *blockDic;
@end


@implementation HomeTimeManager{
	NSTimer *_timer;
}
+(instancetype)manager
{
	static HomeTimeManager *manager = nil;
	static dispatch_once_t onceToken;
	dispatch_once(&onceToken, ^{
		manager = [[HomeTimeManager alloc]init];
	});
	return manager;
}

+(void)startTime
{
	[[self manager] startTime];
}
+(void)addBlock:(TimeRunBlock)block andTarget:(NSObject *)target
{
	if (!(block&&target)) return;
	HomeTimeManager *manager = [self manager];
	@synchronized (manager.blockDic) {
		[manager.blockDic setObject:block forKey:target.description];
	}
}
//移除关联的代码块
+(void)deleteBlock:(NSObject *)target
{
	HomeTimeManager *manager = [self manager];
	@synchronized (manager.blockDic) {
		[manager.blockDic removeObjectForKey:target.description];
	}
}
+(void)stopTime
{
	[[self manager]  invaliTime];
}
#pragma mark - private method
-(void)invaliTime
{
	if (_timer) {
		[_timer invalidate];
		_timer = nil;
	}
}
-(void)startTime
{
	[self invaliTime];
	_timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(onTimer) userInfo:nil repeats:YES];
	[[NSRunLoop mainRunLoop]addTimer:_timer forMode:NSRunLoopCommonModes];
	[_timer fire];
}

//运行定时器
-(void)onTimer
{
	@synchronized (self.blockDic) {
		NSArray *blocks =  self.blockDic.allValues;
		for (TimeRunBlock timeBlock in blocks) {
			timeBlock();
		}
	}
}
#pragma mark - getter
-(NSMutableDictionary *)blockDic
{
	if (!_blockDic) {
		_blockDic = [[NSMutableDictionary alloc]init];
	 }
	return _blockDic;
}

@end
