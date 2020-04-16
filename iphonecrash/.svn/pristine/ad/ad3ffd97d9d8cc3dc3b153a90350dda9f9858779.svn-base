//
//  UIView+LgPlaceholder.m
//  ScrollPage
//
//  Created by ios2 on 2019/4/8.
//  Copyright © 2019 LenSky. All rights reserved.
//

#import "UIView+LgPlaceholder.h"
#import <objc/runtime.h>

static const char placeholderViewKey = '\0';

@implementation UIView (LgPlaceholder)

-(void)setLgPlaceholder:(LgPlaceHodlderView *)lgPlaceholder
{
	LgPlaceHodlderView *v =  objc_getAssociatedObject(self, &placeholderViewKey);
	if (lgPlaceholder != v) {
		[v removeFromSuperview];
		[self addSubview:lgPlaceholder];
		objc_setAssociatedObject(self, &placeholderViewKey, lgPlaceholder, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
	}
}
-(LgPlaceHodlderView *)lgPlaceholder
{
	LgPlaceHodlderView *v =  objc_getAssociatedObject(self, &placeholderViewKey);
	if (!v) {
		v = [[LgPlaceStateView alloc]init];
		self.lgPlaceholder = v;
	}
	return v;
}

@end
