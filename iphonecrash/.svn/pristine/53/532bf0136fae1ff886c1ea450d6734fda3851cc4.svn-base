//
//  JoinActivityItemView.m
//  ZhongQiBrand
//
//  Created by iOS002 on 2019/10/21.
//  Copyright © 2019 CY. All rights reserved.
//

#import "JoinActivityItemView.h"
@interface JoinActivityItemView()
@property (nonatomic, strong) UIImageView *iconImageView;
@property (nonatomic, strong) UILabel *titleLabel;
@end
@implementation JoinActivityItemView

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self layoutJoinActivityItemView];
    }
    return self;
}

- (void)setDataWithTitle:(NSString *)titleStr WithImageStr:(NSString *)imageStr WithTitleColorStr:(NSString *)colorStr
{
    self.titleLabel.text = titleStr;
    self.iconImageView.image = [UIImage imageNamed:imageStr];
    self.titleLabel.textColor = [UIColor colorWithHexString:colorStr];
    if ([colorStr isEqualToString:@"#333333"]) {
        self.titleLabel.font = [UIFont boldSystemFontOfSize:12];
    }else{
        self.titleLabel.font = [UIFont systemFontOfSize:12];
    }
}

- (void)layoutJoinActivityItemView
{
    [self addSubview:self.iconImageView];
    [self.iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.mas_top).offset(px_scale(50));
        make.centerX.mas_equalTo(self.mas_centerX);
        make.width.height.equalTo(@(px_scale(100)));
    }];
    
    [self addSubview:self.titleLabel];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.iconImageView.mas_bottom).offset(px_scale(10));
        make.centerX.mas_equalTo(self.mas_centerX);
        make.height.width.mas_greaterThanOrEqualTo(0);
    }];
}


- (UIImageView *)iconImageView
{
    if (!_iconImageView) {
        _iconImageView = [UIImageView new];
    }
    return _iconImageView;
}

-(UILabel *)titleLabel{
    
    if (!_titleLabel) {
        _titleLabel = [UILabel new];
        _titleLabel.text = @"210.00";
        _titleLabel.font = [UIFont systemFontOfSize:12];
        _titleLabel.textColor = [UIColor colorWithHexString:@"#333333"];
    }
    return _titleLabel;
}

@end
