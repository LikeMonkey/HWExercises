//
//  NSString+time.m
//  PPWBrand
//
//  Created by ios2 on 2019/4/19.
//  Copyright © 2019 ShanZhou. All rights reserved.
//

#import "NSString+time.h"

@implementation NSString (time)
+(NSString *)spaceTimeLine
{
	NSDate *date = [NSDate date];
	double timeLine =     [date timeIntervalSince1970];
	NSInteger localTime =   timeLine/1;//转化为秒
	NSNumber *spaceNumT =  [[NSUserDefaults standardUserDefaults] objectForKey:@"spaceT"];
	NSInteger space = 0;
	if (spaceNumT) {
		space =  [spaceNumT integerValue];
	}
	NSString *timeLineStr = [NSString stringWithFormat:@"%ld",(long)(localTime+space)];
	return timeLineStr;
}
+(void)saveCurrentTimeWithServerSpace:(NSString *)searverTime
{
	NSInteger serverT =   [searverTime integerValue];
	NSInteger localT =    [[self localTimeLine] integerValue];
	NSInteger spaceT =   serverT - localT;
	[[NSUserDefaults standardUserDefaults]setObject:@(spaceT) forKey:@"spaceT"];
	[[NSUserDefaults standardUserDefaults] synchronize];
}
+(NSString *)localTimeLine
{
	NSDate *date = [NSDate date];
	double timeLine =     [date timeIntervalSince1970];
	NSInteger num =   timeLine/1;//转化为秒
	NSString *timeLineStr = [NSString stringWithFormat:@"%ld",(long)num];
	return timeLineStr;
}

-(NSString *)newsTime
{
	 if ([@([self integerValue]) stringValue].length != self.length) return self;
	NSDateFormatter *formart = [[NSDateFormatter alloc]init];
	[formart setDateFormat:@"yyyy-MM-dd"];
	NSDate *date = [NSDate dateWithTimeIntervalSince1970:self.doubleValue];
	return  [formart stringFromDate:date];
}
-(NSString *)publicTime
{
	if ([@([self integerValue]) stringValue].length != self.length) return self;
	NSDateFormatter *formart = [[NSDateFormatter alloc]init];
	[formart setDateFormat:@"yyyy-MM-dd  hh:mm"];
	NSDate *date = [NSDate dateWithTimeIntervalSince1970:self.doubleValue];
	return  [formart stringFromDate:date];
}

@end
