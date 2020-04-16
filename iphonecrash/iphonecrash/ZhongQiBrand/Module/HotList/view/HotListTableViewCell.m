//
//  HotListTableViewCell.m
//  ZhongQiBrand
//
//  Created by ios2 on 2019/9/20.
//  Copyright © 2019 CY. All rights reserved.
//

#import "HotListTableViewCell.h"
#import "HotListResponse.h"

@implementation HotListTableViewCell

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
-(void)setUpUI
{
	[self.contentView addSubview:self.bgImageView];
	[self.contentView addSubview:self.titleLable];
	[self.contentView addSubview:self.brandNameLable];

	[self.contentView addSubview:self.timeThumb];
	[self.contentView addSubview:self.timeLable];

	[self.bgImageView mas_makeConstraints:^(MASConstraintMaker *make) {
		make.left.right.mas_equalTo(0);
		make.top.mas_equalTo(0);
		make.bottom.mas_equalTo(px_scale(22));
	}];

	[self.titleLable mas_makeConstraints:^(MASConstraintMaker *make) {
		make.left.mas_equalTo(px_scale(70));
		make.top.mas_equalTo(px_scale(22+45));
		make.right.mas_equalTo(-px_scale(30));
		make.height.mas_equalTo(px_scale(48));
	}];

	[self.brandNameLable mas_makeConstraints:^(MASConstraintMaker *make) {
		make.left.mas_equalTo(px_scale(70));
		make.top.equalTo(self.titleLable.mas_bottom);
		make.right.mas_equalTo(-px_scale(30));
		make.height.mas_equalTo(px_scale(40));
	}];

	[self.timeThumb mas_makeConstraints:^(MASConstraintMaker *make) {
		make.bottom.mas_equalTo(-px_scale(25));
		make.size.mas_equalTo((CGSize){px_scale(26),px_scale(26)});
		make.right.mas_equalTo(-px_scale(195));
	}];

	[self.timeLable mas_makeConstraints:^(MASConstraintMaker *make) {
		make.centerY.equalTo(self.timeThumb);
		make.height.mas_equalTo(px_scale(27));
		make.left.equalTo(self.timeThumb.mas_right).offset(px_scale(12));
		make.right.mas_equalTo(0);
	}];

}

-(void)setModel:(id)model
{
	_model = model;
	HotListModel *hotlistModel = (HotListModel *)_model;
	self.timeLable.text = hotlistModel.addtime;
	self.titleLable.text = hotlistModel.title;
	self.detailTextLabel.text = hotlistModel.show;
}


#pragma mark - getter
-(UIImageView *)bgImageView
{
	if (!_bgImageView) {
		_bgImageView = [[UIImageView alloc]init];
		_bgImageView.image = [UIImage imageNamed:@"rmbd_list_img"];
	 }
	return _bgImageView;
}
-(UILabel *)titleLable
{
	if (!_titleLable) {
		_titleLable = [[UILabel alloc]init];
		_titleLable.font =[UIFont boldSystemFontOfSize:17];
		_titleLable.textColor = [UIColor colorWithHexString:@"#333333"];
	 }
	return _titleLable;
}
-(UILabel *)brandNameLable
{
	if (!_brandNameLable)  {
		_brandNameLable = [[UILabel alloc]init];
		_brandNameLable.font =[UIFont systemFontOfSize:14];
		_brandNameLable.textColor = [UIColor colorWithHexString:@"#363636"];
	 }
	return _brandNameLable;
}
-(UILabel *)timeLable
{
	if (!_timeLable) {
		_timeLable = [[UILabel alloc]init];
		_timeLable.textColor = [UIColor colorWithHexString:@"#999999"];
		_timeLable.font = [UIFont systemFontOfSize:12];
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
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
