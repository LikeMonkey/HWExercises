//
//  IntroductionPopView.m
//  ZhongQiBrand
//
//  Created by iOS on 2019/10/22.
//  Copyright © 2019 CY. All rights reserved.
//

#import "IntroductionPopView.h"
#import "UIWindow+FrontWindow.h"

@interface IntroductionPopView ()

@property (nonatomic, strong) UIView *maskView;
@property (nonatomic, strong) UIView *bgView;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *contentLabel;
@property (nonatomic, strong) UIImageView *shadowImg;
@property (nonatomic, strong) UIButton *sureBtn;

@end

@implementation IntroductionPopView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        [self maskView];
        [self bgView];
        [self titleLabel];
        [self shadowImg];
        [self sureBtn];
        [self contentLabel];
    }
    return self;
}

+ (instancetype)showContent:(NSString *)content {
    
    IntroductionPopView *introductionView = [[IntroductionPopView alloc] initWithFrame:CGRectMake(0, 0, MAINScreenWidth, MAINScreenHeight)];
    [introductionView showContent:content];
    [introductionView show];
    return introductionView;
    
}

- (void)showContent:(NSString *)content {
    self.contentLabel.text = content;
}

- (void)show{
    UIWindow *window = [UIWindow frontWindow];
    [window addSubview:self];
}

- (void)sureBtnClicked:(UIButton *)sender {
    [self hiden];
}

- (void)clickAction {
    [self hiden];
}

- (void)hiden{
    [self removeFromSuperview];
}

#pragma mark - 懒加载
- (UIView *)maskView {
    if (!_maskView) {
        _maskView = [[UIView alloc]init];
        _maskView.backgroundColor = [UIColor colorWithWhite:0 alpha:0.5];
        _maskView.userInteractionEnabled = YES;
        //添加点击手势
        UITapGestureRecognizer *click = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickAction)];
        [_maskView addGestureRecognizer:click];
        
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
        _bgView.backgroundColor =  [UIColor whiteColor];
        _bgView.layer.cornerRadius = 10;
        _bgView.clipsToBounds = YES;
        _bgView.layer.borderColor = (__bridge CGColorRef _Nullable)([UIColor colorWithHexString:@"#FFFFFF"]);
        _bgView.layer.borderWidth = 1 * scaleX;
        
        [self.maskView addSubview:_bgView];
        [_bgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(0);
            make.centerY.mas_equalTo(0);
            make.width.mas_equalTo(275 * scaleX);
            make.height.mas_equalTo(245 * scaleX);
        }];
    }
    return _bgView;
}

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc]init];
        _titleLabel.text = @"行业介绍";
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.textColor = [UIColor colorWithHexString:@"#333333"];
        _titleLabel.font = [UIFont boldSystemFontOfSize:19];
        
        [self.bgView addSubview:_titleLabel];
        [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(0);
            make.top.mas_equalTo(20 * scaleX);
        }];
    }
    return _titleLabel;
}

- (UIImageView *)shadowImg {
    if (!_shadowImg) {
        _shadowImg = [[UIImageView alloc]init];
        _shadowImg.contentMode = UIViewContentModeScaleAspectFit;
        _shadowImg.image = [UIImage imageNamed:@"home_shadow_img"];
        
        [self.bgView addSubview:_shadowImg];
        [_shadowImg mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(0);
            make.top.equalTo(self.titleLabel.mas_bottom).offset(-7.5 * scaleX);
            make.width.mas_equalTo(74 * scaleX);
            make.height.mas_equalTo(11 * scaleX);
        }];
    }
    return _shadowImg;
}

- (UIButton *)sureBtn {
    if (!_sureBtn) {
        _sureBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        UIImage *image = [UIImage imageNamed:@"home_sure_icon"];
        [_sureBtn setImage:image forState:UIControlStateNormal];
        
        [_sureBtn addTarget:self action:@selector(sureBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
        
        [self.bgView addSubview:_sureBtn];
        [_sureBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.mas_equalTo(-8 * scaleX);
            make.centerX.mas_equalTo(0);
            make.width.mas_equalTo(image.size.width);
            make.height.mas_equalTo(image.size.height);
        }];
    }
    return _sureBtn;
}

- (UILabel *)contentLabel {
    if (!_contentLabel) {
        _contentLabel = [[UILabel alloc]init];
        _contentLabel.textAlignment = NSTextAlignmentLeft;
        _contentLabel.textColor = [UIColor colorWithHexString:@"#333333"];
        _contentLabel.font = [UIFont systemFontOfSize:13];
        _contentLabel.numberOfLines = 0;
        [self.bgView addSubview:_contentLabel];
        [_contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(20 * scaleX);
            make.right.mas_equalTo(-15 * scaleX);
            make.top.equalTo(self.shadowImg.mas_bottom).offset(20 * scaleX);
            make.bottom.equalTo(self.sureBtn.mas_top).offset(-11 * scaleX);
        }];
    }
    return _contentLabel;
}

@end
