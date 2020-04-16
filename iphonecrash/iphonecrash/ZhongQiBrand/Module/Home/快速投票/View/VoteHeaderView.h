//
//  VoteHeaderView.h
//  ZhongQiBrand
//
//  Created by 孙程 on 2019/9/17.
//  Copyright © 2019 CY. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CycleTitleView.h"

NS_ASSUME_NONNULL_BEGIN

typedef void(^VoteHeaderViewButtonClickBlock)(UIButton *btn);

@interface VoteHeaderView : UIView

@property (nonatomic, strong) UILabel *titleLab;
@property (nonatomic, strong) UILabel *descriptionLab;
@property (nonatomic, strong) CycleTitleView *runLab;
@property (nonatomic, copy)   VoteHeaderViewButtonClickBlock buttonClickBlock;
//已经改变了搜索的 文本变化
@property (nonatomic,copy)void(^searchTextDidChange)(NSString *searchText);

//点击键盘上的搜索
@property (nonatomic,copy)void(^searchReturnBlock)(NSString *searchText);



@end

NS_ASSUME_NONNULL_END
