//
//  HomeHotTableViewCell.h
//  ZhongQiBrand
//
//  Created by ios2 on 2019/9/17.
//  Copyright © 2019 CY. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface HomeHotTableViewCell : UITableViewCell
<UICollectionViewDataSource,
UICollectionViewDelegate>

@property (nonatomic,strong)NSArray *brandArray; //品牌数组

@property (nonatomic,strong)UICollectionView *myCollectionView;
@property (nonatomic,strong)UIPageControl *pageControl;

+(CGFloat)hotListHeight;

@end

NS_ASSUME_NONNULL_END
