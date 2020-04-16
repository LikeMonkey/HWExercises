//
//  HomeFastVoteTableViewCell.h
//  ZhongQiBrand
//
//  Created by ios2 on 2019/9/17.
//  Copyright © 2019 CY. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface HomeFastVoteTableViewCell : UITableViewCell

//投票数据配置
@property (nonatomic,strong)NSArray *dataArray;//配置数据

@property (nonatomic,strong)UICollectionView *myCollectionView;
@property (nonatomic,strong)UIPageControl *pageControl;

+(CGFloat)fastVoteCellHeight;

@end

NS_ASSUME_NONNULL_END
