//
//  CustomPageCycleScrollView.h
//  VoteCloud
//
//  Created by ios2 on 2019/8/2.
//  Copyright © 2019 CY. All rights reserved.
//

#import "SDCycleScrollView.h"


@interface SDCycleScrollView (customPageControl)

- (void)setupPageControl;
- (int)currentIndex;
- (int)pageControlIndexWithCurrentCellIndex:(NSInteger)index;
- (void)scrollViewDidScroll:(UIScrollView *)scrollView;
@end



NS_ASSUME_NONNULL_BEGIN

@interface CustomPageCycleScrollView : SDCycleScrollView

@end

NS_ASSUME_NONNULL_END
