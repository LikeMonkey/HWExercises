//
//  JoinWaitFootView.m
//  ZhongQiBrand
//
//  Created by iOS002 on 2019/10/21.
//  Copyright © 2019 CY. All rights reserved.
//

#import "JoinWaitFootView.h"
@interface JoinWaitFootView()
@property (nonatomic, strong) UIImageView *iconImageView;
@property (nonatomic, strong) UILabel *waitTiteLabel;
@property (nonatomic, strong) UILabel *contentLabel;
@property (nonatomic, strong) UIButton *contactBtn;

@end
@implementation JoinWaitFootView


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self layoutJoinWaitFootView];
    }
    return self;
}

- (void)layoutJoinWaitFootView
{
    [self addSubview:self.iconImageView];
    [self.iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.mas_top).offset(px_scale(30));
        make.centerX.mas_equalTo(self.mas_centerX);
        make.height.width.equalTo(@(px_scale(120)));
    }];
    
    [self addSubview:self.waitTiteLabel];
    [self.waitTiteLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.iconImageView.mas_bottom).offset(px_scale(50));
         make.centerX.mas_equalTo(self.mas_centerX);
        make.width.height.mas_greaterThanOrEqualTo(0);
    }];
    
    [self addSubview:self.contentLabel];
    [self.contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.waitTiteLabel.mas_bottom).offset(px_scale(10));
        make.centerX.mas_equalTo(self.mas_centerX);
        make.width.height.mas_greaterThanOrEqualTo(0);
    }];
    [self addSubview:self.contactBtn];
    [self.contactBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.contentLabel.mas_bottom).offset(px_scale(326));
        make.left.mas_equalTo(self.mas_left).offset(px_scale(30));
        make.right.mas_equalTo(self.mas_right).offset(-px_scale(30));
        make.height.mas_equalTo(px_scale(88));
    }];
}

- (UIImageView *)iconImageView
{
    if (!_iconImageView) {
        _iconImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"jrpp_ddsh_icon"]];
    }
    return _iconImageView;
}

-(UILabel *)waitTiteLabel{
    
    if (!_waitTiteLabel) {
        _waitTiteLabel = [UILabel new];
        _waitTiteLabel.text = @"等待审核";
        _waitTiteLabel.font = [UIFont boldSystemFontOfSize:16];
        _waitTiteLabel.textColor = [UIColor colorWithHexString:@"#333333"];
        _waitTiteLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _waitTiteLabel;
}

-(UILabel *)contentLabel{
    
    if (!_contentLabel) {
        _contentLabel = [UILabel new];
        _contentLabel.text = @"您的资料已经提交成功\n工作人员审核需要1-2个工作日，请耐心等待";
        _contentLabel.font = [UIFont systemFontOfSize:12];
        _contentLabel.textColor = [UIColor colorWithHexString:@"#999999"];
        _contentLabel.numberOfLines = 2;
        _contentLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _contentLabel;
}

- (UIButton *)contactBtn
{
    if (!_contactBtn) {
        _contactBtn = [UIButton new];
        _contactBtn.backgroundColor = [UIColor colorWithHexString:@"#D3141C"];
        [_contactBtn setTitle:@"联系客服" forState:UIControlStateNormal];
        _contactBtn.layer.cornerRadius = px_scale(44);
    }
    return _contactBtn;
}
@end
