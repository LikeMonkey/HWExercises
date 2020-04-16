//
//  ShareScreenItemCell.m
//  VoteCloud
//
//  Created by ios2 on 2019/8/31.
//  Copyright © 2019 CY. All rights reserved.
//

#import "ShareScreenItemCell.h"

@implementation ShareScreenItemCell

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
	[self.bgImageView addSubview:self.userImageView];
	[self.bgImageView addSubview:self.numBgImageView];
	[self.numBgImageView addSubview:self.numLable];
	CGFloat scale = 452.0/750.0; //比例尺
	[self.bgImageView mas_makeConstraints:^(MASConstraintMaker *make) {
		make.left.right.top.mas_equalTo(0);
		make.height.mas_equalTo(px_scale(890*scale));
	}];
	
	[self.userImageView mas_makeConstraints:^(MASConstraintMaker *make) {
		make.width.mas_equalTo(px_scale(372));
		make.height.mas_equalTo(px_scale(279));
		make.centerX.mas_equalTo(0);
		make.top.mas_equalTo(px_scale(40));
	}];


	self.numLable.textColor = [UIColor colorWithHexString:@"#654820"];
	self.numLable.textAlignment = NSTextAlignmentCenter;
	[self.bgImageView addSubview:self.nameLable];
	[self.bgImageView addSubview:self.voteCountLable];

	[self.bgImageView addSubview:self.qrCodeImageView];

	[self.bgImageView insertSubview:self.nameLineView atIndex:0];

	[self.bgImageView addSubview:self.qrLable];

	[self.nameLineView mas_makeConstraints:^(MASConstraintMaker *make) {
		make.bottom.left.equalTo(self.nameLable);
		make.height.mas_equalTo(px_scale(Share_scale(20)));
		make.width.mas_equalTo(px_scale(Share_scale(105)));
	}];
}
-(void)configerShareInfo:(id)shareInfo andIndex:(NSInteger )index
{
	self.numBgImageView.hidden = (index != 0?NO:YES);

	ShareInfoModel *shareModel = shareInfo;
	CGFloat image_w[] = {Share_scale(577.0f),Share_scale(617),Share_scale(573)};
	CGFloat img_h[] = {Share_scale(433),Share_scale(463.0),Share_scale(430)};
	CGFloat img_top[] = {Share_scale(72),Share_scale(67),Share_scale(75)};

	CGFloat w = image_w[index%3];
	CGFloat h = img_h[index%3];
	CGFloat top = img_top[index%3];

	NSString *imageName = [NSString stringWithFormat:@"xsfx%@_bg",@(index + 1)];
	self.bgImageView.image = [UIImage imageNamed:imageName];

	[self.userImageView sd_setImageWithURL:[NSURL URLWithString:shareModel.img]];


	[self.userImageView mas_updateConstraints:^(MASConstraintMaker *make) {
		make.width.mas_equalTo(px_scale(w));
		make.height.mas_equalTo(px_scale(h));
		make.top.mas_equalTo(px_scale(top));
	}];

	CGFloat qr_top[] = {Share_scale(102),Share_scale(90),Share_scale(36)};
	CGFloat qr_w[] = {Share_scale(145),Share_scale(185),Share_scale(140)};
	CGFloat qr_r[] = {Share_scale(155),Share_scale(64),Share_scale(96)};
	CGFloat qr_t = qr_top[index%3];
	CGSize qrSize = (CGSize){px_scale(qr_w[index%3]),px_scale(qr_w[index%3])};
	CGFloat qr_right = qr_r[index%3];

	[self.qrCodeImageView mas_remakeConstraints:^(MASConstraintMaker *make) {
		make.top.equalTo(self.userImageView.mas_bottom).offset(px_scale(qr_t));
		make.size.mas_equalTo(qrSize);
		make.right.mas_equalTo(-px_scale(qr_right));
	}];

	[self.qrCodeImageView sd_setImageWithURL:[NSURL URLWithString:shareModel.erweima]];

	CGFloat font_size[] = {Share_scale(46),Share_scale(56),Share_scale(34)};
	NSArray *textColorHexs = @[@"#122D8C",@"#ffffff",@"#000000"];
	self.nameLable.textColor = [UIColor colorWithHexString:textColorHexs[index%3]];
	self.nameLable.text = shareModel.title;
	if (index == 1) {
		self.nameLable.font = [UIFont boldSystemFontOfSize:font_size[index]/2.0];
	}else{
		self.nameLable.font = [UIFont systemFontOfSize:font_size[index]/2.0];
	}
	CGFloat name_top[] = {Share_scale(117),Share_scale(114),Share_scale(38)};
	CGFloat name_left[] = {Share_scale(134),Share_scale(66),Share_scale(88)};
	CGFloat nameTop = name_top[index%3];
	CGFloat nameLeft = name_left[index%3];
	CGFloat nameHs[] = {Share_scale(46),Share_scale(56),Share_scale(34)};
	CGFloat rightSs[] = {0,0,Share_scale(20)};
	CGFloat name_h = px_scale(nameHs[index%3]);
	CGFloat right_space =rightSs[index%3];
	[self.nameLable mas_remakeConstraints:^(MASConstraintMaker *make) {
		make.height.mas_equalTo(name_h);
		make.top.equalTo(self.userImageView.mas_bottom).offset(px_scale(nameTop));
		make.left.mas_equalTo(px_scale(nameLeft));
		make.right.equalTo(self.qrCodeImageView.mas_left).offset(px_scale(-right_space));
	}];

	self.nameLineView.hidden = (index == 0?NO:YES);
	self.voteCountLable.text = [NSString stringWithFormat:@"%@票",shareModel.vote];
	CGFloat voteFontSize[] =  {Share_scale(42)/2.0,Share_scale(50)/2.0,Share_scale(21)/2.0};
	CGFloat vote_font = voteFontSize[index%3];
	self.voteCountLable.font = [UIFont systemFontOfSize:vote_font];
	CGFloat vote_left[] =  {Share_scale(135),Share_scale(65),Share_scale(87)};
	CGFloat vote_top[] =  {Share_scale(34),Share_scale(48),Share_scale(15)};
	CGFloat voteLeft = vote_left[index%3];
	CGFloat voteTop = vote_top[index%3];
	NSArray *colorHexs = @[@"#323333",@"#E7C464",@"#000000"];
	self.voteCountLable.textColor = [UIColor colorWithHexString:colorHexs[index%3]];
	[self.voteCountLable sizeToFit];
	CGFloat voteHeight = CGRectGetHeight(self.voteCountLable.bounds);
	[self.voteCountLable mas_makeConstraints:^(MASConstraintMaker *make) {
		make.left.mas_equalTo(px_scale(voteLeft));
		make.top.equalTo(self.nameLable.mas_bottom).offset(px_scale(voteTop));
		make.height.mas_equalTo(voteHeight);
	}];

//设置编号 颜色等 ~
	if (index != 0){
		NSString *symbolStr = (index==1)?@"号":@"";
		self.numLable.text = [NSString stringWithFormat:@"%@%@",shareModel.num,symbolStr];
		NSString *imgName = (index ==1)?@"xsfx2_bh_bg":@"xsfx_bianh_img";
		NSString *colorHex = (index == 1)?@"#654820":@"#000000";
		self.numLable.textAlignment = (index==1)?NSTextAlignmentCenter:NSTextAlignmentLeft;
		UIFont * numFont = (index == 1)?[UIFont boldSystemFontOfSize:15]:[UIFont systemFontOfSize:Share_scale(28)/2.0];
		self.numLable.textColor = [UIColor colorWithHexString:colorHex];
		self.numLable.font = numFont;
		self.numBgImageView.image = [UIImage imageNamed:imgName];
		[self.numBgImageView mas_remakeConstraints:^(MASConstraintMaker *make) {
			if (index==1) {
				make.top.mas_equalTo(px_scale(Share_scale(14)));
				make.width.mas_equalTo(px_scale(Share_scale(234)));
				make.centerX.mas_equalTo(0);
				make.height.mas_equalTo(px_scale(Share_scale(84)));
			}else{
				make.bottom.mas_equalTo(-px_scale(Share_scale(153)));
				make.centerX.mas_equalTo(0);
				make.width.mas_equalTo(px_scale(Share_scale(176)));
				make.height.mas_equalTo(px_scale(Share_scale(52)));
			}
		}];

		[self.numLable mas_makeConstraints:^(MASConstraintMaker *make) {
			if (index==1) {
				make.edges.insets(UIEdgeInsetsMake(0, 0, 0, 0));
			}else{
				make.top.mas_equalTo(px_scale(Share_scale(19)));
				make.left.mas_equalTo(px_scale(Share_scale(87)));
				make.height.mas_equalTo(px_scale(Share_scale(21)));
				make.right.mas_equalTo(0);
			}
		}];
	}
	//设置二维码底部 -------
	NSString *qrTxts[] = {@"扫描二维码",@"扫一扫参与",@"扫码为你支持的\n选手投票"};
	NSString *qrTextHexs[]={@"#323333",@"#FFFFFF",@"#000000"};
	CGFloat qr_fontSize[] = {Share_scale(28)/2.0,Share_scale(40)/2.0,Share_scale(17)/2.0};
	self.qrLable.font  = [UIFont systemFontOfSize:qr_fontSize[index%3]];
	self.qrLable.text = qrTxts[index%3];
	self.qrLable.textColor = [UIColor colorWithHexString:qrTextHexs[index%3]];
	self.qrLable.numberOfLines = 2;

	CGFloat qrText_top[] = {Share_scale(21),Share_scale(19),Share_scale(17)};
	CGFloat qrTextTop = qrText_top[index%3];
	[self.qrLable mas_makeConstraints:^(MASConstraintMaker *make) {
		make.top.equalTo(self.qrCodeImageView.mas_bottom).offset(px_scale(qrTextTop));
		make.centerX.equalTo(self.qrCodeImageView);
		make.height.mas_greaterThanOrEqualTo(0);
	}];
}
#pragma mark Getter
-(UIImageView *)userImageView {
	if (!_userImageView) {
		_userImageView = [[UIImageView alloc]init];
		_userImageView.clipsToBounds = YES;
		_userImageView.contentMode = UIViewContentModeScaleAspectFill;
	}
	return _userImageView;
}

-(UILabel *)numLable {
	if (!_numLable) {
		_numLable = [[UILabel alloc]init];
	}
	return _numLable;
}
-(UILabel *)nameLable {
	if (!_nameLable) {
		_nameLable = [[UILabel alloc]init];
		_nameLable.textAlignment = NSTextAlignmentLeft;
	}
	return _nameLable;
}
-(UILabel *)voteCountLable {
	if (!_voteCountLable)  {
		_voteCountLable = [[UILabel alloc]init];
		_voteCountLable.textAlignment = NSTextAlignmentLeft;
	}
	return _voteCountLable;
}

-(UIImageView *)qrCodeImageView
{
	if (!_qrCodeImageView) {
		_qrCodeImageView = [[UIImageView alloc]init];
	}
	return _qrCodeImageView;
}

-(UIImageView *)numBgImageView
{
	if (!_numBgImageView) {
		_numBgImageView = [[UIImageView alloc]init];
		_numBgImageView.image = [UIImage imageNamed:@"xsfx2_bh_bg"];
	 }
	return _numBgImageView;
}
-(UIView *)nameLineView
{
	if (!_nameLineView) {
		_nameLineView = [[UIView alloc]init];
		_nameLineView.backgroundColor = [UIColor colorWithHexString:@"#F5E928"];
		_nameLineView.hidden = YES;
	 }
	return _nameLineView;
}
-(UILabel *)qrLable
{
	if (!_qrLable)  {
		_qrLable = [[UILabel alloc]init];
		_qrLable.textAlignment = NSTextAlignmentCenter;
	 }
	return _qrLable;
}



@end
