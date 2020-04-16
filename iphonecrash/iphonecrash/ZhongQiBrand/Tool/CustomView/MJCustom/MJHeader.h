//
//  MJHeader.h
//  VoteCloud
//
//  Created by ios2 on 2019/7/31.
//  Copyright © 2019 CY. All rights reserved.
//

#import "MJRefreshNormalHeader.h"

NS_ASSUME_NONNULL_BEGIN

@interface MJHeader : MJRefreshNormalHeader

@property(nonatomic,assign)BOOL isHiddenTopView;
//加载中文字的颜色
@property (nonatomic,strong)UIColor *textColor;

@end

NS_ASSUME_NONNULL_END
