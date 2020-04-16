//
//  CAGradientView.m
//  VoteCloud
//
//  Created by ios2 on 2019/8/12.
//  Copyright © 2019 CY. All rights reserved.
//

#import "CAGradientView.h"

@implementation CAGradientView


-(instancetype)init
{
	self = [super init];
	if (self) {
		self.gradientLayer = [[CAGradientLayer alloc]init];
		[self.layer addSublayer:self.gradientLayer];
	}
	return self;
}

-(void)layoutSubviews
{
	[super layoutSubviews];
	self.gradientLayer.frame = self.bounds;
}
@end
