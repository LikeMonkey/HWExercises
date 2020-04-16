//
//  JoinWorldWaitView.m
//  ZhongQiBrand
//
//  Created by ios2 on 2019/11/13.
//  Copyright © 2019 CY. All rights reserved.
//

#import "JoinWorldWaitView.h"
@interface JoinWorldWaitView()
@property (nonatomic,strong)UIView *grayLineView;
@end

@implementation JoinWorldWaitView

-(instancetype)initWithFrame:(CGRect)frame
{
	self = [super initWithFrame:frame];
	if (self) {
		self.backgroundColor = [UIColor whiteColor];
		[self setUpUI];
	}
	return self;
}
-(void)setUpUI
{
	[self addSubview:self.iconImageView];
	[self addSubview:self.titleLable];
	[self addSubview:self.descLable];
	[self addSubview:self.customserverButton];
	[self addSubview:self.grayLineView];
	[self makeLayoutViews];
}
-(void)makeLayoutViews
{
	[_iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
		make.top.mas_equalTo(px_scale(130));
		make.width.height.mas_equalTo(px_scale(120));
		make.centerX.mas_equalTo(0);
	}];

	[_titleLable mas_makeConstraints:^(MASConstraintMaker *make) {
		make.height.mas_equalTo(px_scale(45));
		make.centerX.mas_equalTo(0);
		make.top.mas_equalTo(self.iconImageView.mas_bottom).offset(px_scale(50));
	}];

	[_descLable mas_makeConstraints:^(MASConstraintMaker *make) {
		make.height.mas_greaterThanOrEqualTo(px_scale(65));
		make.centerX.mas_equalTo(0);
		make.top.mas_equalTo(self.titleLable.mas_bottom).offset(px_scale(10));
	}];

	[_customserverButton mas_makeConstraints:^(MASConstraintMaker *make) {
		make.left.mas_equalTo(px_scale(30));
		make.right.mas_equalTo(px_scale(-30));
		make.bottom.mas_equalTo(px_scale(-164));
		make.height.mas_equalTo(px_scale(88));
	}];

	[_grayLineView mas_makeConstraints:^(MASConstraintMaker *make) {
		make.left.right.top.equalTo(self);
		make.height.mas_equalTo(px_scale(20));
	}];

}
#pragma mark - getter
-(UIImageView *)iconImageView
{
	if (!_iconImageView) {
		_iconImageView = [[UIImageView alloc]init];
		_iconImageView.image = [UIImage imageNamed:@"jrpp_ddsh_icon"];
	 }
	return _iconImageView;
}

-(UILabel *)titleLable
{
	if (!_titleLable) {
		_titleLable = [[UILabel alloc]init];
		_titleLable.font =[UIFont boldSystemFontOfSize:16];
		_titleLable.textColor =[UIColor colorWithHexString:@"#333333"];
		_titleLable.textAlignment = NSTextAlignmentCenter;
		_titleLable.text = @"等待审核";
	 }
	return _titleLable;
}

-(UILabel *)descLable
{
	if (!_descLable) {
		_descLable = [UILabel new];
		_descLable.text = @"您的资料已经提交成功\n工作人员审核需要1-2个工作日，请耐心等待";
		_descLable.textAlignment = NSTextAlignmentCenter;
		_descLable.font = [UIFont systemFontOfSize:12];
		_descLable.textColor =[UIColor colorWithHexString:@"#999999"];
		_descLable.numberOfLines = 0;
	}
	return _descLable;
}

-(UIButton *)customserverButton
{
	if (!_customserverButton)
	 {
		_customserverButton = [[UIButton alloc]init];
		[_customserverButton setTitle:@"联系客服" forState:UIControlStateNormal];
		_customserverButton.titleLabel.font = [UIFont systemFontOfSize:16];
		_customserverButton.backgroundColor = [UIColor colorWithHexString:@"#D3141C"];
		_customserverButton.layer.cornerRadius = px_scale(44);
		_customserverButton.clipsToBounds = YES;
		[_customserverButton addTarget:self action:@selector(customServerClicked:) forControlEvents:UIControlEventTouchUpInside];
	 }
	return _customserverButton;
}

-(UIView *)grayLineView
{
	if (!_grayLineView) {
		_grayLineView = [[UIView alloc]init];
		_grayLineView.backgroundColor = [UIColor colorWithHexString:@"#F8F8F8"];
	 }
	return _grayLineView;
}

#pragma mark - target method
-(void)customServerClicked:(id)sender
{
	!_customServerBlock?:_customServerBlock(); //客服调用
}

@end
