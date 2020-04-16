//
//  QrScanTabBar.h
//  ZhongQiBrand
//
//  Created by ios2 on 2019/9/16.
//  Copyright © 2019 CY. All rights reserved.
//

#import <UIKit/UIKit.h>

@class QrScanTabBar;

@protocol QrScanTabBarDelegate<NSObject>

@optional

-(void)qrScanBar:(QrScanTabBar *)tabbar  scanClicked:(UIButton *)scanButton;

-(UIImage *)qrScanBar:(QrScanTabBar *)tabbar scanButton:(UIButton *)scanButton;

@end


@interface QrScanTabBar : UITabBar

@property (nonatomic, strong) UIButton  *bigButton;

@property(nonatomic,weak)id <QrScanTabBarDelegate>  qrDelegate;


@end

