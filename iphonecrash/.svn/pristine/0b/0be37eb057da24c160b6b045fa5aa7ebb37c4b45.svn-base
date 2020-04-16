//
//  HelpHeaderView.m
//  ZhongQiBrand
//
//  Created by iOS on 2019/10/15.
//  Copyright © 2019 CY. All rights reserved.
//

#import "HelpHeaderView.h"

@interface HelpHeaderView ()

@property (nonatomic, strong) UIImageView *bgImg;
@property (nonatomic, strong) UILabel *servicePhone;
@property (nonatomic, strong) UILabel *workTime;
@property (nonatomic, strong) UIView *separateLine;
@property (nonatomic, strong) UILabel *normalQuestions;

@end

@implementation HelpHeaderView

- (instancetype)initWithReuseIdentifier:(nullable NSString *)reuseIdentifier {
    if (self = [super initWithReuseIdentifier:reuseIdentifier]) {
        self.backgroundView = ({
            UIView * view = [[UIView alloc] initWithFrame:self.bounds];
            view.backgroundColor = [UIColor clearColor];
            view;
        });
        
        [self.contentView addSubview:self.bgImg];
        [self.contentView addSubview:self.servicePhone];
        [self.contentView addSubview:self.workTime];
        [self.contentView addSubview:self.separateLine];
        [self.contentView addSubview:self.normalQuestions];
        
        [self setupUI];
    }
    return self;
}

/** 视图初始化 */
- (void)setupUI {
    
    [self.bgImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(15);
        make.centerX.mas_equalTo(0);
        make.height.mas_equalTo(px_scale(280));
    }];
    
    [self.servicePhone mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.bgImg.mas_left).offset(px_scale(60));
        make.right.equalTo(self.bgImg.mas_right).offset(px_scale(-60));
        make.top.equalTo(self.bgImg.mas_top).offset(px_scale(146));
    }];
    
    [self.workTime mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.bgImg.mas_left).offset(px_scale(60));
        make.right.equalTo(self.bgImg.mas_right).offset(px_scale(-60));
        make.top.equalTo(self.servicePhone.mas_bottom).offset(px_scale(8));
    }];
    
    [self.separateLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.top.equalTo(self.bgImg.mas_bottom).offset(px_scale(30));
        make.height.mas_equalTo(px_scale(16));
    }];
    
    [self.normalQuestions mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15);
        make.top.equalTo(self.separateLine.mas_bottom).offset(px_scale(30));
    }];
}


#pragma mark - 懒加载
- (UIImageView *)bgImg {
    if (!_bgImg) {
        _bgImg = [[UIImageView alloc]init];
        _bgImg.image = [UIImage imageNamed:@"sz_banner_img"];
        _bgImg.contentMode = UIViewContentModeScaleAspectFit;
    }
    return _bgImg;
}

- (UILabel *)servicePhone {
    if (!_servicePhone) {
        _servicePhone = [[UILabel alloc]init];
        _servicePhone.textColor = [UIColor whiteColor];
        _servicePhone.textAlignment = NSTextAlignmentLeft;
        _servicePhone.font = [UIFont systemFontOfSize:15];
        _servicePhone.text = @"客服电话：400-159-0958";
    }
    return _servicePhone;
}

- (UILabel *)workTime {
    if (!_workTime) {
        _workTime = [[UILabel alloc]init];
        _workTime.textColor = [UIColor whiteColor];
        _workTime.textAlignment = NSTextAlignmentLeft;
        _workTime.font = [UIFont systemFontOfSize:15];
        _workTime.text = @"工作时间：工作日的7：00-24：00";
    }
    return _workTime;
}

- (UIView *)separateLine {
    if (!_separateLine) {
        _separateLine = [[UIView alloc]init];
        _separateLine.backgroundColor = [UIColor colorWithHexString:@"#F8F8F8"];
    }
    return _separateLine;
}

- (UILabel *)normalQuestions {
    if (!_normalQuestions) {
        _normalQuestions = [[UILabel alloc]init];
        _normalQuestions.textAlignment = NSTextAlignmentLeft;
        _normalQuestions.textColor = [UIColor colorWithHexString:@"#333333"];
        _normalQuestions.font = [UIFont boldSystemFontOfSize:18];
        _normalQuestions.text = @"常见问题";
    }
    return _normalQuestions;
}

@end
