//
//  GuidePageControl.m
//  VoteCloud
//
//  Created by ios2 on 2019/8/24.
//  Copyright © 2019 CY. All rights reserved.
//

#import "GuidePageControl.h"

@interface GuidePageControl()
@property (nonatomic,strong)UIView *containtView;
@property (nonatomic,strong)UIView *pageMaskView;
@end

@implementation GuidePageControl

-(instancetype)init
{
	self = [super init];
	if (self) {
		_currentPage = 0;
		_pageNumbers = 1;
		[self setUpUI];
	}
	return self;
}

-(void)setUpUI
{
	[self addSubview:self.containtView];
	self.backgroundColor = [UIColor colorWithHexString:@"#E6E6E6"];
	self.containtView.maskView = self.pageMaskView;
}

-(void)setCurrentPage:(NSInteger)currentPage
{
	_currentPage = currentPage;
	[self changeSeletedFrame];
}

-(void)setPageNumbers:(NSInteger)pageNumbers
{
	_pageNumbers = pageNumbers;
	[self.containtView.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
		[obj removeFromSuperview];
	}];
	NSArray *clorsHexs = @[@"#EF963D",@"#29A9DD",@"#F84A56",@"#B2FC8E"];
	for (int i = 0; i<pageNumbers; i++) {
		UIView *pageView = [UIView new];
		NSInteger index = i%(clorsHexs.count);
		pageView.backgroundColor  = [UIColor colorWithHexString:clorsHexs[index]];
		[self.containtView addSubview:pageView];
	}
	[self setNeedsLayout];
}
-(void)layoutSubviews
{
	[super layoutSubviews];
	[self changeSeletedFrame];
}

-(void)changeSeletedFrame
{
	self.containtView.frame = self.bounds;
	CGFloat itemWidth =CGRectGetWidth(self.bounds)/self.pageNumbers;
	self.pageMaskView.frame = CGRectMake(self.currentPage * itemWidth, 0, itemWidth, CGRectGetHeight(self.bounds));
	for (int i = 0; i<self.pageNumbers; i++) {
		UIView *view = self.containtView.subviews[i];
		view.frame = CGRectMake(i*itemWidth, 0, itemWidth, CGRectGetHeight(self.bounds));
	}
	self.layer.cornerRadius = CGRectGetHeight(self.bounds)/2.0;
	self.clipsToBounds = YES;
	self.pageMaskView.layer.cornerRadius = CGRectGetHeight(self.containtView.bounds)/2.0;
	self.pageMaskView.clipsToBounds = YES;
}

-(UIView *)pageMaskView
{
	if (!_pageMaskView) {
		_pageMaskView = [[UIView alloc]init];
		_pageMaskView.backgroundColor  =[UIColor blackColor];
	 }
	return _pageMaskView;
}

-(UIView *)containtView
{
	if (!_containtView)
	 {
		_containtView = [[UIView alloc]init];
	 }
	return _containtView;
}




@end
