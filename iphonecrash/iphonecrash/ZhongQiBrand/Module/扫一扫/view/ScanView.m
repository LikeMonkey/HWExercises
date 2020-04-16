//
//  ScanView.m
//  VoteCloud
//
//  Created by ios2 on 2019/8/5.
//  Copyright © 2019 CY. All rights reserved.
//

#import "ScanView.h"

@implementation ScanView{
	UIImageView *_scanImageView;
}

-(instancetype)initWithFrame:(CGRect)frame
{
	self =  [super initWithFrame:frame];
	if (self) {
		_lineHeight = 20;
		self.layer.borderColor = [UIColor colorWithHexString:@"#22A3FF"].CGColor;
		self.layer.borderWidth = 0.5;
		self.backgroundColor = [[UIColor whiteColor]colorWithAlphaComponent:0];
		_scanImageView = [UIImageView new];
		_scanImageView.image = [UIImage imageNamed:@"saomewm_wg_img"];
		[self addSubview:_scanImageView];
	}
	return self;
}

-(void)startScanAnimation
{
	_scanImageView.bounds = self.bounds;
	CGRect f = _scanImageView.frame;
	CGFloat height = CGRectGetHeight(self.bounds);
	f.origin.x = 0;
	f.origin.y = - height;
	CGRect endF = f;
	endF.origin.y = 0;
	self.clipsToBounds = YES;
	_scanImageView.frame = f;
	_scanImageView.alpha = 1;
	[UIView animateWithDuration:2.0 delay:0 options:(UIViewAnimationOptionCurveEaseIn) animations:^{
		self->_scanImageView.frame = endF;
	} completion:^(BOOL finished) {
		[UIView animateWithDuration:0.5 animations:^{
			self->_scanImageView.alpha = 0.001;
		} completion:^(BOOL finished) {
			[self startScanAnimation];
		}];
	}];
}
-(void)setRect_color:(UIColor *)rect_color {
	_rect_color = rect_color;
	self.layer.borderColor = _rect_color.CGColor;
	[self setNeedsDisplay];
}
- (void)drawRect:(CGRect)rect {
	[super drawRect:rect];
	CGFloat lineH =_lineHeight;
	for (int i = 0; i< 4; i++) {
		UIBezierPath *p;
		if (i==0) {
			UIBezierPath *path = [UIBezierPath bezierPath];
			[path moveToPoint:CGPointMake(0, lineH)];
			[path addLineToPoint:CGPointMake(0, 0)];
			[path addLineToPoint:CGPointMake(lineH, 0)];
			p = path;
		}else if(i==1){
			UIBezierPath *path = [UIBezierPath bezierPath];
			[path moveToPoint:CGPointMake(CGRectGetWidth(rect) - lineH, 0)];
			[path addLineToPoint:CGPointMake(CGRectGetWidth(rect), 0)];
			[path addLineToPoint:CGPointMake(CGRectGetWidth(rect), lineH)];
			p = path;
		}else if(i==2){
			UIBezierPath *path = [UIBezierPath bezierPath];
			[path moveToPoint:CGPointMake(CGRectGetWidth(rect), CGRectGetHeight(rect)-lineH)];
			[path addLineToPoint:CGPointMake(CGRectGetWidth(rect), CGRectGetHeight(rect))];
			[path addLineToPoint:CGPointMake(CGRectGetWidth(rect) - lineH, CGRectGetHeight(rect))];
			p = path;
		}else if(i==3){
			UIBezierPath *path = [UIBezierPath bezierPath];
			[path moveToPoint:CGPointMake(lineH, CGRectGetHeight(rect))];
			[path addLineToPoint:CGPointMake(0, CGRectGetHeight(rect))];
			[path addLineToPoint:CGPointMake(0, CGRectGetHeight(rect)-lineH)];
			p = path;
		}
		UIColor *drawColor = _rect_color?_rect_color:[UIColor redColor];
		[drawColor setStroke];
		[[UIColor clearColor]setFill];
		[p setLineWidth:7.0];
		[p fill];
		[p stroke];
	}
}
@end
