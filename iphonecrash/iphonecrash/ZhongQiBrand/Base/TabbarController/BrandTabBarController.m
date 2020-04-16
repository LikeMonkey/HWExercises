//
//  BrandTabBarController.m
//  ZhongQiBrand
//
//  Created by 孙程 on 2019/9/16.
//  Copyright © 2019 CY. All rights reserved.
//

#import "BrandTabBarController.h"
#import "UIView+AQanimation.h"
#import "CommonTools.h"
#import "QrScanTabBar.h"

@interface BrandTabBarController ()<QrScanTabBarDelegate>
@property (nonatomic,strong)NSMutableArray *circleViews;
@end

@implementation BrandTabBarController
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self addBarItemCirCleView];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [UITabBar appearance].translucent = NO;
    
    //设置扫一扫中间的按钮
    QrScanTabBar *tabbar = [[QrScanTabBar alloc]init];
    tabbar.qrDelegate = self;
    [self setValue:tabbar forKey:@"tabBar"];
    
    [self addShadow];
    [self addSubViewController];
    
    __weak typeof(self)ws = self;
    //检测消息通知，更新红点
    [MessageManager addKey:self andBlock:^{
        [ws updateRedPoint];
    }];

	BOOL isGuideQrScan =  [[NSUserDefaults standardUserDefaults]boolForKey:@"isGuideQrScan"];
	if (!isGuideQrScan) {
		[self loadGuideQrScanView:tabbar.bigButton];
	}
}
-(void)loadGuideQrScanView:(UIView *)barButton
{
	[[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"isGuideQrScan"];
	//加载扫一扫引导
	UIView *guideView = [UIView new];
	[self.view addSubview:guideView];
	[guideView mas_makeConstraints:^(MASConstraintMaker *make) {
		make.edges.equalTo(self.view);
	}];
	UIButton *guideButton = [UIButton buttonWithType:UIButtonTypeCustom];
	guideButton.titleLabel.font = [UIFont systemFontOfSize:13];
	guideButton.userInteractionEnabled = NO;
	guideButton.contentVerticalAlignment = UIControlContentVerticalAlignmentTop;
	guideButton.titleEdgeInsets = UIEdgeInsetsMake(px_scale(13), 0, 0, 0);
	[guideButton setTitleColor:[UIColor colorWithHexString:@"#ffffff"] forState:UIControlStateNormal];
	[guideButton setTitle:@"扫描投票二维码，为你喜爱的品牌投票！" forState:UIControlStateNormal];
	[guideButton setBackgroundImage:[UIImage imageNamed:@"home_ssts_img"] forState:UIControlStateNormal];
	[guideView addSubview:guideButton];
	[guideButton mas_makeConstraints:^(MASConstraintMaker *make) {
		make.bottom.equalTo(barButton.mas_top);
		make.size.mas_equalTo((CGSize){px_scale(500),px_scale(74)});
		make.centerX.equalTo(barButton);
	}];
	UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapAction:)];
	[guideView addGestureRecognizer:tap];
}

-(void)tapAction:(UITapGestureRecognizer *)tap
{
		[tap.view removeFromSuperview];
}

//点击二维码按钮
-(void)qrScanBar:(QrScanTabBar *)tabbar scanClicked:(UIButton *)scanButton
{
    UIViewController *vc =  self.selectedViewController;
    if ([vc isKindOfClass:[UINavigationController class]]) {
        UINavigationController *nav = (UINavigationController *)vc;
        UIViewController *qrScanVc = [[NSClassFromString(@"QrScanViewController") alloc]init];
        if (qrScanVc) {
            [nav pushViewController:qrScanVc animated:YES];
        }
    }
}

-(UIImage *)qrScanBar:(QrScanTabBar *)tabbar scanButton:(UIButton *)scanButton {
    //返回图片进行设置
    UIImage *image = [UIImage imageNamed:@"hone_sys_icon"];
    return image;
}

-(void)addSubViewController {
    
    self.viewControllers = nil;
    
    NSArray *titles = @[
                        @"首页",
                        @"热门榜单",
                        @"品牌世界",
                        @"我的"];
    NSArray *vcClassArray = @[
                              @"HomeViewController",
                              @"HotListViewController",
                              @"WorldOfTheBrandViewController",
                              @"MineViewController"];
    
    //选中的名字
    NSArray *normalImgNames = @[
                                @"home_btn1_icon",
                                @"home_rmbd_icon",
                                @"home_ppsj_icon",
                                @"home_wd_icon"];
    
    
    //选中的图片名称
    NSArray *seletedImgNames = @[
                                 @"home_btn_icon",
                                 @"home_rmbd1_icon",
                                 @"home_ppsj1_icon",
                                 @"home_wd1_icon"];
    
    NSArray *normalColorStrs = @[
                                 @"#676971",
                                 @"#676971",
                                 @"#676971",
                                 @"#676971"];
    
    NSArray *seletColorStrs = @[
                                @"#DD131C",
                                @"#DD131C",
                                @"#DD131C",
                                @"#DD131C"];
    
    NSMutableArray *tmpArray = [NSMutableArray array];
    for (int i = 0; i<vcClassArray.count; i++) {
        UIViewController *vc = [[NSClassFromString(vcClassArray[i]) alloc]init];
        UINavigationController *nav = [[NSClassFromString(@"VoteNavigationController") alloc]initWithRootViewController:vc];
        UIColor *normalColor = [UIColor colorWithHexString:normalColorStrs[i]];
        UIColor *seletColor =  [UIColor colorWithHexString:seletColorStrs[i]];
        [tmpArray addObject:nav];
        [self addChildHudVcWithNavigation:nav
                                 andIndex:i
                                 andTitle:titles[i]
                      andTitleNormalColor:normalColor
                          andSeletedColor:seletColor
                      andSeletedImageName:seletedImgNames[i]
                       andNormalImageName:normalImgNames[i]];
    }
    self.viewControllers = tmpArray;
    self.selectedIndex = 0;
}

//设置TabBarItem -----
-(void)addChildHudVcWithNavigation:(UINavigationController *)nav
                          andIndex:(NSInteger)index andTitle:(NSString *)title
               andTitleNormalColor:(UIColor *)normalColor
                   andSeletedColor:(UIColor *)seletedColor
               andSeletedImageName:(NSString *)seletedImageName
                andNormalImageName:(NSString *)normalImageName
{
    UITabBarItem *item = [[UITabBarItem alloc]init];
    item.badgeValue = nil;
    item.title = title;
    item.tag = index;
    
    //设置选中颜色
    [item setTitleTextAttributes:@{
                                   NSForegroundColorAttributeName:seletedColor,
                                   NSFontAttributeName:[UIFont systemFontOfSize:10]
                                   } forState:UIControlStateSelected];
    //设置默认颜色
    [item setTitleTextAttributes:@{
                                   NSForegroundColorAttributeName:normalColor,
                                   NSFontAttributeName:[UIFont systemFontOfSize:10]
                                   } forState:UIControlStateNormal];
    //设置选中图
    [item setSelectedImage:[[UIImage imageNamed:seletedImageName]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    
    //设置默认图
    [item setImage:[[UIImage imageNamed:normalImageName]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    
    
    nav.tabBarItem = item;
}

-(void)addShadow
{
    //添加阴影 代码
    self.tabBar.backgroundImage = [UIImage creactImageWithColor:[[UIColor whiteColor] colorWithAlphaComponent:1] andSize:self.tabBar.frame.size];
    self.tabBar.shadowImage = [UIImage new];
    self.tabBar.layer.shadowColor = [UIColor lightGrayColor].CGColor;
    self.tabBar.layer.shadowOffset = CGSizeMake(0, -5);
    self.tabBar.layer.shadowOpacity = 0.3;
}

#pragma mark - protocol method
-(void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item
{
    NSInteger index = 0;
    for (UIView *v  in tabBar.subviews) {
        if ([v isKindOfClass:NSClassFromString(@"UITabBarButton")]) {
            if (item.tag==index) {
                for (UIView *aView in v.subviews) {
                    if ([aView isKindOfClass:NSClassFromString(@"UITabBarSwappableImageView")]) {
                        if (index==0) {
                            [aView aq_addScaleAnimation:1.2];
                        } else {
                            [aView aq_addScaleAnimation:1.2];
                        }
                        return;
                    }
                }
            }
            index++;
        }
    }
}

#pragma mark  - private method
-(void)addBarItemCirCleView {
    if (self.circleViews.count>0) return;
    
    for (UIView *view in self.tabBar.subviews)  {
        if ([view isKindOfClass:NSClassFromString(@"UITabBarButton")]) {
            
            // 通知红点
            UIView *circleView  = [UIView new];
            circleView.frame = CGRectMake(CGRectGetWidth(view.frame)-5, 0, 5, 5);
            circleView.backgroundColor = [UIColor redColor];
            circleView.layer.cornerRadius = 4.0f;
            circleView.hidden = YES;
            circleView.clipsToBounds = YES;
            [self.circleViews addObject:circleView];
            
            for (UIView *aview in view.subviews) {
                if ([aview isKindOfClass:NSClassFromString(@"UITabBarSwappableImageView")]) {
                    circleView.frame = CGRectMake(CGRectGetWidth(aview.frame)/2+8, CGRectGetHeight(aview.frame)/2-8, 8, 8);
                    [aview addSubview:circleView];
                }
            }
        }
    }
    [self updateRedPoint];
}

-(void)updateRedPoint
{
    NSInteger messageCount = [MessageManager manager].messageCount;
    if (messageCount == 0 || messageCount == NSNotFound) {
        if (!ArrayIsEmpty(self.circleViews)) {
            UIView *redView = self.circleViews.lastObject;
            redView.hidden = YES;
        }
    }else{
        if (!ArrayIsEmpty(self.circleViews)) {
            UIView *redView = self.circleViews.lastObject;
            redView.hidden = NO;
        }
    }
}
#pragma mark - Getter
-(NSMutableArray *)circleViews
{
    if (!_circleViews) {
        _circleViews = [[NSMutableArray alloc]init];
    }
    return _circleViews;
}

-(void)dealloc
{
    [MessageManager removeKey:self];
}
@end



