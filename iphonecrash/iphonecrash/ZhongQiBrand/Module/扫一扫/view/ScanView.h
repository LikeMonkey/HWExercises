//
//  ScanView.h
//  VoteCloud
//
//  Created by ios2 on 2019/8/5.
//  Copyright © 2019 CY. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ScanView : UIView
//边上矩形的颜色
@property (nonatomic,strong)UIColor *rect_color;
//线条的高度
@property(nonatomic,assign)CGFloat lineHeight;

-(void)startScanAnimation;

@end

