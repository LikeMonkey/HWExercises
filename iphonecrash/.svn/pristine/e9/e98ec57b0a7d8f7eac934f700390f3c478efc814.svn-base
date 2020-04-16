//
//  MineHeaderView.m
//  ZhongQiBrand
//
//  Created by iOS on 2019/10/14.
//  Copyright © 2019 CY. All rights reserved.
//

#import "MineHeaderView.h"

@interface MineHeaderView ()
/** 分割线 */
@property (nonatomic, strong) UIView *lineView;
@end

@implementation MineHeaderView
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setUpUI];
    }
    return self;
    
}

/** 视图初始化 */
- (void)setUpUI {
    
    [self addSubview:self.icon];
    [self addSubview:self.userHeaderImg];
    [self addSubview:self.nickNameLbl];
    [self addSubview:self.loginBtn];
    [self addSubview:self.descripLabel];
    [self addSubview:self.lineView];
    
    [self.icon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(0);
        make.top.mas_equalTo(px_scale(146));
        make.width.height.mas_equalTo(px_scale(128));
    }];
    
    [self.userHeaderImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(0);
        make.top.mas_equalTo(px_scale(189));
        make.width.height.mas_equalTo(px_scale(180));
    }];
    
    [self.nickNameLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(0);
        make.top.equalTo(self.userHeaderImg.mas_bottom).offset(px_scale(30));
        make.left.mas_equalTo(17);
        make.right.mas_equalTo(-17);
    }];
    
    [self.loginBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(0);
        make.top.equalTo(self.icon.mas_bottom).offset(px_scale(48));
        make.width.mas_equalTo(px_scale(340));
        make.height.mas_equalTo(px_scale(120));
    }];
    
    [self.descripLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(0);
        make.top.equalTo(self.loginBtn.mas_bottom).offset(0);
        make.left.mas_equalTo(17);
        make.right.mas_equalTo(-17);
    }];
    
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.mas_equalTo(0);
        make.height.mas_equalTo(8);
    }];
    
}

- (void)loginClicked {
    if (self.clickLoginBlock) {
        self.clickLoginBlock();
    }
}

- (void)setIslogin:(BOOL)islogin{
    _islogin = islogin;
    self.loginBtn.hidden    = islogin;
    self.descripLabel.hidden = islogin;
    self.icon.hidden = islogin;
    self.userHeaderImg.hidden = !islogin;
    self.nickNameLbl.hidden = !islogin;
}

#pragma mark --- 懒加载
- (UIImageView *)icon{
    if (!_icon) {
        _icon = [[UIImageView alloc] init];
        _icon.image = [UIImage imageNamed:@""];
        _icon.contentMode = UIViewContentModeScaleAspectFit;
    }
    return _icon;
}

- (UIImageView *)userHeaderImg {
    if (!_userHeaderImg) {
        _userHeaderImg = [[UIImageView alloc] init];
        _userHeaderImg.contentMode = UIViewContentModeScaleAspectFill;
        _userHeaderImg.layer.masksToBounds = YES;
        _userHeaderImg.layer.borderColor = [UIColor colorWithHexString:@"#FFBEBE"].CGColor;
        _userHeaderImg.layer.borderWidth = 2;
        _userHeaderImg.layer.cornerRadius = px_scale(180) / 2.0;
        _userHeaderImg.hidden = YES;
    }
    return _userHeaderImg;
}

- (UIButton *)loginBtn{
    if (!_loginBtn) {
        _loginBtn = [[UIButton alloc] init];
        [_loginBtn setTitle:@"注册/登录" forState:UIControlStateNormal];
        [_loginBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _loginBtn.titleLabel.font = [UIFont boldSystemFontOfSize:20];
        [_loginBtn setBackgroundImage:[UIImage imageNamed:@"wd_zcdl_btn"] forState:UIControlStateNormal];
        _loginBtn.contentVerticalAlignment = UIControlContentVerticalAlignmentTop;
        _loginBtn.titleEdgeInsets = UIEdgeInsetsMake(13 * scaleX, 0, 0, 0);

        [_loginBtn addTarget:self action:@selector(loginClicked) forControlEvents:UIControlEventTouchUpInside];
    }
    return _loginBtn;
}

- (UILabel *)nickNameLbl{
    if (!_nickNameLbl) {
        _nickNameLbl = [[UILabel alloc] init];
        _nickNameLbl.textColor = [UIColor colorWithHexString:@"#333333"];
        _nickNameLbl.textAlignment = NSTextAlignmentCenter;
        _nickNameLbl.font = [UIFont boldSystemFontOfSize:20];
        _nickNameLbl.hidden = YES;
    }
    return _nickNameLbl;
}

- (UILabel *)descripLabel {
    if (!_descripLabel) {
        _descripLabel = [[UILabel alloc] init];
        _descripLabel.textColor = [UIColor colorWithHexString:@"#7B7B7B"];
        _descripLabel.textAlignment = NSTextAlignmentCenter;
        _descripLabel.text = @"了解更多品牌活动";
        _descripLabel.font = [UIFont boldSystemFontOfSize:13];
    }
    return _descripLabel;
}
- (UIView *)lineView{
    if (!_lineView) {
        _lineView = [[UIView alloc] init];
        _lineView.backgroundColor = [UIColor colorWithHexString:@"#F8F8F8"];
    }
    return _lineView;
}
@end
