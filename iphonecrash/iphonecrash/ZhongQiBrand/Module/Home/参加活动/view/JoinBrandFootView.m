//
//  JoinBrandFootView.m
//  ZhongQiBrand
//
//  Created by iOS002 on 2019/10/21.
//  Copyright © 2019 CY. All rights reserved.
//

#import "JoinBrandFootView.h"

@interface JoinBrandFootView()

@property (nonatomic, strong) UIButton *customServeBtn;
@property (nonatomic, strong) UIButton *submitBtn;
@property (nonatomic, strong) NSArray *iconArray;
@property (nonatomic, strong) NSArray *titleArray;


@end

@implementation JoinBrandFootView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self layoutJoinBrandFootView];
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

- (void)clickSelectItemAction:(UITapGestureRecognizer *)tap
{
    if (self.clickAddImageBlock) {
        self.clickAddImageBlock((JoinFootSelectItemView *)tap.view);
    }
}


- (void)layoutJoinBrandFootView
{
    
    CGFloat width = (MAINScreenWidth - px_scale(86))/2.0;
    for (int i = 0; i < 2; i++) {
        for (int j = 0; j < 2; j++) {
            JoinFootSelectItemView *selectItemView = [[JoinFootSelectItemView alloc] initWithFrame:CGRectMake(px_scale(30)+(width + px_scale(26))*j, px_scale(52)+(px_scale(176+26))*i, width, px_scale(176))];
            selectItemView.iconImageView.image = [UIImage imageNamed:[self.iconArray objectAtIndex:i*2+j]];
            NSString *titleShowStr = [NSString stringWithFormat:@"%@ *",[self.titleArray objectAtIndex:i*2+j]];
            NSMutableAttributedString *attributeStr = [[NSMutableAttributedString alloc] initWithString:titleShowStr];
            [attributeStr addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithHexString:@"#D3141C"]range:NSMakeRange(titleShowStr.length - 1,1)];
            selectItemView.titleLabel.attributedText = attributeStr;
            [self addSubview:selectItemView];
            [self addBorderToLayer:selectItemView];
            UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickSelectItemAction:)];
            selectItemView.tag = 1000+i*2+j;
            [selectItemView addGestureRecognizer:tap];
        }
    }
    
    [self addSubview:self.customServeBtn];
    [self.customServeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.mas_top).offset(px_scale(500));
        make.left.mas_equalTo(self.mas_left).offset(px_scale(30));
        make.height.equalTo(@(px_scale(88)));
        make.width.equalTo(@(px_scale(210)));
    }];
    
    [self addSubview:self.submitBtn];
    
    [self.submitBtn mas_makeConstraints:^(MASConstraintMaker *make) {
           make.top.mas_equalTo(self.mas_top).offset(px_scale(500));
           make.right.mas_equalTo(self.mas_right).offset(-px_scale(30));
           make.height.equalTo(@(px_scale(88)));
           make.width.equalTo(@(px_scale(416)));
       }];
}

- (void)addBorderToLayer:(UIView *)view
{
    CAShapeLayer *border = [CAShapeLayer layer];
    //  线条颜色
    border.strokeColor = [UIColor colorWithHexString:@"#DCDCDC"].CGColor;
    
    border.fillColor = nil;
    
    border.path = [UIBezierPath bezierPathWithRect:view.bounds].CGPath;
    
    border.frame = view.bounds;
    
    // 不要设太大 不然看不出效果
    border.lineWidth = 1;
    
    border.lineCap = @"square";
    
    //  第一个是 线条长度   第二个是间距    nil时为实线
    border.lineDashPattern = @[@4, @4];
    
    [view.layer addSublayer:border];
}

- (NSArray *)iconArray
{
    if (!_iconArray) {
        _iconArray = @[@"cjhd_sctp_icon",@"cjhd_sctp_icon",@"cjhd_sctp_icon",@"app_cjhd_icon"];
    }
    return _iconArray;
}

- (NSArray *)titleArray
{
    if (!_titleArray) {
        _titleArray = @[@"品牌logo",@"营业执照",@"商标注册",@"添加证件"];
    }
    return _titleArray;
}


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

        [_customServeBtn addTarget:self action:@selector(clickCustomServeBtnAction) forControlEvents:UIControlEventTouchUpInside];    }
    return _customServeBtn;
}

- (UIButton *)submitBtn
{
    if (!_submitBtn) {
        _submitBtn = [UIButton new];
        _submitBtn.backgroundColor = [UIColor colorWithHexString:@"#D3141C"];
        [_submitBtn setTitle:@"提交" forState:UIControlStateNormal];
        _submitBtn.layer.cornerRadius = px_scale(44);
        [_submitBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _submitBtn.titleLabel.font  =[UIFont systemFontOfSize:16];
        [_submitBtn addTarget:self action:@selector(clickNextBtnAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _submitBtn;
}

@end
