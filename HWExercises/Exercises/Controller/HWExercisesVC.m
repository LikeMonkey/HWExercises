//
//  HWExercisesVC.m
//  HWExercises
//
//  Created by sxmaps_w on 2017/5/22.
//  Copyright © 2017年 wqb. All rights reserved.
//

#import "HWExercisesVC.h"
#import "HWQuestionsVC.h"

@interface HWExercisesVC ()

@end

@implementation HWExercisesVC

- (void)viewDidLoad {
    [super viewDidLoad];

    //设置导航标题
    self.navTitle = @"做题";
    
    //创建控件
    [self creatControl];
}

- (void)creatControl
{
    //初始化跳转按钮
    UIButton *exeBtn = [[UIButton alloc] initWithFrame:CGRectMake(50, 50, KMainW - 100, KMainW - 100)];
    [exeBtn setTitle:@"点击进入答题页面" forState:UIControlStateNormal];
    [exeBtn setBackgroundColor:kMainColor];
    [exeBtn addTarget:self action:@selector(exeBtnOnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:exeBtn];
}

//跳转按钮点击事件
- (void)exeBtnOnClick
{
    //初始化目标控制器
    HWQuestionsVC *vc = [[HWQuestionsVC alloc] init];
    //push时隐藏tabbar
    vc.hidesBottomBarWhenPushed = YES;
    //push到目标控制器
    [self.navigationController pushViewController:vc animated:YES];
}

@end
