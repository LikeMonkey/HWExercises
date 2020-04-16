//
//  MJHeader.m
//  VoteCloud
//
//  Created by ios2 on 2019/7/31.
//  Copyright © 2019 CY. All rights reserved.
//

#import "MJHeader.h"

@implementation MJHeader

- (void)prepare {
	[super prepare];
	self.lastUpdatedTimeLabel.hidden = YES;
	[self setTitle:@"下拉刷新" forState:MJRefreshStateIdle];
	[self setTitle:@"松手刷新" forState:MJRefreshStatePulling];
	[self setTitle:@"加载中..." forState:MJRefreshStateRefreshing];
	self.stateLabel.font = [UIFont systemFontOfSize:15];
	self.stateLabel.textColor = self.textColor?self.textColor:[UIColor colorWithRed:73/255.0f green:73/255.0f blue:74/255.0f alpha:1];
//	self.arrowView.hidden = NO;
}
#pragma mark - setter
-(void)setTextColor:(UIColor *)textColor {
	_textColor = textColor;
	self.stateLabel.textColor = _textColor?_textColor:[UIColor colorWithRed:73/255.0f green:73/255.0f blue:74/255.0f alpha:1];
}
-(void)scrollViewContentOffsetDidChange:(NSDictionary *)change
{
	[super scrollViewContentOffsetDidChange:change];
//	self.arrowView.hidden = NO;
//	@try {
//		UIView *loadingView =  [self valueForKey:@"loadingView"];
//		loadingView.hidden = NO;
//	} @catch (NSException *exception) {
//	} @finally {
//	}
}
- (void)placeSubviews {
	[super placeSubviews];
//	self.arrowView.hidden = NO;
	if ([DeviceTool isPhoneX]) {
		if (self.isHiddenTopView) {
			//修改没有导航状态  -----
			CGSize size = self.bounds.size;
			size.height = 88;
			CGRect rect = self.bounds;
			rect.size = size;
			self.bounds = rect;
			self.arrowView.mj_y = CGRectGetHeight([UIApplication sharedApplication].statusBarFrame);
			UIView *loadingView = [self valueForKeyPath:@"loadingView"];
			loadingView.centerY = self.arrowView.centerY;
			self.stateLabel.centerY = self.arrowView.centerY;
		}
	}
}

@end
