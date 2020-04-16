//
//  ShareActivityScreenCell.m
//  VoteCloud
//
//  Created by ios2 on 2019/9/2.
//  Copyright © 2019 CY. All rights reserved.
//

#import "ShareActivityScreenCell.h"

@implementation ShareActivityScreenCell


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
	[self.bgImageView addSubview:self.titleLable];
	[self.bgImageView addSubview:self.qrImageView];
	[self.bgImageView addSubview:self.qrLable];
	[self.bgImageView mas_makeConstraints:^(MASConstraintMaker *make) {
		make.left.right.top.mas_equalTo(0);
		make.height.mas_equalTo(px_scale(Share_scale(890)));
	}];

}

-(void)resetLayout:(NSInteger)index
{
	[self.titleLable mas_remakeConstraints:^(MASConstraintMaker *make) {
		if (index == 0) {
			make.centerX.mas_equalTo(0);
			make.width.mas_equalTo(px_scale(Share_scale(465)));
			make.top.mas_equalTo(px_scale(Share_scale(157)));
		}else if (index == 1) {
			make.centerX.mas_equalTo(0);
			make.width.mas_equalTo(px_scale(Share_scale(465)));
			make.top.mas_equalTo(px_scale(Share_scale(277)));
		}else {
			make.centerX.mas_equalTo(0);
			make.width.mas_equalTo(px_scale(Share_scale(507)));
			make.top.mas_equalTo(px_scale(Share_scale(96)));
		}
	}];
	[self.qrImageView mas_remakeConstraints:^(MASConstraintMaker *make) {
		if (index == 0) {
			make.centerX.mas_equalTo(0);
			make.size.mas_equalTo((CGSize){px_scale(Share_scale(215)),px_scale(Share_scale(215))});
			make.bottom.mas_equalTo(-px_scale(Share_scale(265)));
		}else if (index == 1) {
			make.centerX.mas_equalTo(0);
			make.size.mas_equalTo((CGSize){px_scale(Share_scale(177)),px_scale(Share_scale(177))});
			make.bottom.mas_equalTo(-px_scale(Share_scale(102)));
		}else {
			make.right.mas_equalTo(-px_scale(Share_scale(60)));
			make.size.mas_equalTo((CGSize){px_scale(Share_scale(155)),px_scale(Share_scale(155))});
			make.bottom.mas_equalTo(-px_scale(Share_scale(30)));
		}
	}];

	[self.qrLable mas_makeConstraints:^(MASConstraintMaker *make) {
		if (index == 0) {
			make.top.equalTo(self.qrImageView.mas_bottom).offset(px_scale(Share_scale(164)));
			make.centerX.equalTo(self.qrImageView);
			make.height.mas_equalTo(px_scale(Share_scale(31)));
		}else if (index==1){
			make.top.equalTo(self.qrImageView.mas_bottom).offset(px_scale(Share_scale(29)));
			make.centerX.equalTo(self.qrImageView);
			make.height.mas_equalTo(px_scale(Share_scale(31)));
		}else{
			make.bottom.equalTo(self.qrImageView.mas_top).offset(-px_scale(Share_scale(8)));
			make.centerX.equalTo(self.qrImageView);
			make.height.mas_equalTo(px_scale(Share_scale(24)));
		}
	}];
}

-(void)configerShareInfo:(id)shareInfo andIndex:(NSInteger )index
{
	[self resetLayout:index];
	NSString *name = [NSString stringWithFormat:@"hdfx%@_bg",@(index+1)];
	self.bgImageView.image = [UIImage imageNamed:name];
	ShareInfoModel *shareInfoModel = shareInfo;
	NSString *title = shareInfoModel.title;
	CGFloat font_sizes[] = {Share_scale(57),Share_scale(55),Share_scale(42)};
	NSString *textColorHexs[] = {@"#E8D187",@"#EDE3B3",@"#FFFFFF"};
	CGFloat lineHeight = (index == 2)?px_scale(Share_scale(30)):px_scale(Share_scale(37));
	if (title) {
		if (title.length <=16) {
			NSString *titleStr = [self cutEight:title];
			self.titleLable.adjustsFontSizeToFitWidth = NO;
			self.titleLable.attributedText = [self titleAbs:titleStr fontSize:font_sizes[index%3]/2.0 colorHex:textColorHexs[index%3] lineSpace:lineHeight];
		}else{
			self.titleLable.adjustsFontSizeToFitWidth = YES;
			self.titleLable.attributedText =[self titleAbs:title fontSize:font_sizes[index%3]/2.0 colorHex:textColorHexs[index%3] lineSpace:lineHeight];

		}
	}
	[self.qrImageView sd_setImageWithURL:[NSURL URLWithString:shareInfoModel.erweima]];

	NSString *qrTxtHexs[] = {@"#E8D187",@"#EBCFA2",@"#FFFFFF"};
	NSString *qrTexts[] = {@"扫描二维码参与活动",@"扫描二维码参与活动",@"扫码参与活动"};
	CGFloat qrFontSize[] = {Share_scale(32)/2.0,Share_scale(32)/2.0,Share_scale(24)/2.0};
	self.qrLable.textColor = [UIColor colorWithHexString:qrTxtHexs[index%3]];
	self.qrLable.text =qrTexts[index%3];
	self.qrLable.font = [UIFont systemFontOfSize:qrFontSize[index%3]];
}

-(NSAttributedString *)titleAbs:(NSString *)str fontSize:(CGFloat)fontSize colorHex:(NSString *)colorHex lineSpace:(CGFloat)lineSpace
{
	NSMutableParagraphStyle *paragrahStyle = [[NSMutableParagraphStyle alloc]init];
	paragrahStyle.lineSpacing = lineSpace;
	paragrahStyle.lineBreakMode = NSLineBreakByTruncatingTail;
	paragrahStyle.alignment = NSTextAlignmentCenter;
	NSAttributedString *abs = [[NSMutableAttributedString alloc]initWithString:str attributes:@{
																								NSParagraphStyleAttributeName:paragrahStyle,
																								NSFontAttributeName:[UIFont systemFontOfSize:fontSize],
																								NSForegroundColorAttributeName:[UIColor colorWithHexString:colorHex]
																								}];
	return abs;
}


-(NSString *)cutEight:(NSString *)text
{
	if (text.length<=8) {
		return text;
	}
	//前8个 ~~~
	NSString *str0 = [text substringToIndex:8];
	//八个 后面的 ~~~
	NSString *str1 = [text substringWithRange:NSMakeRange(str0.length, text.length - str0.length)];
	NSString *str = [NSString stringWithFormat:@"%@\n%@",str0,str1];
	return str;
}


#pragma mark - Getter
-(UILabel *)titleLable
{
	if (!_titleLable)  {
		_titleLable = [[UILabel alloc]init];
		_titleLable.numberOfLines = 2;
		_titleLable.textAlignment = NSTextAlignmentCenter;
	 }
	return _titleLable;
}
-(UILabel *)qrLable
{
	if (!_qrLable) {
		_qrLable = [[UILabel alloc]init];
	 }
	return _qrLable;
}

-(UIImageView *)qrImageView
{
	if (!_qrImageView)
	 {
		_qrImageView = [[UIImageView alloc]init];
	 }
	return _qrImageView;
}








@end
