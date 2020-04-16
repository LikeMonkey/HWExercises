//
//  DottedLineView.m
//  ZhongQiBrand
//
//  Created by ios2 on 2019/10/22.
//  Copyright © 2019 CY. All rights reserved.
//

#import "DottedLineView.h"

@implementation DottedLineView

-(instancetype)init
{
	self = [super init];
	if (self) {
		_lineColor = [UIColor whiteColor];
	}
	return self;
}
-(void)setLineColor:(UIColor *)lineColor
{
	_lineColor = lineColor;
	[self setNeedsDisplay];
}

- (void)drawRect:(CGRect)rect {
    // Drawing code
	[super drawRect:rect];
	CGFloat w =  CGRectGetWidth(rect);
	CGFloat h = CGRectGetHeight(rect);

	CGContextRef context =UIGraphicsGetCurrentContext();
	// 设置线条的样式
	CGContextSetLineCap(context, kCGLineCapRound);
	// 绘制线的宽度
	CGContextSetLineWidth(context, 2.0);
	// 线的颜色
	CGContextSetStrokeColorWithColor(context, _lineColor.CGColor);
	// 开始绘制
	CGContextBeginPath(context);
	// 设置虚线绘制起点
	CGContextMoveToPoint(context, 0, 0);
	// lengths的值｛10,10｝表示先绘制10个点，再跳过10个点，如此反复
	CGFloat lengths[] = {5,5};
	// 虚线的起始点
	CGContextSetLineDash(context, 0, lengths,2);

	// 绘制虚线的终点
	CGContextAddLineToPoint(context, w,0.0);

	CGContextAddLineToPoint(context, w,h);

	CGContextAddLineToPoint(context, 0,h);

	CGContextAddLineToPoint(context, 0,0);
	// 绘制
	CGContextStrokePath(context);
	// 关闭图像
	CGContextClosePath(context);

}


@end
