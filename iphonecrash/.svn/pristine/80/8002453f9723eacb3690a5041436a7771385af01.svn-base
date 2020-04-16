//
//  BaseShareScreenCell.h
//  VoteCloud
//
//  Created by ios2 on 2019/9/2.
//  Copyright © 2019 CY. All rights reserved.
//

#import <UIKit/UIKit.h>

#define Share_scale(x) ((x)*452.0/750.0)    //比例尺换算

//接收到图片截屏存储的通知
static NSString * const SaveScreenImageNotificationName = @"SaveScreenImageNotificationName";

@interface BaseShareScreenCell : UICollectionViewCell

@property (nonatomic,strong)UIImageView *bgImageView;

-(void)configerShareInfo:(id)shareInfo andIndex:(NSInteger )index;

-(void)imageActionClicked:(id)sender;

@end

