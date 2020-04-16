//
//  MJFooter.m
//  VoteCloud
//
//  Created by ios2 on 2019/7/31.
//  Copyright © 2019 CY. All rights reserved.
//

#import "MJFooter.h"

@implementation MJFooter

- (void)prepare {
	[super prepare];
	[self setTitle:@"上拉加载更多" forState:MJRefreshStateIdle];
	[self setTitle:@"松手加载" forState:MJRefreshStatePulling];
	[self setTitle:@"正在加载" forState:MJRefreshStateRefreshing];
	[self setTitle:@"" forState:MJRefreshStateNoMoreData];
	self.stateLabel.font = [UIFont systemFontOfSize:13.0f];
}

@end
