//
//  OrderProtrolAlertView.m
//  ZhongQiBrand
//
//  Created by ios 001 on 2019/10/22.
//  Copyright © 2019 CY. All rights reserved.
//

#import "OrderProtrolAlertView.h"

@implementation OrderProtrolAlertView
+ (instancetype)showAlertWithContentString:(NSString *)ContentString{
         OrderProtrolAlertView *AlertView = [[OrderProtrolAlertView alloc] initWithFrame:CGRectMake(0, 0, MAINScreenWidth, MAINScreenHeight)];
          UIWindow *window =  [[UIApplication sharedApplication].delegate window];
         [window addSubview:AlertView];
         [AlertView confingContentString:ContentString];
    return AlertView;
}
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setUpViews];
        self.backgroundColor = [[UIColor blackColor]colorWithAlphaComponent:0.5];
    }
    
    return self;
}

- (void)setUpViews {

    [self addSubview:self.alertView];
    [self addSubview:self.offBtn];
    [self.alertView addSubview:self.titlelabel];
    [self.alertView addSubview:self.titleBackView];
    [self.alertView addSubview:self.backView];
    [self.backView addSubview:self.content];
    [self.alertView addSubview:self.sliderBackView];
    [self.sliderBackView addSubview:self.slider];
    
    [self.alertView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.centerY.mas_equalTo(self);
        make.height.mas_equalTo(px_scale(507));
        make.width.mas_equalTo(px_scale(550));
    }];
    [self.offBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self);
        make.top.mas_equalTo(self.alertView.mas_bottom).mas_offset(px_scale(50));
        make.height.width.mas_equalTo(px_scale(70));
    }];
    
    [self.titlelabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.alertView);
        make.top.mas_offset(px_scale(40));
    }];
    [self.titleBackView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.alertView);
        make.top.mas_equalTo(self.titlelabel.mas_bottom).mas_offset(-px_scale(8));
    }];
    [self.backView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(px_scale(40));
        make.right.mas_offset(px_scale(-40));
        make.top.mas_equalTo(self.titleBackView.mas_bottom).mas_offset(px_scale(33));
        make.bottom.mas_offset(-px_scale(76));
    }];
    [self.content mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.mas_offset(0);
        make.bottom.mas_offset(0);
    }];
    [self.sliderBackView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.backView.mas_top);
        make.bottom.mas_equalTo(self.backView.mas_bottom);
        make.right.mas_offset(-px_scale(10));
        make.width.mas_offset(px_scale(8));
    }];
    [self.slider mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.mas_equalTo(self.sliderBackView);
        make.height.mas_equalTo(px_scale(100));
    }];
    
    //    [self layoutIfNeeded];
    
    self.alertView.layer.cornerRadius = px_scale(20);
    self.alertView.layer.masksToBounds = YES;
    
}
-(void)AlertOffClick:(UIButton *)sender{
    [self removeFromSuperview];
}
#pragma mark ——— scrollViewdelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    [UIView animateWithDuration:1.0f animations:^{
        CGPoint offset= scrollView.contentOffset;
        //计算slider的位置
        // scrollView的当前位移/scrollView的总位移=滑块的当前位移/滑块的总位移
        // offset/(scrollView.contentSize.width-scrollView.frame.size.width)=滑块的位移/(slideBackView.frame.size.width-sliderView.frame.size.width)
        // 滑块距离屏幕左边的距离加上滑块的当前位移，即为滑块当前的y
        self.slider.y
        = offset.y*(
                    self.sliderBackView.frame.size.height-self.slider.frame.size.height)/(self.backView.contentSize.height-self.backView.frame.size.height);
        
        
    }];
}
#pragma mark ——— setter
-(void)confingContentString:(NSString *)contentString{
    self.content.text = contentString;
    //计算文字高度
    CGSize contentSize = [contentString boundingRectWithSize:CGSizeMake(px_scale(472), MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:12]} context:nil].size;
    
    self.backView.contentSize = CGSizeMake(0,contentSize.height);
    
    
}
#pragma mark ——— lazy

- (UIView *)alertView {
    if (!_alertView) {
        _alertView = [[UIView alloc]init];
        _alertView.backgroundColor= [UIColor whiteColor];
        
    }
    return _alertView;
}
- (UILabel *)titlelabel {
    if (!_titlelabel) {
        _titlelabel = [[UILabel alloc]init];
        _titlelabel.font = [UIFont boldSystemFontOfSize:18];
        _titlelabel.textAlignment  = NSTextAlignmentCenter;
        _titlelabel.text = @"支付协议";
    }
    return _titlelabel;
}

- (UIImageView *)titleBackView {
    if (!_titleBackView) {
        _titleBackView = [[UIImageView alloc]init];
        [_titleBackView setImage:[UIImage imageNamed:@"home_hyjs_dtt_img"]];
    }
    return _titleBackView;
}

- (UIScrollView *)backView {
    if (!_backView) {
        _backView = [[UIScrollView alloc]init];
        _backView.scrollEnabled  =YES;
        _backView.delegate = self;
        _backView.showsVerticalScrollIndicator = NO;
        _backView.scrollEnabled = YES;
        _backView.userInteractionEnabled = YES;
    }
    return _backView;
}

- (UIView  *)sliderBackView {
    if (!_sliderBackView) {
        _sliderBackView = [[UIView alloc]init];
        _sliderBackView.backgroundColor = [UIColor colorWithHexString:@"#EFEFEF"];
        _sliderBackView.layer.cornerRadius = px_scale(4);
        _sliderBackView.layer.masksToBounds = YES;
    }
    return _sliderBackView;
}

- (UILabel *)content {
    if (!_content) {
        _content = [[UILabel alloc]init];
        [_content setFont:[UIFont systemFontOfSize:12]];
        [_content setTextColor:[UIColor colorWithHexString:@"#666666"]];
        _content.textAlignment = NSTextAlignmentLeft;
        _content.numberOfLines = 0;
       _content.preferredMaxLayoutWidth = px_scale(472);
        
    }
    return _content;
}
- (UIView *)slider {
    if (!_slider) {
        _slider = [[UIView alloc]init];
        _slider.backgroundColor = [UIColor colorWithHexString:@"#D3141C"];
        _slider.layer.cornerRadius = px_scale(4);
        _slider.layer.masksToBounds = YES;
    }
    return _slider;
}

- (UIButton *)offBtn {
    if (!_offBtn) {
        _offBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_offBtn setImage:[UIImage imageNamed:@"hdxq_gban_btn_icon"] forState:UIControlStateNormal];
          [_offBtn addTarget:self action:@selector(AlertOffClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _offBtn;
}
@end
