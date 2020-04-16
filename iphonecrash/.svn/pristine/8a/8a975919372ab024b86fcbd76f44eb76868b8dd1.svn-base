//
//  SettingFooterView.m
//  ZhongQiBrand
//
//  Created by iOS on 2019/10/23.
//  Copyright © 2019 CY. All rights reserved.
//

#import "SettingFooterView.h"

@interface SettingFooterView ()
@property (nonatomic, strong) UIView *topSpace;
@property (nonatomic, strong) UIView *deleteCacheView;
@property (nonatomic, strong) UILabel *leftLabel;
@property (nonatomic, strong) UILabel *rightLabel;
@property (nonatomic, strong) UIButton *rightBtn;
@property (nonatomic, strong) UIView *verticalLine;

@property (nonatomic, strong) UIView *spaceView;
@property (nonatomic, strong) UIButton *loginOutBtn;

@end

@implementation SettingFooterView
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setUpUI];
    }
    return self;
}

- (void)setUpUI {
    
    [self addSubview:self.topSpace];
    [self addSubview:self.deleteCacheView];
    [self.deleteCacheView addSubview:self.leftLabel];
    [self.deleteCacheView addSubview:self.rightBtn];
    [self.deleteCacheView addSubview:self.verticalLine];
    [self.deleteCacheView addSubview:self.rightLabel];
    
    [self addSubview:self.spaceView];
    [self addSubview:self.loginOutBtn];
    
    [self.topSpace mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.top.mas_equalTo(0);
        make.height.mas_equalTo(8 * scaleX);
    }];
    
    [self.deleteCacheView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.top.equalTo(self.topSpace.mas_bottom).offset(0);
        make.height.mas_equalTo(54 * scaleX);
    }];
   
    [self.leftLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15 * scaleX);
        make.centerY.mas_equalTo(0);
    }];
    
    [self.rightBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-15 * scaleX);
        make.centerY.mas_equalTo(0);
    }];
    
    [self.verticalLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.rightBtn.mas_left).offset(-10 * scaleX);
        make.centerY.mas_equalTo(0);
        make.width.mas_equalTo(1 * scaleX);
        make.height.mas_equalTo(12 * scaleX);
    }];
    
    [self.rightLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.verticalLine.mas_left).offset(-10 * scaleX);
        make.centerY.mas_equalTo(0);
    }];
    
    [self.spaceView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.top.equalTo(self.deleteCacheView.mas_bottom).offset(0);
        make.height.mas_equalTo(8 * scaleX);
    }];
    
    [self.loginOutBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.top.equalTo(self.spaceView.mas_bottom).offset(0);
        make.height.mas_equalTo(54 * scaleX);
    }];
}

#pragma mark - Private Method
- (void)rightBtnClicked {
    if (self.clickDeleteCacheBlock) {
        self.clickDeleteCacheBlock();
    }
}

- (void)loginOutBtnClicked {
    if (self.clickLoginoutBlock) {
        self.clickLoginoutBlock();
    }
}

#pragma mark - 懒加载
- (UIView *)topSpace {
    if (!_topSpace) {
        _topSpace = [[UIView alloc]init];
        _topSpace.backgroundColor = [UIColor colorWithHexString:@"#F8F8F8"];
    }
    return _topSpace;
}
- (UIView *)deleteCacheView {
    if (!_deleteCacheView) {
        _deleteCacheView = [[UIView alloc]init];
        _deleteCacheView.backgroundColor = [UIColor whiteColor];
    }
    return _deleteCacheView;
}

- (UILabel *)leftLabel {
    if (!_leftLabel) {
        _leftLabel = [[UILabel alloc]init];
        _leftLabel.textAlignment = NSTextAlignmentLeft;
        _leftLabel.textColor = [UIColor blackColor];
        _leftLabel.font = [UIFont systemFontOfSize:17];
        _leftLabel.text = @"清除缓存";
    }
    return _leftLabel;
}

- (UILabel *)rightLabel {
    if (!_rightLabel) {
        _rightLabel = [[UILabel alloc]init];
        _rightLabel.textAlignment = NSTextAlignmentRight;
        _rightLabel.text = @"0M";
        _rightLabel.textColor = [UIColor colorWithHexString:@"#666666"];
        _rightLabel.font = [UIFont systemFontOfSize:16];
    }
    return _rightLabel;
}

- (UIButton *)rightBtn {
    if (!_rightBtn) {
        _rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_rightBtn setTitle:@"立即清除" forState:UIControlStateNormal];
        [_rightBtn setTitleColor:[UIColor colorWithHexString:@"#FE534D"] forState:UIControlStateNormal];
        [_rightBtn addTarget:self action:@selector(rightBtnClicked) forControlEvents:UIControlEventTouchUpInside];
        _rightBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    }
    return _rightBtn;
}

- (UIView *)verticalLine {
    if (!_verticalLine) {
        _verticalLine = [[UIView alloc]init];
        _verticalLine.backgroundColor = [UIColor colorWithHexString:@"#E6E6E6"];
    }
    return _verticalLine;
}

- (UIView *)spaceView {
    if (!_spaceView) {
        _spaceView = [[UIView alloc]init];
        _spaceView.backgroundColor = [UIColor colorWithHexString:@"#F8F8F8"];
    }
    return _spaceView;
}

- (UIButton *)loginOutBtn {
    if (!_loginOutBtn) {
        _loginOutBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_loginOutBtn setTitle:@"退出登录" forState:UIControlStateNormal];
        [_loginOutBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        _loginOutBtn.titleLabel.font = [UIFont systemFontOfSize:17];
        _loginOutBtn.backgroundColor = [UIColor whiteColor];
        
        [_loginOutBtn addTarget:self action:@selector(loginOutBtnClicked) forControlEvents:UIControlEventTouchUpInside];
        
    }
    return _loginOutBtn;
}
@end
