//
//  UIView+LG_Frame.m
//  ProgressDemo
//
//  Created by ios2 on 2018/7/31.
//  Copyright © 2018年 ios2. All rights reserved.
//

#import "UIView+LG_Frame.h"

@implementation UIView (LG_Frame)

-(void)setX:(CGFloat)x
{
	self.frame = (CGRect){x,self.y,self.width,self.height};
}

-(CGFloat)x
{
	return self.frame.origin.x;
}

-(void)setY:(CGFloat)y
{
	self.frame = (CGRect){self.x,y,self.width,self.height};
}

-(CGFloat)y
{
   return self.frame.origin.y;
}

-(void)setWidth:(CGFloat)width
{
self.frame = (CGRect){self.x,self.y,width,self.height};
}

-(CGFloat)width
{
	return  CGRectGetWidth(self.frame);
}

-(void)setHeight:(CGFloat)height
{
	self.frame = (CGRect){self.x,self.y,self.width,height};
}

-(CGFloat)height
{
	return CGRectGetHeight(self.frame);
}

-(void)setCenterX:(CGFloat)centerX
{
	self.center = (CGPoint){centerX,self.centerY};
}

-(CGFloat)centerX
{
	return self.center.x;
}

-(void)setCenterY:(CGFloat)centerY
{
		self.center = (CGPoint){self.centerX,centerY};
}

-(CGFloat)centerY
{
	return self.center.y;
}
-(void)setMaxX:(CGFloat)maxX
{
	self.x  = maxX-self.width;
}
-(CGFloat)maxX
{
	return  CGRectGetMaxX(self.frame);
}
-(void)setMaxY:(CGFloat)maxY
{
	self.y = maxY-self.height;
}
-(CGFloat)maxY
{
	return CGRectGetMaxY(self.frame);
}

-(void)setSize:(CGSize)size
{
	CGRect f = self.frame;
	f.size =size;
	self.frame = f;
}
-(CGSize)size
{
	return self.frame.size;
}


@end
