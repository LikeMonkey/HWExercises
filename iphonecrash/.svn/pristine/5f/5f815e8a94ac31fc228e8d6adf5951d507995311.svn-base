//
//  HomeHotCollectionViewCell.m
//  ZhongQiBrand
//
//  Created by ios2 on 2019/9/17.
//  Copyright © 2019 CY. All rights reserved.
//

#import "HomeHotCollectionViewCell.h"

@implementation HomeHotCollectionViewCell

-(instancetype)initWithFrame:(CGRect)frame
{
	self =[super initWithFrame:frame];
	if (self) {
		[self setUpUI];
	}
	return self;
}
-(void)setUpUI
{
	[self.contentView addSubview:self.shadowImgView];
	[self.contentView addSubview:self.contentImgView];

	[_shadowImgView mas_makeConstraints:^(MASConstraintMaker *make) {
		make.centerX.mas_equalTo(0);
		make.size.mas_equalTo(CGSizeMake(px_scale(690), px_scale(519)));
		make.top.mas_equalTo(px_scale(22));
	}];

	[_contentImgView mas_makeConstraints:^(MASConstraintMaker *make) {
		make.centerX.mas_equalTo(0);
		make.size.mas_equalTo(CGSizeMake(px_scale(630), px_scale(540)));
		make.top.mas_equalTo(0);
	}];

	[_timeLable mas_makeConstraints:^(MASConstraintMaker *make) {
		make.top.mas_equalTo(px_scale(85));
		make.centerX.mas_equalTo(0);
		make.height.mas_equalTo(px_scale(46));
	}];

	[_industryNameLable mas_makeConstraints:^(MASConstraintMaker *make) {
		make.top.mas_equalTo(px_scale(147));
		make.centerX.mas_equalTo(-px_scale(13));
		make.width.mas_lessThanOrEqualTo(px_scale(350));
		make.height.mas_equalTo(px_scale(67));
	}];

}

#pragma mark - getter
-(UIImageView *)shadowImgView
{
	if (!_shadowImgView) {
		_shadowImgView = [[UIImageView alloc]init];
		_shadowImgView.image =[UIImage imageNamed:@"rmbd_yydt_img"];
	 }
	return _shadowImgView;
}
-(UIImageView *)contentImgView
{
	if (!_contentImgView) {
		_contentImgView = [[UIImageView alloc]init];
		_contentImgView.image = [UIImage imageNamed:@"home_rmbd_banner_img"];
		[_contentImgView addSubview:self.timeLable];
		[_contentImgView addSubview:self.industryNameLable];
	 }
	return _contentImgView;
}
-(UILabel *)timeLable {
	if (!_timeLable)
	 {
		_timeLable = [[UILabel alloc]init];
		_timeLable.font = [UIFont systemFontOfSize:16.5];
		_timeLable.textAlignment = NSTextAlignmentCenter;
		_timeLable.textColor =[UIColor colorWithHexString:@"#F6FFC5"];
		_timeLable.text = @"------";
	 }
	return _timeLable;
}
-(UILabel *)industryNameLable
{
	if (!_industryNameLable)
	 {
		_industryNameLable = [[UILabel alloc]init];
		_industryNameLable.font = [UIFont systemFontOfSize:24.0];
		_industryNameLable.textAlignment = NSTextAlignmentCenter;
		_industryNameLable.textColor =[UIColor colorWithHexString:@"#801718"];
		_industryNameLable.text = @"-----------------";
	 }
	return _industryNameLable;
}


@end
