//
//  NavBar.m
//  PPWBrand
//
//  Created by ios2 on 2019/4/12.
//  Copyright © 2019 ShanZhou. All rights reserved.
//

#import "NavBar.h"

@implementation NavBar

-(void)drawRect:(CGRect)rect {
	[super drawRect:rect];
	for (UIView *v in self.subviews) {
		if ([v isKindOfClass:NSClassFromString(@"_UINavigationBarContentView")]) {
			v.backgroundColor = [[UIColor blackColor]colorWithAlphaComponent:0];
		}
	}
}
-(UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event
{
	UIView *v = [super hitTest:point withEvent:event];
	if ([v isKindOfClass:NSClassFromString(@"_UITAMICAdaptorView")]) {
		return nil;
	}
	if ([v isKindOfClass:self.class]) {
			return nil;
	}
	if ([v isKindOfClass:NSClassFromString(@"_UINavigationBarContentView")]) {
		return  nil;
	}
	return v;
}

@end
