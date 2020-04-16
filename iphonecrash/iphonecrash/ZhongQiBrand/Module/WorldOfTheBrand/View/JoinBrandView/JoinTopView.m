//
//  JoinTopView.m
//  ZhongQiBrand
//
//  Created by ios2 on 2019/10/21.
//  Copyright © 2019 CY. All rights reserved.
//

#import "JoinTopView.h"

@implementation JoinTopView

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
	self.backgroundColor = [UIColor whiteColor];
	[self addSubview:self.titleLable];
	[self addSubview:self.descLable];
	[self addSubview:self.lineView];

	[self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
		make.size.mas_equalTo(CGSizeMake(px_scale(8), px_scale(30)));
		make.left.mas_equalTo(px_scale(30));
		make.top.mas_equalTo(px_scale(40));
	}];

	[self.titleLable mas_makeConstraints:^(MASConstraintMaker *make) {
		make.centerY.equalTo(self.lineView);
		make.left.equalTo(self.lineView.mas_right).offset(px_scale(20));
		make.height.mas_equalTo(px_scale(50));
	}];

	[self.descLable mas_makeConstraints:^(MASConstraintMaker *make) {
		make.centerY.equalTo(self.lineView);
		make.left.mas_equalTo(px_scale(212));
		make.height.mas_equalTo(px_scale(33));
	}];
}

#pragma mark - getter
-(UILabel *)titleLable
{
	if (!_titleLable)
	 {
		_titleLable = [[UILabel alloc]init];
		_titleLable.font =[UIFont systemFontOfSize:16];
		_titleLable.textColor = [UIColor colorWithHexString:@"#333333"];
	 }
	return _titleLable;
}

-(UILabel *)descLable
{
	if (!_descLable)
	 {
		_descLable = [[UILabel alloc]init];
		_descLable.font =[UIFont systemFontOfSize:12];
		_descLable.textColor = [UIColor colorWithHexString:@"#BDBDBD"];
	 }
	return _descLable;
}

-(UIView *)lineView
{
	if (!_lineView)
	 {
		_lineView = [[UIView alloc]init];
		_lineView.backgroundColor = [UIColor colorWithHexString:@"#D3141C"];
		_lineView.layer.cornerRadius = px_scale(4);
		_lineView.clipsToBounds =YES;
	 }
	return _lineView;
}

@end
