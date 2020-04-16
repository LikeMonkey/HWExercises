//
//  HomeHeadlinesCell.m
//  ZhongQiBrand
//
//  Created by ios2 on 2019/9/20.
//  Copyright © 2019 CY. All rights reserved.
//

#import "HomeHeadlinesCell.h"
#import "HomeResponse.h"

@implementation HomeHeadlinesCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
	self =[super initWithStyle:style reuseIdentifier:reuseIdentifier];
	if (self) {
		[self setUpUI];
	}
	return self;
}
#pragma mark setUpUI
-(void)setUpUI
{
	[self.contentView addSubview:self.thumb];
	[self.contentView addSubview:self.titleLable];
	[self.contentView addSubview:self.platformLable];
	[self.contentView addSubview:self.timeLable];
	[self.contentView addSubview:self.timeThumb];

	MASAttachKeys(self.thumb,self.timeLable,self.platformLable,self.timeThumb);

	[self.thumb mas_makeConstraints:^(MASConstraintMaker *make) {
		make.size.mas_equalTo((CGSize){px_scale(690),px_scale(268)});
		make.centerX.mas_equalTo(0);
		make.top.mas_equalTo(px_scale(40));
	}];

	[self.titleLable mas_makeConstraints:^(MASConstraintMaker *make) {
		make.left.right.equalTo(self.thumb);
		make.top.equalTo(self.thumb.mas_bottom).offset(px_scale(20));
		make.height.mas_equalTo(px_scale(42));
	}];

	[self.platformLable mas_makeConstraints:^(MASConstraintMaker *make) {
		make.left.equalTo(self.thumb);
		make.centerY.equalTo(self.timeThumb);
		make.height.mas_equalTo(px_scale(33));
	}];

	[self.timeThumb mas_makeConstraints:^(MASConstraintMaker *make) {
		make.size.mas_equalTo((CGSize){px_scale(26),px_scale(26)});
		make.top.equalTo(self.thumb.mas_bottom).offset(px_scale(87));
		make.left.mas_equalTo(px_scale(200));
	}];

	[self.timeLable mas_makeConstraints:^(MASConstraintMaker *make) {
		make.centerY.equalTo(self.timeThumb);
		make.height.mas_equalTo(px_scale(35));
		make.left.equalTo(self.timeThumb.mas_right).offset(px_scale(6));
	}];

	//加载间距 ====
	[self loadSpaceView];
}

-(void)setModel:(id)model
{
	_model =model;
	HomeNewsModel *newsModel = model;
	[self.thumb sd_setImageWithURL:[NSURL URLWithString:newsModel.thumb]];
	self.timeLable.text = newsModel.addtime;
	self.titleLable.text = newsModel.title;
	self.platformLable.text = newsModel.username;
}
-(void)loadSpaceView
{
	UIView *spaceView =[UIView new];
	spaceView.backgroundColor =[UIColor colorWithHexString:@"#F8F8F8"];
	[self.contentView addSubview:spaceView];
	[spaceView mas_makeConstraints:^(MASConstraintMaker *make) {
		make.left.right.bottom.mas_equalTo(0);
		make.height.mas_equalTo(px_scale(20));
	}];
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

#pragma mark - getter
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
		_titleLable.text  = @"------------------";
	 }
	return _titleLable;
}
-(UILabel *)platformLable
{
	if (!_platformLable) {
		_platformLable = [[UILabel alloc]init];
		_platformLable.textColor = [UIColor colorWithHexString:@"#999999"];
		_platformLable.font = [UIFont systemFontOfSize:12];
		_platformLable.text = @"------------------";
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
+(CGFloat)cellheight
{
	return px_scale(40+268+176);
}






@end
