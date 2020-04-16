//
//  ApplyMedalPopView.m
//  ZhongQiBrand
//
//  Created by iOS on 2019/10/22.
//  Copyright © 2019 CY. All rights reserved.
//

#import "ApplyMedalPopView.h"
#import "UIWindow+FrontWindow.h"

@interface ApplyMedalPopView ()

@property (nonatomic, strong) UIView *maskView;
@property (nonatomic, strong) UIImageView *bgImgView;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *timeLabel;
@property (nonatomic, strong) UILabel *yearLabel;
@property (nonatomic, strong) UILabel *monthLabel;
@property (nonatomic, strong) UILabel *dayLabel;
@property (nonatomic, strong) UILabel *descripLabel;
@property (nonatomic, strong) UIButton *submitBtn;

@end

@implementation ApplyMedalPopView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        [self maskView];
        [self bgImgView];
        [self titleLabel];
        [self timeLabel];
        [self yearLabel];
        [self monthLabel];
        [self dayLabel];
        [self descripLabel];
        [self submitBtn];
    }
    return self;
}

+ (instancetype)showYear:(NSString *)year month:(NSString *)month day:(NSString *)day {
    
    ApplyMedalPopView *medalView = [[ApplyMedalPopView alloc] initWithFrame:CGRectMake(0, 0, MAINScreenWidth, MAINScreenHeight)];
    [medalView showYear:year month:month day:day];
    [medalView show];
    return medalView;
    
}

- (void)showYear:(NSString *)year month:(NSString *)month day:(NSString *)day {
    
    self.yearLabel.text = year;
    self.monthLabel.text = month;
    self.dayLabel.text = day;
}

- (void)show{
    UIWindow *window = [UIWindow frontWindow];
    [window addSubview:self];
}

- (void)submitBtnClicked:(UIButton *)sender {
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
        _bgImgView.image = [UIImage imageNamed:@"home_sljp_img"];
        _bgImgView.userInteractionEnabled = YES;
        
        [self.maskView addSubview:_bgImgView];
        [_bgImgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(0);
            make.centerY.mas_equalTo(0);
            make.width.mas_equalTo(275 * scaleX);
            make.height.mas_equalTo(243 * scaleX);
        }];
    }
    return _bgImgView;
}

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc]init];
        _titleLabel.text = @"申领奖牌提醒";
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.textColor = [UIColor whiteColor];
        _titleLabel.font = [UIFont boldSystemFontOfSize:19];
        
        [self.bgImgView addSubview:_titleLabel];
        [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(0);
            make.top.mas_equalTo(16 * scaleX);
        }];
    }
    return _titleLabel;
}

- (UILabel *)timeLabel {
    if (!_timeLabel) {
        _timeLabel = [[UILabel alloc]init];
        _timeLabel.text = @"揭榜时间";
        _timeLabel.textAlignment = NSTextAlignmentCenter;
        _timeLabel.textColor = [UIColor colorWithHexString:@"#333333"];
        _timeLabel.font = [UIFont boldSystemFontOfSize:15.f];
        
        [self.bgImgView addSubview:_timeLabel];
        [_timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(0);
            make.top.equalTo(self.titleLabel.mas_bottom).offset(35 * scaleX);
        }];
    }
    return _timeLabel;
}

- (UILabel *)yearLabel {
    if (!_yearLabel) {
        _yearLabel = [[UILabel alloc]init];
        _yearLabel.text = @"2019";
        _yearLabel.textAlignment = NSTextAlignmentCenter;
        _yearLabel.textColor = [UIColor whiteColor];
        _yearLabel.font = [UIFont systemFontOfSize:14];
        
        UIImage *image = [UIImage imageNamed:@"sljp_jbsj_img"];
        UIColor *color = [UIColor colorWithPatternImage:image];
        _yearLabel.backgroundColor = color;
        
        [self.bgImgView addSubview:_yearLabel];
        [_yearLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(71.5 * scaleX);
            make.top.equalTo(self.timeLabel.mas_bottom).offset(9 * scaleX);
            make.width.mas_equalTo(image.size.width);
            make.height.mas_equalTo(image.size.height);
        }];
    }
    return _yearLabel;
}

- (UILabel *)monthLabel {
    if (!_monthLabel) {
        _monthLabel = [[UILabel alloc]init];
        _monthLabel.text = @"09";
        _monthLabel.textAlignment = NSTextAlignmentCenter;
        _monthLabel.textColor = [UIColor whiteColor];
        _monthLabel.backgroundColor = [UIColor colorWithHexString:@"#FE1B11"];
        _monthLabel.font = [UIFont systemFontOfSize:14];
        
        UIImage *image = [UIImage imageNamed:@"sljp_jbsj_img"];
        UIColor *color = [UIColor colorWithPatternImage:image];
        _monthLabel.backgroundColor = color;
        
        [self.bgImgView addSubview:_monthLabel];
        [_monthLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.yearLabel.mas_right).offset(5 * scaleX);
            make.top.equalTo(self.timeLabel.mas_bottom).offset(9 * scaleX);
            make.width.mas_equalTo(image.size.width);
            make.height.mas_equalTo(image.size.height);
        }];
    }
    return _monthLabel;
}

- (UILabel *)dayLabel {
    if (!_dayLabel) {
        _dayLabel = [[UILabel alloc]init];
        _dayLabel.text = @"23";
        _dayLabel.textAlignment = NSTextAlignmentCenter;
        _dayLabel.textColor = [UIColor whiteColor];
        _dayLabel.backgroundColor = [UIColor colorWithHexString:@"#FE1B11"];
        _dayLabel.font = [UIFont systemFontOfSize:14];
        
        UIImage *image = [UIImage imageNamed:@"sljp_jbsj_img"];
        UIColor *color = [UIColor colorWithPatternImage:image];
        _dayLabel.backgroundColor = color;
        
        [self.bgImgView addSubview:_dayLabel];
        [_dayLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.monthLabel.mas_right).offset(5 * scaleX);
            make.top.equalTo(self.timeLabel.mas_bottom).offset(9 * scaleX);
            make.width.mas_equalTo(image.size.width);
            make.height.mas_equalTo(image.size.height);
        }];
    }
    return _dayLabel;
}

- (UILabel *)descripLabel {
    if (!_descripLabel) {
        _descripLabel = [[UILabel alloc]init];
        _descripLabel.text = @"投票活动已截止请获奖品牌及时领取奖牌";
        _descripLabel.textAlignment = NSTextAlignmentCenter;
        _descripLabel.textColor = [UIColor colorWithHexString:@"#666666"];
        _descripLabel.font = [UIFont systemFontOfSize:12];
        
        [self.bgImgView addSubview:_descripLabel];
        [_descripLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.yearLabel.mas_bottom).offset(26 * scaleX);
            make.centerX.mas_equalTo(0);
        }];
    }
    return _descripLabel;
}

- (UIButton *)submitBtn {
    if (!_submitBtn) {
        _submitBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        UIImage *image = [UIImage imageNamed:@"home_sure_icon"];
        [_submitBtn setImage:image forState:UIControlStateNormal];
        
        [_submitBtn addTarget:self action:@selector(submitBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
        
        [self.bgImgView addSubview:_submitBtn];
        [_submitBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.descripLabel.mas_bottom).offset(15 * scaleX);
            make.centerX.mas_equalTo(0);
            make.width.mas_equalTo(image.size.width);
            make.height.mas_equalTo(image.size.height);
        }];
    }
    return _submitBtn;
}
@end
