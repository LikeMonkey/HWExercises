//
//  BaseViewController.m
//  VoteCloud
//
//  Created by ios2 on 2019/7/31.
//  Copyright © 2019 CY. All rights reserved.
//

#import "BaseViewController.h"

@interface BaseViewController ()

@end

@implementation BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
	self.view.backgroundColor = [UIColor whiteColor];
	self.automaticallyAdjustsScrollViewInsets = NO;
}
-(void)initNavView {
	_navView = [[UIView alloc]init];
	[self.view addSubview:_navView];
	_navView.frame = CGRectMake(0, 0, MAINScreenWidth, NavBarHeight);
	_navView.backgroundColor = [UIColor whiteColor];
	_lineView = [UIView new];
	[_navView addSubview:_lineView];
	_lineView.backgroundColor = [UIColor colorWithHexString:@"#f1f1f1"];
	[_lineView mas_makeConstraints:^(MASConstraintMaker *make) {
		make.bottom.mas_equalTo(0);
		make.height.mas_equalTo(0.8);
		make.left.right.mas_equalTo(0);
	}];
}
-(void)viewWillLayoutSubviews {
	[super viewWillLayoutSubviews];
	if (_navView) {
		//状态栏发生改变 -----
		CGFloat maxY =  CGRectGetMaxY(self.navigationController.navigationBar.frame);
		if (maxY>10) {
			_navView.frame = CGRectMake(0, 0, CGRectGetWidth(self.view.frame), maxY);
		}
		[self.view bringSubviewToFront:_navView];
	}
}


@end
