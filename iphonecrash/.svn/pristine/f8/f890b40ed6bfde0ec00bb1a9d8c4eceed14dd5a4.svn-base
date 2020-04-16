//
//  GuideViewController.m
//  VoteCloud
//
//  Created by ios2 on 2019/8/24.
//  Copyright © 2019 CY. All rights reserved.
//

#import "GuideViewController.h"
#import "NSBundle+GuideSource.h"
#import "GuidePageControl.h"

@interface GuideViewController ()<UIScrollViewDelegate> {
	UIScrollView *_bgScrollView;
	GuidePageControl *_pageControl;
	UIButton *_tyButton;
}

@end

@implementation GuideViewController

- (void)viewDidLoad {
    [super viewDidLoad];
	[[UIApplication sharedApplication]setStatusBarHidden:YES];
	BOOL isX = [DeviceTool isPhoneX];
	BOOL is4 = [self isPhone4];
	NSArray *imageArray = nil;
	if (isX) {
		imageArray = @[
					   @"10guideFile/gX_1@3x",
					   @"10guideFile/gX_2@3x",
					   @"10guideFile/gX_4@3x",
					   @"10guideFile/gX_3@3x",
					   ];
	}else{
		if (!is4) {
			imageArray =@[
						  @"6guideFile/g6_1@3x",
						  @"6guideFile/g6_2@3x",
						  @"6guideFile/g6_4@3x",
						  @"6guideFile/g6_3@3x",];
		}else{
			imageArray = @[
						   @"4guideFile/g4_1@2x",
						   @"4guideFile/g4_2@2x",
						   @"4guideFile/g4_4@2x",
						   @"4guideFile/g4_3@2x",
						   ];
		}
	}
	self.view.backgroundColor = [UIColor whiteColor];
	UIScrollView *scrollView =[[UIScrollView alloc]init];
	scrollView.delegate = self;
	_bgScrollView = scrollView;
	UIView *containtView = [UIView new];
	[self.view addSubview:_bgScrollView];
	_bgScrollView.pagingEnabled = YES;
	_bgScrollView.showsHorizontalScrollIndicator = NO;
	_bgScrollView.bounces = NO;
	[_bgScrollView addSubview:containtView];
	if (@available (iOS 11.0, *)) {
		_bgScrollView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
	}else{
		self.automaticallyAdjustsScrollViewInsets = NO;
	}
	UIView *lastItemView;
	for (int i = 0; i<imageArray.count; i++) {
		UIView *itemView =[UIView new];
		[containtView addSubview:itemView];
		itemView.translatesAutoresizingMaskIntoConstraints = NO;
		NSString *imageName = imageArray[i];
		[itemView mas_makeConstraints:^(MASConstraintMaker *make) {
			make.top.mas_equalTo(0);
			if (lastItemView) {
				make.left.equalTo(lastItemView.mas_right);
			}else{
				make.left.mas_equalTo(0);
			}
			make.width.mas_equalTo(self.view);
			make.bottom.mas_equalTo(0);
		}];
		UIImageView *imageView = [UIImageView new];
		imageView.image =[NSBundle guideImage:imageName];
		[itemView addSubview:imageView];
		[imageView mas_makeConstraints:^(MASConstraintMaker *make) {
			make.edges.equalTo(itemView);
		}];
		lastItemView = itemView;
	}
	[containtView mas_makeConstraints:^(MASConstraintMaker *make) {
		make.left.mas_equalTo(0);
		make.right.top.mas_equalTo(0);
		make.height.equalTo(self.view);
		make.right.equalTo(lastItemView.mas_right);
	}];


	GuidePageControl *pageControl = [[GuidePageControl alloc]init];
	[self.view addSubview:pageControl];
	[pageControl mas_makeConstraints:^(MASConstraintMaker *make) {
		make.bottom.mas_equalTo(-px_scale(88));
		make.height.mas_equalTo(px_scale(8));
		make.width.mas_equalTo(px_scale(160));
		make.centerX.mas_equalTo(0);
	}];

	pageControl.pageNumbers = 4;
	pageControl.currentPage = 0;
	_pageControl = pageControl;

	UIButton *tyButton = [UIButton buttonWithType:UIButtonTypeCustom];
	_tyButton = tyButton;
	tyButton.backgroundColor = [UIColor colorWithHexString:@"#71de50"];
	tyButton.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 0);
	[tyButton setTitleColor:[UIColor colorWithHexString:@"#ffffff"] forState:UIControlStateNormal];
	[tyButton setTitle:@"立即体验" forState:UIControlStateNormal];
	[tyButton addTarget:self action:@selector(tyClicked:) forControlEvents:UIControlEventTouchUpInside];
	tyButton.titleLabel.font = [UIFont systemFontOfSize:14];
	tyButton.layer.cornerRadius = 20;
	tyButton.layer.masksToBounds = YES;
	[lastItemView addSubview:tyButton];
	tyButton.hidden = YES;
	[tyButton mas_makeConstraints:^(MASConstraintMaker *make) {
		make.height.mas_equalTo(40);
		make.centerX.equalTo(pageControl);
		make.centerY.equalTo(pageControl);
		make.width.mas_equalTo(px_scale(350));
	}];
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
	CGFloat offSetX = scrollView.contentOffset.x;
	NSInteger page = (offSetX + CGRectGetWidth(scrollView.bounds)/2.0)/CGRectGetWidth(scrollView.bounds);
	if (_pageControl.currentPage == page) return;
	[UIView animateWithDuration:0.3 animations:^{
		self->_pageControl.currentPage =page;
	}];
	_tyButton.hidden = page>2?NO:YES;
	_pageControl.hidden = page<3?NO:YES;
}


#pragma mark - Target method
-(void)tyClicked:(id)sender
{
	[[UIApplication sharedApplication]setStatusBarHidden:NO];
	SAVE_Guide;
	UIViewController *tabbarVc = [[NSClassFromString(@"BrandTabBarController") alloc]init];
	UIWindow *window =  [[UIApplication sharedApplication].delegate window];
	CATransition *animation = [CATransition animation];
	animation.duration = 1.0;
	animation.type = @"rippleEffect";
	[window.layer addAnimation:animation forKey:@"push"];
	window.rootViewController = tabbarVc;
}

-(void)viewDidLayoutSubviews
{
	[super viewDidLayoutSubviews];
	_bgScrollView.frame = self.view.bounds;
}

-(BOOL)isPhone4 {
	CGFloat w =  CGRectGetWidth([UIScreen mainScreen].bounds);
	CGFloat h = CGRectGetHeight([UIScreen mainScreen].bounds);
	if (w <= 320&&h<=480) {
		return YES;
	}else{
		return NO;
	}
}

@end
