//
//  JoinAuthFootView.m
//  ZhongQiBrand
//
//  Created by iOS002 on 2019/10/21.
//  Copyright © 2019 CY. All rights reserved.
//

#import "JoinAuthFootView.h"
@interface JoinAuthFootView()
@property (nonatomic, strong) UIButton *customServeBtn;
@property (nonatomic, strong) UIButton *submitBtn;
@end

@implementation JoinAuthFootView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self layoutJoinAuthFootView];
    }
    return self;
}


#pragma mark - 私有方法
- (void)clickCustomServeBtnAction
{
    if (self.clickServeBlock) {
        self.clickServeBlock();
    }
}

- (void)clickNextBtnAction
{
    if (self.clickNextBlock) {
        self.clickNextBlock();
    }
}

#pragma mark - 布局
- (void)layoutJoinAuthFootView
{
    [self addSubview:self.customServeBtn];
    [self.customServeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.mas_top).offset(px_scale(88));
        make.left.mas_equalTo(self.mas_left).offset(px_scale(30));
        make.height.equalTo(@(px_scale(88)));
        make.width.equalTo(@(px_scale(210)));
    }];
    
    [self addSubview:self.submitBtn];
    
    [self.submitBtn mas_makeConstraints:^(MASConstraintMaker *make) {
           make.top.mas_equalTo(self.mas_top).offset(px_scale(88));
           make.right.mas_equalTo(self.mas_right).offset(-px_scale(30));
           make.height.equalTo(@(px_scale(88)));
           make.width.equalTo(@(px_scale(416)));
       }];

}

#pragma mark - getter 方法

- (UIButton *)customServeBtn
{
   if (!_customServeBtn) {
        _customServeBtn = [UIButton new];
        _customServeBtn.backgroundColor = [UIColor colorWithHexString:@"#E2C87B"];
        [_customServeBtn setTitle:@"客服" forState:UIControlStateNormal];
          [_customServeBtn setImage:[UIImage imageNamed:@"kf_icon_img"] forState:UIControlStateNormal];
        _customServeBtn.imageEdgeInsets = UIEdgeInsetsMake(px_scale(26), px_scale(46), px_scale(26), px_scale(120));
        _customServeBtn.titleEdgeInsets = UIEdgeInsetsMake(px_scale(26), px_scale(46), px_scale(26), px_scale(46));
        _customServeBtn.titleLabel.textAlignment = NSTextAlignmentLeft;
        _customServeBtn.layer.cornerRadius = px_scale(44);
         [_customServeBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
         _customServeBtn.titleLabel.font  =[UIFont systemFontOfSize:16];
        [_customServeBtn setImage:[UIImage imageNamed:@"kf_icon_img"] forState:UIControlStateNormal];
       [_customServeBtn addTarget:self action:@selector(clickCustomServeBtnAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _customServeBtn;
}

- (UIButton *)submitBtn
{
    if (!_submitBtn) {
        _submitBtn = [UIButton new];
        _submitBtn.backgroundColor = [UIColor colorWithHexString:@"#D3141C"];
        [_submitBtn setTitle:@"下一步" forState:UIControlStateNormal];
        _submitBtn.layer.cornerRadius = px_scale(44);
        [_submitBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _submitBtn.titleLabel.font  =[UIFont systemFontOfSize:16];
        [_submitBtn addTarget:self action:@selector(clickNextBtnAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _submitBtn;
}


@end
