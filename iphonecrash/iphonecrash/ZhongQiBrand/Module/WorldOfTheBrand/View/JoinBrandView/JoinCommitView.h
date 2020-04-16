//
//  JoinCommitView.h
//  ZhongQiBrand
//
//  Created by ios2 on 2019/10/21.
//  Copyright © 2019 CY. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface JoinCommitView : UIView
//提交按钮
@property (nonatomic,strong)UIButton *commitButton;
//客服按钮
@property (nonatomic,strong)UIButton *customserverButton;

@property (nonatomic,copy)void(^buttonOnClickedAction)(id sender,NSInteger index);



@end

NS_ASSUME_NONNULL_END
