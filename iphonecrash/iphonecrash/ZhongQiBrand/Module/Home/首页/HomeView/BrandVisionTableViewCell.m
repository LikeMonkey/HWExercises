//
//  BrandVisionTableViewCell.m
//  ZhongQiBrand
//
//  Created by ios2 on 2019/9/17.
//  Copyright © 2019 CY. All rights reserved.
//

#import "BrandVisionTableViewCell.h"
#import "HomeResponse.h"

@implementation BrandVisionTableViewCell
{
	UIView *_spaceView;
}
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
	[self.contentView addSubview:self.logoBgView];
	[self.logoBgView addSubview:self.logoImageView];
	[self.contentView addSubview:self.titleLable];
	[self.contentView addSubview:self.descLable];

	[self.logoBgView mas_makeConstraints:^(MASConstraintMaker *make) {
		make.left.mas_equalTo(px_scale(30));
		make.top.mas_equalTo(px_scale(25));
		make.size.mas_equalTo((CGSize){px_scale(204),px_scale(118)});
	}];

	[self.logoImageView mas_makeConstraints:^(MASConstraintMaker *make) {
		make.centerX.centerY.mas_equalTo(0);
		make.size.mas_equalTo((CGSize){px_scale(165),px_scale(89)});
	}];

	[_titleLable mas_makeConstraints:^(MASConstraintMaker *make) {
		make.left.equalTo(self.logoBgView.mas_right).offset(px_scale(30));
		make.height.mas_equalTo(px_scale(42));
		make.right.mas_equalTo(-px_scale(20));
		make.top.equalTo(self.logoBgView);
	}];

	[_descLable mas_makeConstraints:^(MASConstraintMaker *make) {
		make.left.equalTo(self.titleLable);
		make.top.equalTo(self.titleLable.mas_bottom).offset(px_scale(4));
		make.right.mas_equalTo(-px_scale(44));
		make.height.mas_greaterThanOrEqualTo(10);
	}];

	[self loadSpaceView];
}

-(void)setModel:(id)model
{
	_model = model;
	HomebrandModel *brandModel = _model;
	 [self.logoImageView sd_setImageWithURL:[NSURL URLWithString:brandModel.thumb] placeholderImage:kGetImage(@"defalt")];
	[self configerDescText:brandModel.company];
	self.titleLable.text = brandModel.title;
}

-(void)configerDescText:(NSString *)descText
{
	descText = NullString(descText)?@"":descText;
	NSMutableParagraphStyle * phStyle = [[NSMutableParagraphStyle alloc]init];
	phStyle.lineSpacing = px_scale(8);
	phStyle.lineBreakMode = NSLineBreakByTruncatingTail;
	NSAttributedString *abs = [[NSAttributedString alloc]initWithString:descText attributes:@{
																							  NSParagraphStyleAttributeName:phStyle
																							  }];
	self.descLable.attributedText = abs;
}

-(void)setIsBottom:(BOOL)isBottom
{
	_isBottom = isBottom;
	_spaceView.hidden = _isBottom?NO:YES;
}
// ======== 
-(void)loadSpaceView
{
	UIView *spaceView =[UIView new];
	spaceView.hidden = YES;
	_spaceView = spaceView;
	spaceView.backgroundColor =[UIColor colorWithHexString:@"#F8F8F8"];
	[self.contentView addSubview:spaceView];
	[spaceView mas_makeConstraints:^(MASConstraintMaker *make) {
		make.left.right.bottom.mas_equalTo(0);
		make.height.mas_equalTo(px_scale(20));
	}];
}

#pragma mark - getter
-(UIImageView *)logoImageView {
	if (!_logoImageView)  {
		_logoImageView = [[UIImageView alloc]init];
		_logoImageView.backgroundColor = [UIColor whiteColor];
		_logoImageView.contentMode =  UIViewContentModeScaleAspectFit;
	}
	return _logoImageView;
}
-(UILabel *)titleLable {
	if (!_titleLable) {
		_titleLable = [[UILabel alloc]init];
		_titleLable.numberOfLines = 1;
		_titleLable.font = [UIFont boldSystemFontOfSize:15];
		_titleLable.textColor = [UIColor colorWithHexString:@"#333333"];
		_titleLable.textAlignment = NSTextAlignmentLeft;
		_titleLable.text = @"-------------";
	}
	return _titleLable;
}
-(UILabel *)descLable {
	if (!_descLable) {
		_descLable = [[UILabel alloc]init];
		_descLable.textAlignment = NSTextAlignmentCenter;
		_descLable.numberOfLines  = 2;
		_descLable.font = [UIFont systemFontOfSize:13];
		_descLable.textColor = [UIColor colorWithHexString:@"#666666"];
		_descLable.textAlignment = NSTextAlignmentLeft;
	}
	return _descLable;
}

-(UIView *)logoBgView
{
	if (!_logoBgView) {
		_logoBgView = [[UIView alloc]init];
		_logoBgView.layer.borderColor = [UIColor colorWithHexString:@"#DBDBDB"].CGColor;
		_logoBgView.layer.masksToBounds = YES;
		_logoBgView.layer.cornerRadius = px_scale(10);
		_logoBgView.layer.borderWidth = px_scale(4);
		_logoBgView.backgroundColor = [UIColor whiteColor];
	 }
	return _logoBgView;
}




- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
