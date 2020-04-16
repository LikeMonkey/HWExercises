//
//  JoinBrandFootView.h
//  ZhongQiBrand
//
//  Created by iOS002 on 2019/10/21.
//  Copyright © 2019 CY. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JoinFootSelectItemView.h"
NS_ASSUME_NONNULL_BEGIN

@interface JoinBrandFootView : UIView
@property (nonatomic, copy) void (^clickServeBlock)(void);
@property (nonatomic, copy) void (^clickNextBlock)(void);
@property (nonatomic, copy) void (^clickAddImageBlock)(JoinFootSelectItemView *selectView);
@end

NS_ASSUME_NONNULL_END
