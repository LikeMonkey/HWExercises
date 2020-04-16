//
//  UploadPicturesItemCell.m
//  ZhongQiBrand
//
//  Created by iOS on 2019/10/24.
//  Copyright © 2019 CY. All rights reserved.
//

#import "UploadPicturesItemCell.h"

@interface UploadPicturesItemCell ()
//相机的背景View
@property (nonatomic, strong) UIView *bgView;
//认证图片
@property (nonatomic, strong) UIImageView *cerImageView;

@end

@implementation UploadPicturesItemCell
-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setUpUI];
    }
    return self;
}

-(void)setUpUI
{
    [self.contentView addSubview:self.bgView];
    [self.contentView addSubview:self.cerImageView];
    [self.contentView addSubview:self.deleteButton];
    
    [_bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsZero);
    }];
    
    [_cerImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsZero);
    }];
    
    [_deleteButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(px_scale(10));
        make.top.mas_equalTo(-px_scale(10));
        make.size.mas_equalTo((CGSize){px_scale(36),px_scale(36)});
    }];
    
}

#pragma mark - getter
-(UIView *)bgView
{
    if (!_bgView)
    {
        _bgView = [[UIView alloc]init];
        _bgView.backgroundColor = [UIColor colorWithHexString:@"#FAFAFA"];
        [_bgView addSubview:self.cameraImgView];
        [_bgView addSubview:self.titleLable];
        
        [_cameraImgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo((CGSize){px_scale(44),px_scale(40)});
            make.centerX.mas_equalTo(0);
            make.top.mas_equalTo(px_scale(59));
        }];
        
        [_titleLable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(0);
            make.top.equalTo(self.cameraImgView.mas_bottom).offset(px_scale(20));
        }];
    }
    return _bgView;
}

-(void)setCerImage:(UIImage *)cerImage
{
    _cerImage =cerImage;
    self.bgView.hidden = _cerImage?YES:NO;
    _cerImageView.hidden = _cerImage?NO:YES;
    _cerImageView.image = cerImage;
    self.deleteButton.hidden = _cerImage?NO:YES;
}

-(UIImageView *)cerImageView
{
    if (!_cerImageView)
    {
        _cerImageView = [[UIImageView alloc]init];
        _cerImageView.hidden = YES;
        _cerImageView.contentMode = UIViewContentModeScaleAspectFit;
        _cerImageView.backgroundColor = [UIColor colorWithHexString:@"#FBFBFB"];
    }
    return _cerImageView;
}

-(UIImageView *)cameraImgView
{
    if (!_cameraImgView)
    {
        _cameraImgView = [[UIImageView alloc]init];
        _cameraImgView.contentMode = UIViewContentModeScaleAspectFit;
        _cameraImgView.image =[UIImage imageNamed:@"feedback_xj_icon"];
    }
    return _cameraImgView;
}

-(UILabel *)titleLable
{
    if (!_titleLable) {
        _titleLable = [[UILabel alloc]init];
        _titleLable.text = @"使图文清晰可见";
        _titleLable.textAlignment = NSTextAlignmentCenter;
        _titleLable.textColor = [UIColor colorWithHexString:@"#BDBDBD"];
        _titleLable.font = [UIFont systemFontOfSize:12];
    }
    return _titleLable;
}

-(UIButton *)deleteButton
{
    if (!_deleteButton)
    {
        _deleteButton = [[UIButton alloc]init];
        
        [_deleteButton setImage:[UIImage imageNamed:@"feedback_sc_icon"] forState:UIControlStateNormal];
        [_deleteButton setContentVerticalAlignment:(UIControlContentVerticalAlignmentTop)];
        [_deleteButton setContentHorizontalAlignment:(UIControlContentHorizontalAlignmentRight)];
        [_deleteButton addTarget:self action:@selector(deleteClicked:) forControlEvents:UIControlEventTouchUpInside];
        
    }
    return _deleteButton;
}

#pragma mark - target method
-(void)deleteClicked:(id)sender
{
    !_deleteImageBlock?:_deleteImageBlock(self);
}

//超出区域操作
-(UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event
{
    if (self.clipsToBounds || self.hidden || (self.alpha == 0.f)) {
        return nil;
    }
    UIView *result = [super hitTest:point withEvent:event];
    // 如果事件发生在 cell 里面直接返回
    if (result&&(result !=self.deleteButton))return self;
    
    for (UIView *subview in self.subviews) {
        CGPoint subPoint = [subview convertPoint:point fromView:self];
        result = [subview hitTest:subPoint withEvent:event];
        // 如果事件发生在 subView 里就返回
        if (result) {
            return result;
        }
    }
    return nil;
}

@end

