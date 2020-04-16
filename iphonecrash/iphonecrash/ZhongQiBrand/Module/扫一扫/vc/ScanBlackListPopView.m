//
//  ScanBlackListPopView.m
//  ZhongQiBrand
//
//  Created by iOS on 2019/10/22.
//  Copyright © 2019 CY. All rights reserved.
//

#import "ScanBlackListPopView.h"
#import "UIWindow+FrontWindow.h"

@interface ScanBlackListPopView ()

@property (nonatomic, strong) UIView *maskView;
@property (nonatomic, strong) UIView *bgView;
@property (nonatomic, strong) UIImageView *iconImg;
@property (nonatomic, strong) UILabel *errorLabel;
@property (nonatomic, strong) UILabel *descripLabel;
@property (nonatomic, strong) UIButton *wechatBtn;
@property (nonatomic, strong) UIButton *phoneBtn;

@end

@implementation ScanBlackListPopView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        [self maskView];
        [self bgView];
        [self iconImg];
        [self errorLabel];
        [self descripLabel];
        [self wechatBtn];
        [self phoneBtn];
    }
    return self;
}

+ (instancetype)showErrorStr:(NSString *)errorStr descripStr:(NSString *)descripStr {
    ScanBlackListPopView *blackListView = [[ScanBlackListPopView alloc] initWithFrame:CGRectMake(0, 0, MAINScreenWidth, MAINScreenHeight)];
    [blackListView show:errorStr descripStr:descripStr];
    [blackListView show];
    return blackListView;
}

- (void)show:(NSString *)errorStr descripStr:(NSString *)descripStr {
    self.errorLabel.text = errorStr;
    self.descripLabel.text = descripStr;
}

- (void)show{
    UIWindow *window = [UIWindow frontWindow];
    [window addSubview:self];
}

- (void)hiden{
    [self removeFromSuperview];
}

#pragma mark - private Method
- (void)wechatBtnClicked:(UIButton *)sender {
    SHOW_MSG(@"微信客服", 1);
    [self hiden];
}

- (void)phoneBtnClicked:(UIButton *)sender {
    SHOW_MSG(@"电话客服", 1);
    [self hiden];
}

#pragma mark - 懒加载
- (UIView *)maskView {
    if (!_maskView) {
        _maskView = [[UIView alloc]init];
        _maskView.backgroundColor = [UIColor colorWithWhite:0 alpha:0.88];
        
        [self addSubview:_maskView];
        [_maskView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self).with.insets(UIEdgeInsetsMake(0, 0, 0, 0));
        }];
    }
    return _maskView;
}

- (UIView *)bgView {
    if (!_bgView) {
        _bgView = [[UIView alloc]init];
        _bgView.backgroundColor = [UIColor whiteColor];
        _bgView.layer.cornerRadius = 10;
        _bgView.clipsToBounds = YES;
        _bgView.layer.borderColor = (__bridge CGColorRef _Nullable)([UIColor colorWithHexString:@"#FFFFFF"]);
        _bgView.layer.borderWidth = 1 * scaleX;
        [self.maskView addSubview:self.bgView];
        [_bgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(0);
            make.centerY.mas_equalTo(0);
            make.width.mas_equalTo(275 * scaleX);
            make.height.mas_equalTo(250 * scaleX);
        }];
    }
    return _bgView;
}

- (UIImageView *)iconImg {
    if (!_iconImg) {
        _iconImg = [[UIImageView alloc]init];
        _iconImg.contentMode = UIViewContentModeScaleAspectFit;
        _iconImg.image = [UIImage imageNamed:@"scan_tanhao_icon"];
        [self.bgView addSubview:_iconImg];
        [_iconImg mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(0);
            make.top.mas_equalTo(25 * scaleX);
            make.width.mas_equalTo(70 * scaleX);
            make.height.mas_equalTo(77.5 * scaleX);
        }];
    }
    return _iconImg;
}

- (UILabel *)errorLabel {
    if (!_errorLabel) {
        _errorLabel = [[UILabel alloc]init];
        _errorLabel.textColor = [UIColor colorWithHexString:@"#333333"];
        _errorLabel.textAlignment = NSTextAlignmentCenter;
        _errorLabel.font = [UIFont systemFontOfSize:12];
        _errorLabel.text = @"错误ID:123456789";
        [self.bgView addSubview:_errorLabel];
        [_errorLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(0);
            make.top.equalTo(self.iconImg.mas_bottom).offset(10 * scaleX);
        }];
    }
    return _errorLabel;
}

- (UILabel *)descripLabel {
    if (!_descripLabel) {
        _descripLabel = [[UILabel alloc]init];
        _descripLabel.textColor = [UIColor colorWithHexString:@"#999999"];
        _descripLabel.textAlignment = NSTextAlignmentCenter;
        _descripLabel.font = [UIFont systemFontOfSize:12];
        _descripLabel.text = @"您的微信号存在异常如有疑问请联系客服";
        [self.bgView addSubview:_descripLabel];
        [_descripLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(0);
            make.top.equalTo(self.errorLabel.mas_bottom).offset(10 * scaleX);
        }];
    }
    return _descripLabel;
}

- (UIButton *)wechatBtn {
    if (!_wechatBtn) {
        _wechatBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_wechatBtn setTitle:@"微信客服" forState:UIControlStateNormal];
        [_wechatBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _wechatBtn.titleLabel.font = [UIFont boldSystemFontOfSize:16];
        [_wechatBtn setBackgroundImage:[UIImage imageNamed:@"sys_hmd_img"] forState:UIControlStateNormal];
        _wechatBtn.contentVerticalAlignment = UIControlContentVerticalAlignmentTop;
        _wechatBtn.titleEdgeInsets = UIEdgeInsetsMake(13 * scaleX, 0, 0, 0);
        [_wechatBtn addTarget:self action:@selector(wechatBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
        [self.bgView addSubview:_wechatBtn];
        [_wechatBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(18.5 * scaleX);
            make.bottom.mas_equalTo(-13 * scaleX);
            make.width.mas_equalTo(113 * scaleX);
            make.height.mas_equalTo(53 * scaleX);
        }];
    }
    return _wechatBtn;
}

- (UIButton *)phoneBtn {
    if (!_phoneBtn) {
        _phoneBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_phoneBtn setTitle:@"电话客服" forState:UIControlStateNormal];
        [_phoneBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _phoneBtn.titleLabel.font = [UIFont boldSystemFontOfSize:16];
        [_phoneBtn setBackgroundImage:[UIImage imageNamed:@"sys_hmd_img"] forState:UIControlStateNormal];
        _phoneBtn.contentVerticalAlignment = UIControlContentVerticalAlignmentTop;
        _phoneBtn.titleEdgeInsets = UIEdgeInsetsMake(13 * scaleX, 0, 0, 0);
        [_phoneBtn addTarget:self action:@selector(phoneBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
        [self.bgView addSubview:_phoneBtn];
        [_phoneBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(-18.5 * scaleX);
            make.bottom.mas_equalTo(-13 * scaleX);
            make.width.mas_equalTo(113 * scaleX);
            make.height.mas_equalTo(53 * scaleX);
        }];
    }
    return _wechatBtn;
}
@end

