//
//  HWLuanchVC.m
//  HWExercises
//
//  Created by sxmaps_w on 2017/5/22.
//  Copyright © 2017年 wqb. All rights reserved.
//

#import "HWLuanchVC.h"

@interface HWLuanchVC ()

@end

@implementation HWLuanchVC

- (void)viewDidLoad {
    [super viewDidLoad];

}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    [self addRootVC];
}

- (void)addRootVC
{
    //视图数组
    NSArray* controllerArr = @[@"HWHomeVC", @"HWExercisesVC", @"HWMeVC"];
    //图片数组
    NSArray* imageArr = @[@"", @"", @""];
    //高亮图片数组
    NSArray* selImageArr = @[@"", @"", @""];
    //标题数组
    NSArray *titleArr = @[@"首页", @"做题", @"我的"];
    
    NSMutableArray *array = [NSMutableArray array];
    for (int i = 0; i < controllerArr.count; i ++) {
        Class controller = NSClassFromString(controllerArr[i]);
        UIViewController *vc = [[controller alloc] init];
        UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:vc];
        nav.tabBarItem.image = [[UIImage imageNamed:imageArr[i]] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        nav.tabBarItem.selectedImage = [[UIImage imageNamed:selImageArr[i]] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        nav.tabBarItem.imageInsets = UIEdgeInsetsMake(6, 0, - 6, 0);
        nav.tabBarItem.title = titleArr[i];
        [array addObject:nav];
    }
    
    UITabBarController *tabbarController = [[UITabBarController alloc] init];
    tabbarController.viewControllers = array;
    tabbarController.selectedIndex = 0;
    tabbarController.tabBar.barTintColor = KWhiteColor;
    self.view.window.rootViewController = tabbarController;
}

@end
