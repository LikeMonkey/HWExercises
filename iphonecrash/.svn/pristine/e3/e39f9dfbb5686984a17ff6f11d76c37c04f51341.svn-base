//
//  UIScrollView+Bottom.m
//  VoteCloud
//
//  Created by ios2 on 2019/11/7.
//  Copyright © 2019 CY. All rights reserved.
//

#import "UIScrollView+Bottom.h"

static const char platformBottomViewKey = '\0';
@implementation UIScrollView (Bottom)
-(void)setPlatformView:(PlatformBottomView *)platformView
{
	PlatformBottomView *v =  objc_getAssociatedObject(self, &platformBottomViewKey);
	if (platformView != v) {
		[v removeFromSuperview];
		[self addSubview:platformView];
		objc_setAssociatedObject(self, &platformBottomViewKey, platformView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
	}
}
-(PlatformBottomView *)platformView
{
	PlatformBottomView *v =  objc_getAssociatedObject(self, &platformBottomViewKey);
	if (!v) {
		v = [[PlatformBottomView alloc]init];
		v.frame = CGRectMake(0, 0, MAINScreenWidth, 40);
		self.platformView = v;
	}
	return v;
}

@end
