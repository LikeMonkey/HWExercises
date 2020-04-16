//
//  HeadLinesViewController.m
//  ZhongQiBrand
//
//  Created by ios2 on 2019/9/21.
//  Copyright © 2019 CY. All rights reserved.
//

#import "HeadLinesViewController.h"
#import "JXCategoryView.h"
#import "JXCategoryTitleView.h"
#import "HeadLinesSubViewController.h"
#import "JXCategoryListContainerView.h"

@interface HeadLinesViewController ()<JXCategoryListContainerViewDelegate>
@property (nonatomic,strong) NSArray *titles;
@property (nonatomic,strong) JXCategoryTitleView *categoryView;
@property (nonatomic,strong) JXCategoryListContainerView *listContainerView;
@property (nonatomic,strong)NSArray *fenleiArray;
@end

@implementation HeadLinesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
	self.navigationItem.title = @"中企头条";
	[self initBackNavItem];
	[self setUpUI];
}
- (void)setUpUI
{
	[self initNavView];
	self.titles = @[@"文化",@"风向",@"推荐",@"思想"];
	self.fenleiArray = @[@"1",@"2",@"3",@"4"];
	self.categoryView = [[JXCategoryTitleView alloc] init];
	self.categoryView.contentScrollViewClickTransitionAnimationEnabled = NO;
	self.categoryView.titleColor = [UIColor colorWithHexString:@"#333333"];
	self.categoryView.titleSelectedColor = [UIColor colorWithHexString:@"#333333"];
	self.categoryView.titleFont = [UIFont systemFontOfSize:15];
	self.categoryView.titleSelectedFont = [UIFont boldSystemFontOfSize:18];
	self.categoryView.contentEdgeInsetLeft = px_scale(64);
	self.categoryView.contentEdgeInsetRight = px_scale(64);
	self.categoryView.titles = self.titles;
	self.categoryView.titleLabelZoomScale = 1.1;
	// 指示器
	JXCategoryIndicatorLineView *indicatorImageView = [[JXCategoryIndicatorLineView alloc] init];
	indicatorImageView.lineStyle = JXCategoryIndicatorLineStyle_Normal;
	indicatorImageView.verticalMargin = 0;
	indicatorImageView.componentPosition = JXCategoryComponentPosition_Bottom;
	self.categoryView.indicators = @[indicatorImageView];

	// 列表容器
	/** 现在使用滚动视图  不降低内存方式
	 列表容器视图的类型
	 - ScrollView: UIScrollView。优势：没有其他副作用。劣势：视图内存占用相对大一点。
	 - CollectionView: 使用UICollectionView。优势：因为列表被添加到cell上，视图的内存占用更少，适合内存要求特别高的场景。劣势：因为cell重用机制的问题，导致列表下拉刷新视图，会因为被removeFromSuperview而被隐藏。需要参考`LoadDataListCollectionListViewController`类做特殊处理。
	 */
	self.listContainerView = [[JXCategoryListContainerView alloc]initWithType:(JXCategoryListContainerType_ScrollView) delegate:self];

	[self.view addSubview:self.listContainerView];

	//关联列表对象
	self.categoryView.listContainer = self.listContainerView;

	[self.view addSubview:self.categoryView];

	[self.categoryView mas_makeConstraints:^(MASConstraintMaker *make) {
		make.left.right.mas_equalTo(0);
		make.top.equalTo(self.navView.mas_bottom).offset(px_scale(16));
		make.height.mas_equalTo(px_scale(98));
	}];

	UIView *grayLine = [UIView new];
	grayLine.backgroundColor = [UIColor colorWithHexString:@"#F8F8F8"];
	[self.view addSubview:grayLine];
	[grayLine mas_makeConstraints:^(MASConstraintMaker *make) {
		make.top.equalTo(self.navView.mas_bottom);
		make.height.mas_equalTo(px_scale(16));
		make.left.right.mas_equalTo(0);
	}];

	UIView *grayLine0 = [UIView new];
	grayLine0.backgroundColor = [UIColor colorWithHexString:@"#F8F8F8"];
	[self.categoryView insertSubview:grayLine0 atIndex:0];
	[grayLine0 mas_makeConstraints:^(MASConstraintMaker *make) {
		make.bottom.equalTo(indicatorImageView);
		make.left.right.mas_equalTo(0);
		make.height.equalTo(indicatorImageView);
	}];

	self.listContainerView.frame = CGRectMake(0, NavBarHeight+px_scale(98+16+6), MAINScreenWidth, MAINScreenHeight -(NavBarHeight) - px_scale(98+16+6));
	
}

#pragma mark - ========= JXCategoryListCollectionContainerViewDataSource

- (id<JXCategoryListContentViewDelegate>)listContainerView:(JXCategoryListContainerView *)listContainerView initListForIndex:(NSInteger)index {
	HeadLinesSubViewController *listVC = [[HeadLinesSubViewController alloc] init];
	listVC.fenlei = self.fenleiArray[index];
	[self addChildViewController:listVC];
	return listVC;
}

- (NSInteger)numberOfListsInlistContainerView:(JXCategoryListContainerView *)listContainerView {
	return self.titles.count;
}
-(void)initBackNavItem
{
	UIBarButtonItem *backItem = [[UIBarButtonItem alloc]initWithImage:[[UIImage imageNamed:@"all_fahuia_btn"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:(UIBarButtonItemStylePlain) target:self action:@selector(backClicked:)];
	self.navigationItem.leftBarButtonItem = backItem;
}
-(void)backClicked:(id)sender
{
	[self.navigationController popViewControllerAnimated:YES];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
