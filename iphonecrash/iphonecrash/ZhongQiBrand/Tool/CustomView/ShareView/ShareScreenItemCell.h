//
//  ShareScreenItemCell.h
//  VoteCloud
//
//  Created by ios2 on 2019/8/31.
//  Copyright © 2019 CY. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseShareScreenCell.h"
@interface ShareScreenItemCell : BaseShareScreenCell

@property (nonatomic,strong)UIImageView *userImageView; //用户图片
@property (nonatomic,strong)UILabel *numLable;//编号
@property (nonatomic,strong)UILabel *nameLable;//名称
@property (nonatomic,strong)UILabel *voteCountLable;//票数标签
@property (nonatomic,strong)UIImageView *qrCodeImageView;

@property (nonatomic,strong)UIImageView *numBgImageView;

@property (nonatomic,strong)UIView *nameLineView; // 名字底部的黄线

@property (nonatomic,strong)UILabel *qrLable;//二维码底部的标签



@end

