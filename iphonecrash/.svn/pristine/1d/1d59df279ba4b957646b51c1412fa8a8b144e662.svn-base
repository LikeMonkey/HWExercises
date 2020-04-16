//
//  CustomPageCycleScrollView.m
//  VoteCloud
//
//  Created by ios2 on 2019/8/2.
//  Copyright © 2019 CY. All rights reserved.
//

#import "CustomPageCycleScrollView.h"
#import "LWDPageControl.h"

@implementation CustomPageCycleScrollView{
	LWDPageControl *_lwPageControl;
	UIView *_contolBgView;
}
- (void)setupPageControl
{
	[super setupPageControl];

	if(_lwPageControl)[_lwPageControl removeFromSuperview];
	if (_contolBgView) [_contolBgView removeFromSuperview];
	_contolBgView = [UIView new];
	_contolBgView.backgroundColor = [[UIColor colorWithHexString:@"#000000"]colorWithAlphaComponent:0.2];
	_contolBgView.layer.cornerRadius = px_scale(25)/2.0;
	[self addSubview:_contolBgView];

	_lwPageControl = [[LWDPageControl alloc] initWithFrame:CGRectMake(0,CGRectGetHeight(self.frame) - px_scale(30), CGRectGetWidth(self.frame), px_scale(15))
										 indicatorMargin:px_scale(5)
										  indicatorWidth:px_scale(8)
								   currentIndicatorWidth:px_scale(30)
										 indicatorHeight:px_scale(8)];
	_lwPageControl.currentPageIndicatorColor = [UIColor whiteColor];
	_lwPageControl.pageIndicatorColor = [[UIColor whiteColor]colorWithAlphaComponent:0.6];
	[self addSubview:_lwPageControl];

	if (ArrayIsEmpty(self.imageURLStringsGroup)) {
		   _lwPageControl.hidden = YES;
		   _contolBgView.hidden = YES;
		 if (!ArrayIsEmpty(self.localizationImageNamesGroup)) {
			 _lwPageControl.numberOfPages = self.localizationImageNamesGroup.count;
			 _lwPageControl.hidden = NO;
			 _contolBgView.hidden = NO;
		 }
	}else{
		if (self.imageURLStringsGroup.count <2) {
			_lwPageControl.hidden = YES;
			_contolBgView.hidden = YES;
		}else{
			_lwPageControl.hidden = NO;
			_contolBgView.hidden = NO;
		}
		_lwPageControl.numberOfPages = self.imageURLStringsGroup.count;
	}
	NSInteger pageCount = _lwPageControl.numberOfPages;
	CGFloat w = px_scale(8)*(pageCount -1) + px_scale(30) + px_scale(45);
	_contolBgView.frame = CGRectMake(0, 0, w, px_scale(25));
	_contolBgView.center =_lwPageControl.center;
	@try {
		UIPageControl *pageControl=  [self valueForKeyPath:@"_pageControl"];
		pageControl.hidden = YES;
		_lwPageControl.currentPage =pageControl.currentPage;
	}  @finally {
		NSLog(@"隐藏正常");
	}
}
-(int)currentIndex
{
	int index =  [super currentIndex];
	return index;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
	[super scrollViewDidScroll:scrollView];
	@try {
		UIPageControl *pageControl =  [self valueForKeyPath:@"_pageControl"];
		pageControl.hidden = YES;
		[UIView animateWithDuration:0.2 animations:^{
			self->_lwPageControl.currentPage = pageControl.currentPage;
		}];
	}  @finally {
	}
}

-(void)layoutSubviews
{
	[super layoutSubviews];
	@try {
		UIPageControl *pageControl =  [self valueForKeyPath:@"_pageControl"];
		pageControl.hidden = YES;
	}@finally{

	}
}


@end
