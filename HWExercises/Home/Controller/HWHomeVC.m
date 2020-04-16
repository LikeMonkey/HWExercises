//
//  HWHomeVC.m
//  HWExercises
//
//  Created by sxmaps_w on 2017/5/22.
//  Copyright © 2017年 wqb. All rights reserved.
//

#import "HWHomeVC.h"

@interface HWHomeVC ()

@end

@implementation HWHomeVC

- (void)viewDidLoad {
    [super viewDidLoad];

    //设置导航标题
    self.navTitle = @"首页";
    
    //监听网络状态改变
    self.network = ^(AFNetworkReachabilityStatus status) {
        NSLog(@"网络状态status：%ld", status);
    };
}

@end
