//
//  PointItem.m
//  VoteCloud
//
//  Created by ios2 on 2019/8/21.
//  Copyright © 2019 CY. All rights reserved.
//


#define X_S(x) CGRectGetWidth([UIScreen mainScreen].bounds)/750.0*(x)

#import "PointItem.h"

@implementation PointItem

-(instancetype)init
{
	self = [super init];
	if (self) {
		UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(onTapAction:)];
		[self addGestureRecognizer:tap];
		[self addSubview:self.bubbleImgView];
		[self addSubview:self.numberLable];
		self.bounds = CGRectMake(0, 0, X_S(39), X_S(55));
	}
	return self;
}

#pragma mark - target method
-(void)onTapAction:(UITapGestureRecognizer *)tap
{
	if (tap.state == UIGestureRecognizerStateEnded) {
		self.hidden = YES;
		!self.didClickedBlock?:self.didClickedBlock(self);
	}
}
-(void)setItemPoint:(CGPoint)itemPoint
{
	_itemPoint = itemPoint;
	CGPoint point = self.center;
	point.x = itemPoint.x;
	point.y =  itemPoint.y - CGRectGetHeight(self.bounds)/2.0;
	if (CGPointEqualToPoint(_itemPoint, CGPointZero)) {
		self.center = point;
		return;
	}
	self.center = CGPointMake(point.x, point.y - 5.0);
	[UIView animateWithDuration:0.2
						  delay:0
		 usingSpringWithDamping:0.2
		  initialSpringVelocity:5.0
						options:0 animations:^{
		self.center = point;
	} completion:^(BOOL finished) {
	}];
}

-(void)setNumber:(NSString *)number
{
	_number = number;
	self.numberLable.text = number;
}

-(void)layoutSubviews
{
	[super layoutSubviews];
	self.bubbleImgView.frame = self.bounds;
	self.numberLable.frame = CGRectMake(0, X_S(9), CGRectGetWidth(self.bounds), X_S(26));
}
#pragma mark - Getter
-(UIImageView *)bubbleImgView
{
	if (!_bubbleImgView) {
		_bubbleImgView = [[UIImageView alloc]init];
		_bubbleImgView.image = [UIImage imageNamed:@"yztp_szxs_icon"];
	 }
	return _bubbleImgView;
}
-(UILabel *)numberLable
{
	if (!_numberLable) {
		_numberLable = [[UILabel alloc]init];
		_numberLable.font = [UIFont systemFontOfSize:13];
		_numberLable.textColor = [UIColor colorWithRed:0xff/255.0 green:0xff/255.0 blue:0xff/255.0 alpha:1];
		_numberLable.textAlignment = NSTextAlignmentCenter;
	 }
	return _numberLable;
}

@end
