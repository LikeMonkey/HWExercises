//
//  FastVoteItemCell.h
//  ZhongQiBrand
//
//  Created by ios2 on 2019/9/17.
//  Copyright © 2019 CY. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FastVoteItemCell : UICollectionViewCell

@property (nonatomic,strong)UIImageView *bgImageView;
@property (nonatomic,strong)UILabel *industryLable; //行业标题
@property (nonatomic,strong)UILabel *tenBrandLable; //品牌副标题
@property (nonatomic,strong)UIButton *voteButton; //立即投票按钮

@property (nonatomic,strong)id model;

@end

