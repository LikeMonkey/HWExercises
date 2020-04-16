//
//  VoteSuccessPopView.m
//  ZhongQiBrand
//
//  Created by iOS on 2019/10/23.
//  Copyright © 2019 CY. All rights reserved.
//

#import "VoteSuccessPopView.h"
#import "UIWindow+FrontWindow.h"
#import "WXApi+MiniProgram.h"
@interface VoteSuccessPopView ()

@property (nonatomic, strong) UIView *maskView;
@property (nonatomic, strong) UIImageView *bgImgView;
@property (nonatomic, strong) UIButton *closeBtn;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIImageView *logoImg;
@property (nonatomic, strong) UILabel *votesNumber;
@property (nonatomic, strong) UILabel *brandName;
@property (nonatomic, strong) UILabel *voteTime;
@property (nonatomic, strong) UIButton *smallProgramBtn;
@property (nonatomic, strong) UIButton *shareBtn;

@end

@implementation VoteSuccessPopView
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        [self maskView];
        [self bgImgView];
        [self closeBtn];
        [self titleLabel];
        [self logoImg];
        [self votesNumber];
        [self brandName];
        [self voteTime];
        [self smallProgramBtn];
        [self shareBtn];
    }
    return self;
}

+ (instancetype)showVoteSuccessWithModel:(VoteSuccessModel *)model {
    VoteSuccessPopView *sucessView = [[VoteSuccessPopView alloc] initWithFrame:CGRectMake(0, 0, MAINScreenWidth, MAINScreenHeight)];
    [sucessView showSuccessPopViewWithModel:model];
    [sucessView show];
    return sucessView;
}

#pragma mark - Private Method
- (void)showSuccessPopViewWithModel:(VoteSuccessModel *)model {
    [self.logoImg sd_setImageWithURL:[NSURL URLWithString:model.iconUrl] placeholderImage:[UIImage imageNamed:@""]];
    self.votesNumber.text = [NSString stringWithFormat:@"%@票",model.votesNum];
    self.brandName.text = [NSString stringWithFormat:@"品牌名称：%@",model.brandName];
    self.voteTime.text = [NSString stringWithFormat:@"投票时间：%@ %@",model.voteDtae,model.voteTime];
}

- (void)show{
    UIWindow *window = [UIWindow frontWindow];
    [window addSubview:self];
}

- (void)hiden{
    [self removeFromSuperview];
}

- (void)smallProgramBtnClicked:(UIButton *)sender {
    [self hiden];
    NSLog(@"跳转到小程序");
	[WXApi openMiniProgramWithPath:nil andCompletion:^(BOOL isSucess) {

	}];
}

- (void)shareBtnClicked:(UIButton *)sender {
	 [self hiden];
	!_clickedBlock?:_clickedBlock(1);
}

- (void)closeBtnClicked:(UIButton *)sender {
    [self hiden];
}

#pragma mark - 懒加载
- (UIView *)maskView {
    if (!_maskView) {
        _maskView = [[UIView alloc]init];
        _maskView.backgroundColor = [UIColor colorWithWhite:0 alpha:0.5];
        [self addSubview:_maskView];
        [_maskView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self).with.insets(UIEdgeInsetsMake(0, 0, 0, 0));
        }];
    }
    return _maskView;
}

- (UIImageView *)bgImgView {
    if (!_bgImgView) {
        _bgImgView = [[UIImageView alloc]init];
        _bgImgView.contentMode = UIViewContentModeScaleAspectFit;
        _bgImgView.image = [UIImage imageNamed:@"tpcg_dwt_img"];
        _bgImgView.userInteractionEnabled = YES;
        
        [self.maskView addSubview:_bgImgView];
        [_bgImgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(0);
            make.centerY.mas_equalTo(0);
            make.width.mas_equalTo(317 * scaleX);
            make.height.mas_equalTo(412 * scaleX);
        }];
    }
    return _bgImgView;
}

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc]init];
        _titleLabel.text = @"投票成功";
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.textColor = [UIColor colorWithHexString:@"#F1DCA6"];
        _titleLabel.font = [UIFont boldSystemFontOfSize:24];
        
        [self.bgImgView addSubview:_titleLabel];
        [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(0);
            make.top.mas_equalTo(61.5 * scaleX);
        }];
    }
    return _titleLabel;
}

- (UIImageView *)logoImg {
    if (!_logoImg) {
        _logoImg = [[UIImageView alloc]init];
        _logoImg.contentMode = UIViewContentModeScaleAspectFit;
        _logoImg.image = [UIImage imageNamed:@""];
        
        [self.bgImgView addSubview:_logoImg];
        [_logoImg mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(0);
            make.top.equalTo(self.titleLabel.mas_bottom).offset(13.5 * scaleX);
            make.width.mas_equalTo(134 * scaleX);
            make.height.mas_equalTo(70 * scaleX);
        }];
    }
    return _logoImg;
}

- (UILabel *)votesNumber {
    if (!_votesNumber) {
        _votesNumber = [[UILabel alloc]init];
        _votesNumber.textColor = [UIColor colorWithHexString:@"#322B22"];
        _votesNumber.textAlignment = NSTextAlignmentCenter;
        _votesNumber.font = [UIFont boldSystemFontOfSize:16];
        _votesNumber.backgroundColor = [UIColor colorWithHexString:@"#F1DCA6"];
        
        _votesNumber.layer.cornerRadius = 10*scaleX;
        _votesNumber.clipsToBounds = YES;
        
        [self.bgImgView addSubview:_votesNumber];
        [_votesNumber mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(0);
            make.top.equalTo(self.logoImg.mas_bottom).offset(14.5 * scaleX);
            make.width.mas_equalTo(88 * scaleX);
            make.height.mas_equalTo(22 * scaleX);
        }];
    }
    return _votesNumber;
}

- (UILabel *)brandName {
    if (!_brandName) {
        _brandName = [[UILabel alloc]init];
        _brandName.textColor = [UIColor colorWithHexString:@"#EBCC8D"];
        _brandName.textAlignment = NSTextAlignmentCenter;
        _brandName.font = [UIFont systemFontOfSize:13];
        
        [self.bgImgView addSubview:_brandName];
        [_brandName mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(0);
            make.top.equalTo(self.votesNumber.mas_bottom).offset(30 * scaleX);
        }];
    }
    return _brandName;
}

- (UILabel *)voteTime {
    if (!_voteTime) {
        _voteTime = [[UILabel alloc]init];
        _voteTime.textColor = [UIColor colorWithHexString:@"#EBCC8D"];
        _voteTime.textAlignment = NSTextAlignmentCenter;
        _voteTime.font = [UIFont systemFontOfSize:13];
        
        [self.bgImgView addSubview:_voteTime];
        [_voteTime mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(0);
            make.top.equalTo(self.brandName.mas_bottom).offset(10 * scaleX);
        }];
    }
    return _voteTime;
}

- (UIButton *)smallProgramBtn {
    if (!_smallProgramBtn) {
        _smallProgramBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_smallProgramBtn setTitle:@"小程序投票" forState:UIControlStateNormal];
        [_smallProgramBtn setTitleColor:[UIColor colorWithHexString:@"#F1DEAA"] forState:UIControlStateNormal];
        _smallProgramBtn.titleLabel.font = [UIFont boldSystemFontOfSize:14];
        _smallProgramBtn.backgroundColor = [UIColor clearColor];
        _smallProgramBtn.layer.cornerRadius = 17.5*scaleX;
        _smallProgramBtn.layer.borderColor = [UIColor colorWithHexString:@"#F2DFAB"].CGColor;
        _smallProgramBtn.layer.borderWidth = 1 * scaleX;
        [_smallProgramBtn addTarget:self action:@selector(smallProgramBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
        
        [self.bgImgView addSubview:_smallProgramBtn];
        [_smallProgramBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(33.5 * scaleX);
            make.top.equalTo(self.voteTime.mas_bottom).offset(32 * scaleX);
            make.width.mas_equalTo(113.5 * scaleX);
            make.height.mas_equalTo(35 * scaleX);
        }];
    }
    return _smallProgramBtn;
}

- (UIButton *)shareBtn {
    if (!_shareBtn) {
        _shareBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_shareBtn setTitle:@"分享" forState:UIControlStateNormal];
        [_shareBtn setTitleColor:[UIColor colorWithHexString:@"#AD2626"] forState:UIControlStateNormal];
        _shareBtn.titleLabel.font = [UIFont boldSystemFontOfSize:14];
        _shareBtn.backgroundColor = [UIColor colorWithHexString:@"#F2DFAB"];
        _shareBtn.layer.cornerRadius = 17.5*scaleX;
        _shareBtn.layer.borderColor = [UIColor colorWithHexString:@"#F2DFAB"].CGColor;
        _shareBtn.layer.borderWidth = 1 * scaleX;
        [_shareBtn addTarget:self action:@selector(shareBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
        
        [self.bgImgView addSubview:_shareBtn];
        [_shareBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(-33.5 * scaleX);
            make.top.equalTo(self.voteTime.mas_bottom).offset(32 * scaleX);
            make.width.mas_equalTo(113.5 * scaleX);
            make.height.mas_equalTo(35 * scaleX);
        }];
    }
    return _shareBtn;
}

- (UIButton *)closeBtn {
    if (!_closeBtn) {
        _closeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_closeBtn setBackgroundImage:[UIImage imageNamed:@"vote_close_icon"] forState:UIControlStateNormal];
        [_closeBtn addTarget:self action:@selector(closeBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
        
        [self.maskView addSubview:_closeBtn];
        [_closeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(0);
            make.top.equalTo(self.bgImgView.mas_bottom).offset(25 * scaleX);
            make.width.mas_equalTo(35 * scaleX);
            make.height.mas_equalTo(35 * scaleX);
        }];
    }
    return _closeBtn;
}
@end
