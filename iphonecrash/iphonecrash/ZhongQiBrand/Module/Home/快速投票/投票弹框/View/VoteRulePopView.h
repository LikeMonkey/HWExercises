//
//  VoteRulePopView.h
//  ZhongQiBrand
//
//  Created by iOS on 2019/10/22.
//  Copyright © 2019 CY. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef enum : NSUInteger {
    VoteRuleTypeDuring = 0,          // 在投票时间内，在XX分钟后可以进行投票
    VoteRuleTypeOverTime = 1,        // 晚24:00 — 早7:00之间不可进行投票
} VoteRuleType;

@interface VoteRulePopView : UIView

+ (instancetype)showContent:(NSString *)content ruleType:(VoteRuleType)ruleType;

@end

NS_ASSUME_NONNULL_END
