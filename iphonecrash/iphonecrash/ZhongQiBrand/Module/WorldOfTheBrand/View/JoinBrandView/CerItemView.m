//
//  CerItemView.m
//  ZhongQiBrand
//
//  Created by ios2 on 2019/10/21.
//  Copyright © 2019 CY. All rights reserved.
//

#import "CerItemView.h"
#import "DottedLineView.h"

@interface CerItemView ()
//相机的背景View
@property (nonatomic,strong)UIView *bgView;

@property (nonatomic,strong)DottedLineView *dottedLineView;
//认证图片
@property (nonatomic,strong)UIImageView *cerImageView;

@end


@implementation CerItemView

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
	[self.dottedLineView mas_makeConstraints:^(MASConstraintMaker *make) {
		make.edges.mas_equalTo(UIEdgeInsetsZero);
	}];
	[self.contentView addSubview:self.cerImageView];
	[self.contentView addSubview:self.bgView];

	[self.contentView addSubview:self.deleteButton];

	[self.bgView mas_makeConstraints:^(MASConstraintMaker *make) {
		make.edges.mas_equalTo(UIEdgeInsetsZero);
	}];

	[_cerImageView mas_makeConstraints:^(MASConstraintMaker *make) {
		make.edges.mas_equalTo(UIEdgeInsetsMake(1, 1, 1, 1));
	}];

	[self.deleteButton mas_makeConstraints:^(MASConstraintMaker *make) {
		make.right.mas_equalTo(px_scale(10));
		make.top.mas_equalTo(-px_scale(10));
		make.size.mas_equalTo((CGSize){px_scale(75),px_scale(75)});
	}];

}


//设置是否必选
-(void)configerTitle:(NSString *)title andIsMust:(BOOL)isMust
{
	if (NullString(title)) return;
	NSString *mustStr = isMust?@" *":@"";
	NSString *str = [NSString stringWithFormat:@"%@%@",title,mustStr];
	NSMutableAttributedString *abs = [[NSMutableAttributedString alloc]initWithString:str attributes:@{
																									   NSFontAttributeName:[UIFont systemFontOfSize:12],
																									   NSForegroundColorAttributeName:[UIColor colorWithHexString:@"#BDBDBD"]
																									   }];
	[abs setAttributes:@{
							 NSFontAttributeName:[UIFont systemFontOfSize:14],
							 NSForegroundColorAttributeName:[UIColor colorWithHexString:@"#D3141C"]
							 } range:(NSRange){(title.length),mustStr.length}];
	self.titleLable.attributedText = abs;
}


#pragma mark - getter
-(UIView *)bgView
{
	if (!_bgView)
	 {
		_bgView = [[UIView alloc]init];
		[_bgView addSubview:self.cameraImgView];
		[_bgView addSubview:self.titleLable];
		[_cameraImgView mas_makeConstraints:^(MASConstraintMaker *make) {
			make.size.mas_equalTo((CGSize){px_scale(44),px_scale(40)});
			make.centerX.mas_equalTo(0);
			make.top.mas_equalTo(px_scale(42));
		}];
		[_titleLable mas_makeConstraints:^(MASConstraintMaker *make) {
			make.left.right.mas_equalTo(0);
			make.top.equalTo(self.cameraImgView.mas_bottom).offset(px_scale(20));
			make.height.mas_equalTo(px_scale(35));
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
	 }
	return _cerImageView;
}

-(UIImageView *)cameraImgView
{
	if (!_cameraImgView)
	 {
		_cameraImgView = [[UIImageView alloc]init];
		_cameraImgView.image =[UIImage imageNamed:@"list_uploud_pre"];
	 }
	return _cameraImgView;
}
-(UILabel *)titleLable
{
	if (!_titleLable) {
		_titleLable = [[UILabel alloc]init];
		_titleLable.textAlignment = NSTextAlignmentCenter;
	 }
	return _titleLable;
}
-(UIButton *)deleteButton
{
	if (!_deleteButton)
	 {
		_deleteButton = [[UIButton alloc]init];

		[_deleteButton setImage:[UIImage imageNamed:@"sz_yjfk_icon"] forState:UIControlStateNormal];
		[_deleteButton setContentVerticalAlignment:(UIControlContentVerticalAlignmentTop)];
		[_deleteButton setContentHorizontalAlignment:(UIControlContentHorizontalAlignmentRight)];
		[_deleteButton addTarget:self action:@selector(deleteClicked:) forControlEvents:UIControlEventTouchUpInside];

	 }
	return _deleteButton;
}
-(DottedLineView *)dottedLineView
{
	if (!_dottedLineView)
	 {
		_dottedLineView = [[DottedLineView alloc]init];
		_dottedLineView.backgroundColor = [UIColor colorWithHexString:@"#FBFBFB"];
		_dottedLineView.lineColor =[UIColor colorWithHexString:@"#B2B2B2"];
		[self.contentView insertSubview:_dottedLineView atIndex:0];
	 }
	return _dottedLineView;
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
