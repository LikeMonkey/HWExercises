//
//  HeadLinesBaseCell.m
//  ZhongQiBrand
//
//  Created by ios2 on 2019/9/21.
//  Copyright © 2019 CY. All rights reserved.
//

#import "HeadLinesBaseCell.h"
#import "HeadLineResponse.h"

@implementation HeadLinesBaseCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
	[self setUpUI];
}
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
	self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
	if (self) {
		[self setUpUI];
	}
	return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    // Configure the view for the selected state
}

-(void)setUpUI
{
	[self.contentView addSubview:self.thumb];
	[self.contentView addSubview:self.titleLable];
	[self.contentView addSubview:self.timeLable];
	[self.contentView addSubview:self.timeThumb];
	[self.contentView addSubview:self.platformLable];
	[self.contentView addSubview:self.spaceLine];
	
	[self.platformLable mas_makeConstraints:^(MASConstraintMaker *make) {
		make.left.mas_equalTo(px_scale(40));
		make.centerY.equalTo(self.timeThumb);
		make.height.mas_equalTo(px_scale(33));
	}];

	[self.timeThumb mas_makeConstraints:^(MASConstraintMaker *make) {
		make.size.mas_equalTo((CGSize){px_scale(26),px_scale(26)});
		make.bottom.mas_equalTo(px_scale(-28));
		make.left.mas_equalTo(px_scale(200));
	}];

	[self.timeLable mas_makeConstraints:^(MASConstraintMaker *make) {
		make.centerY.equalTo(self.timeThumb);
		make.height.mas_equalTo(px_scale(35));
		make.left.equalTo(self.timeThumb.mas_right).offset(px_scale(6));
	}];

	[self.spaceLine mas_makeConstraints:^(MASConstraintMaker *make) {
		make.left.mas_equalTo(px_scale(30));
		make.right.mas_equalTo(-px_scale(30));
		make.height.mas_equalTo(0.8);
		make.bottom.mas_equalTo(0);
	}];

	[self setViewLayout];
}

-(void)setModel:(id)model
{
	_model = model;
	BrandHeadModel *headModel = _model;
	[self.thumb sd_setImageWithURL:[NSURL URLWithString:headModel.thumb]];
	self.titleLable.text = headModel.title;
	self.timeLable.text = headModel.addtime;
	self.platformLable.text = headModel.username;
}


-(void)setViewLayout {}

-(UILabel *)platformLable
{
	if (!_platformLable) {
		_platformLable = [[UILabel alloc]init];
		_platformLable.textColor = [UIColor colorWithHexString:@"#999999"];
		_platformLable.font = [UIFont systemFontOfSize:12];
		_platformLable.text = @"中企品牌网";
	}
	return _platformLable;
}
-(UILabel *)timeLable
{
	if (!_timeLable) {
		_timeLable = [[UILabel alloc]init];
		_timeLable.textColor = [UIColor colorWithHexString:@"#999999"];
		_timeLable.font = [UIFont systemFontOfSize:12];
		_timeLable.text = @"---:--:--";
	}
	return _timeLable;
}
-(UIImageView *)timeThumb
{
	if (!_timeThumb) {
		_timeThumb = [[UIImageView alloc]init];
		_timeThumb.image =[UIImage imageNamed:@"home_sjnz_icon"];
	}
	return _timeThumb;
}

-(UIImageView *)thumb
{
	if (!_thumb) {
		_thumb = [[UIImageView alloc]init];
		_thumb.layer.cornerRadius = px_scale(10);
		_thumb.layer.masksToBounds = YES;
		_thumb.backgroundColor =[UIColor colorWithHexString:@"#DCDCDC"];
	}
	return _thumb;
}

-(UILabel *)titleLable
{
	if (!_titleLable) {
		_titleLable = [[UILabel alloc]init];
		_titleLable.textColor = [UIColor colorWithHexString:@"#333333"];
		_titleLable.font = [UIFont boldSystemFontOfSize:15];
		_titleLable.text  = @"这是一个很好吃的糖果哦拉拉然后呢就是拉拉然";
	}
	return _titleLable;
}

-(UIView *)spaceLine
{
	if (!_spaceLine) {
		_spaceLine = [[UIView alloc]init];
		_spaceLine.backgroundColor = [UIColor colorWithHexString:@"#DCDCDC"];
	 }
	return _spaceLine;
}




@end
