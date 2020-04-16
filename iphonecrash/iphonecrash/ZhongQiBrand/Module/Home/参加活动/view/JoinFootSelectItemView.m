//
//  JoinFootSelectItemView.m
//  ZhongQiBrand
//
//  Created by iOS002 on 2019/10/21.
//  Copyright © 2019 CY. All rights reserved.
//

#import "JoinFootSelectItemView.h"
@interface JoinFootSelectItemView()

@end
@implementation JoinFootSelectItemView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backImageView.backgroundColor = [UIColor colorWithHexString:@"#FCFCFC"];
        [self layoutJoinFootSelectItemView];
    }
    return self;
}


- (void)layoutJoinFootSelectItemView
{
    
    [self addSubview:self.backImageView];
    [self.backImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.bottom.equalTo(self);
    }];
    [self.backImageView addSubview:self.iconImageView];
    [self.iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.mas_top).offset(px_scale(44));
        make.centerX.mas_equalTo(self.mas_centerX);
    }];
    
    [self.backImageView addSubview:self.titleLabel];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.iconImageView.mas_bottom).offset(px_scale(20));
        make.centerX.mas_equalTo(self.mas_centerX);
        make.width.height.mas_greaterThanOrEqualTo(0);
    }];
}

- (UIImageView *)iconImageView
{
    if (!_iconImageView) {
        _iconImageView = [[UIImageView alloc] init];
    }
    return _iconImageView;
}
                          
-(UILabel *)titleLabel{
    
    if (!_titleLabel) {
        _titleLabel = [UILabel new];
        _titleLabel.text = @"品牌logo*";
        _titleLabel.font = [UIFont systemFontOfSize:12];
        _titleLabel.textColor = [UIColor colorWithHexString:@"#BDBDBD"];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _titleLabel;
}

- (UIImageView *)backImageView
{
    if (!_backImageView) {
        _backImageView = [UIImageView new];
        _backImageView.userInteractionEnabled = YES;
    }
    return _backImageView;
}


@end
