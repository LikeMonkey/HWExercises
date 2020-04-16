//
//  GiftOrderPayResultViewController.h
//  ZhongQiBrand
//
//  Created by ios 001 on 2019/10/22.
//  Copyright © 2019 CY. All rights reserved.
//

#import "BaseViewController.h"
//定义枚举类型
typedef enum PayResultState {
    payResultSuccess  = 0,
    payResultfailer
} PayResultState;

NS_ASSUME_NONNULL_BEGIN

@interface GiftOrderPayResultViewController : BaseViewController

@property (nonatomic,assign) PayResultState resultState;

@end

NS_ASSUME_NONNULL_END
