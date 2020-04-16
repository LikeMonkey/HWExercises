//
//  MineHeaderView.h
//  ZhongQiBrand
//
//  Created by iOS on 2019/10/14.
//  Copyright © 2019 CY. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface MineHeaderView : UIView

@property (nonatomic, strong) UIImageView *icon;
@property (nonatomic, strong) UIImageView *userHeaderImg;
@property (nonatomic, strong) UIButton *loginBtn;
@property (nonatomic, strong) UILabel *nickNameLbl;
@property (nonatomic, strong) UILabel *descripLabel;

@property (nonatomic, copy) void (^clickLoginBlock)(void);
@property (nonatomic, assign) BOOL islogin;

@end

NS_ASSUME_NONNULL_END
