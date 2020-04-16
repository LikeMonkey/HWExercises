//
//  VoteDetailPopView.m
//  ZhongQiBrand
//
//  Created by 孙程 on 2019/9/17.
//  Copyright © 2019 CY. All rights reserved.
//

#import "VoteDetailPopView.h"
#import "UIWindow+FrontWindow.h"

@interface VoteDetailPopView ()

@property (nonatomic, strong) UIView *maskView;
@property (nonatomic, strong) UIImageView *bgImgView;
@property (nonatomic, strong) UIImageView *trophyImgView;

@property (nonatomic, strong) UILabel *titleLab;
@property (nonatomic, strong) UILabel *timeLab;
@property (nonatomic, strong) UILabel *participateLab;

@property (nonatomic, strong) UIButton *closeBtn;

@end

@implementation VoteDetailPopView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        [self addSubview:self.maskView];
        [self addSubview:self.bgImgView];
        [self.bgImgView addSubview:self.titleLab];
        [self.bgImgView  addSubview:self.timeLab];
        [self.bgImgView  addSubview:self.participateLab];
        [self addSubview:self.trophyImgView];
        [self addSubview:self.closeBtn];
    }
    return self;
}

+ (instancetype)show:(NSString *)title time:(NSString *)time participation:(NSString *)participation{
    VoteDetailPopView *voteView = [[VoteDetailPopView alloc] initWithFrame:CGRectMake(0, 0, MAINScreenWidth, MAINScreenHeight)];
    [voteView show:title time:time participation:participation];
    [voteView show];
    return voteView;
}

- (void)show:(NSString *)title time:(NSString *)time participation:(NSString *)participation{
    
    [self addSubview:self.maskView];
    [self.maskView addSubview:self.bgImgView];
    [self.bgImgView addSubview:self.titleLab];
    [self.bgImgView addSubview:self.timeLab];
    [self.bgImgView addSubview:self.participateLab];
    [self.bgImgView addSubview:self.trophyImgView];
    [self.maskView addSubview:self.closeBtn];

    self.titleLab.text = kStringWithFormat(title);
    self.timeLab.text = kStringWithFormat(time);
    self.participateLab.text = kStringWithFormat(participation);

    [self.maskView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self).with.insets(UIEdgeInsetsMake(0, 0, 0, 0));
    }];

    [self.bgImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_offset(px_scale(520));
        make.height.mas_offset(px_scale(660));
        make.centerX.centerY.mas_equalTo(0);
    }];
    
    [self.titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(px_scale(10));
        make.top.mas_offset(px_scale(142));
        make.right.mas_offset(-px_scale(10));
        make.height.mas_offset(px_scale(67));
    }];
    
    [self.timeLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(px_scale(347));
        make.left.right.equalTo(self.titleLab);
        make.height.mas_equalTo(px_scale(30));
    }];
    
    [self.participateLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(px_scale(160));
        make.top.mas_equalTo(px_scale(490));
        make.right.mas_equalTo(-px_scale(160));
        make.height.mas_equalTo(px_scale(100));
    }];
    
    [self.trophyImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.bgImgView.mas_left).offset(-px_scale(67));
        make.bottom.equalTo(self.bgImgView.mas_bottom).offset(px_scale(57));
        make.width.mas_offset(px_scale(702));
        make.height.mas_offset(px_scale(273));
    }];
    
    [self.closeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.bgImgView);
        make.top.equalTo(self.trophyImgView.mas_bottom).offset(px_scale(40));
        make.width.height.mas_equalTo(px_scale(88));
    }];
}

- (void)close{
    [self hiden];
}

- (void)show{
    UIWindow *window = [UIWindow frontWindow];
    [window addSubview:self];
}

- (void)hiden{
    [self removeFromSuperview];
}

#pragma mark - ========= get

- (UIView *)maskView{
    if (!_maskView) {
        _maskView = [[UIView alloc] init];
        _maskView.backgroundColor = [UIColor colorWithWhite:0 alpha:0.66];
    }
    return _maskView;
}

- (UIImageView *)bgImgView{
    if (!_bgImgView) {
        _bgImgView = [[UIImageView alloc] init];
        _bgImgView.image = kGetImage(@"m_hdxq_img");
    }
    return _bgImgView;
}

- (UIImageView *)trophyImgView{
    if (!_trophyImgView) {
        _trophyImgView = [[UIImageView alloc] init];
        _trophyImgView.image = kGetImage(@"m_hdxqjb_img");
    }
    return _trophyImgView;
}

- (UILabel *)titleLab{
    if (!_titleLab) {
        _titleLab = [[UILabel alloc] init];
        _titleLab.textColor = [UIColor whiteColor];
        _titleLab.font = [UIFont boldSystemFontOfSize:24];
        _titleLab.textAlignment = NSTextAlignmentCenter;
    }
    return _titleLab;
}

- (UILabel *)timeLab{
    if (!_timeLab) {
        _timeLab = [[UILabel alloc] init];
        _timeLab.textColor = [UIColor colorWithHexString:@"#EEDB8E"];
        _timeLab.font = [UIFont systemFontOfSize:13];
        _timeLab.textAlignment = NSTextAlignmentCenter;
    }
    return _timeLab;
}

- (UILabel *)participateLab{
    if (!_participateLab) {
        _participateLab = [[UILabel alloc] init];
        _participateLab.textColor = [UIColor colorWithHexString:@"#EEDB8E"];
        _participateLab.font = [UIFont systemFontOfSize:12];
        _participateLab.numberOfLines = 0;
		_participateLab.textAlignment = NSTextAlignmentCenter;
    }
    return _participateLab;
}

- (UIButton *)closeBtn{
    if (!_closeBtn) {
        _closeBtn = [[UIButton alloc] init];
        [_closeBtn setImage:kGetImage(@"s-gb_per_btn_icon") forState:UIControlStateNormal];
        [_closeBtn addTarget:self action:@selector(close) forControlEvents:UIControlEventTouchUpInside];
    }
    return _closeBtn;
}

@end
