//
//  HeadLinesBaseCell.h
//  ZhongQiBrand
//
//  Created by ios2 on 2019/9/21.
//  Copyright © 2019 CY. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HeadLinesBaseCell : UITableViewCell
@property (nonatomic,strong)UILabel *platformLable;
@property (nonatomic,strong)UILabel *timeLable;
@property (nonatomic,strong)UIImageView *timeThumb;

@property (nonatomic,strong)UIImageView *thumb;
@property (nonatomic,strong)UILabel *titleLable;

@property (nonatomic,strong)UIView *spaceLine;

@property (nonatomic,strong)id model; //赋值数据

//设置 视图的 约束  子类实现
-(void)setViewLayout;

@end

