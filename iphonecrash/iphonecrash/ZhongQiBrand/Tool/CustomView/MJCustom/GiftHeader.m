//
//  GiftHeader.m
//  VoteCloud
//
//  Created by ios2 on 2019/7/31.
//  Copyright © 2019 CY. All rights reserved.
//

#import "GiftHeader.h"

@implementation GiftHeader
#pragma mark - 重写方法
#pragma mark 基本设置
- (void)prepare
{
	[super prepare];
	// 设置普通状态的动画图片
	NSMutableArray *idleImages = [NSMutableArray array];
	for (NSUInteger i = 0; i<=41; i++) {
		UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"pull_down_%05zd", i]];
		if (image) {
			[idleImages addObject:image];
		}
	}
	if (idleImages.count >0) {
		[self setPull_downImages:idleImages forState:MJRefreshStateIdle];
	}
	// 设置即将刷新状态的动画图片（一松开就会刷新的状态）
	NSMutableArray *refreshingImages = [NSMutableArray array];
	for (NSUInteger i = 0; i<= 40; i++) {
		UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"refresh_%05zd", i]];
		if (image) {
			[refreshingImages addObject:image];
		}
	}

	if (refreshingImages.count >0) {
		[self setRefreshImages:refreshingImages forState:MJRefreshStatePulling];
	}
	// 设置正在刷新状态的动画图片
	if (refreshingImages.count > 0) {
		[self setRefreshImages:refreshingImages forState:MJRefreshStateRefreshing];
	}
}

- (void)setPull_downImages:(NSArray *)images forState:(MJRefreshState)state
{
	[self setImages:images duration:images.count * 0.4 forState:state];
}

- (void)setRefreshImages:(NSArray *)images forState:(MJRefreshState)state
{
	[self setImages:images duration:images.count * 0.04 forState:state];
}

@end
