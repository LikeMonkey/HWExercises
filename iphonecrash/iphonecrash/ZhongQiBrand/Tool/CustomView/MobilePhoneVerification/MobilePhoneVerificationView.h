//
//  MobilePhoneVerificationView.h
//  VoteCloud
//
//  Created by 孙程 on 2019/8/16.
//  Copyright © 2019 CY. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^MobilePhoneVerificationViewButtonClickBlock)(UIButton *btn);

@interface MobilePhoneVerificationView : UIView

+ (instancetype)showWithHandler:(MobilePhoneVerificationViewButtonClickBlock)block;

@end

NS_ASSUME_NONNULL_END
