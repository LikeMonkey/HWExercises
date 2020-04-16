//
//  HotListTableViewCell.h
//  ZhongQiBrand
//
//  Created by ios2 on 2019/9/20.
//  Copyright © 2019 CY. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface HotListTableViewCell : UITableViewCell

@property (nonatomic,strong)UIImageView *bgImageView;

@property (nonatomic,strong)UILabel *titleLable;
@property (nonatomic,strong)UILabel *brandNameLable;

@property (nonatomic,strong)UILabel *timeLable;
@property (nonatomic,strong)UIImageView *timeThumb;

@property (nonatomic,strong)id model;

@end

