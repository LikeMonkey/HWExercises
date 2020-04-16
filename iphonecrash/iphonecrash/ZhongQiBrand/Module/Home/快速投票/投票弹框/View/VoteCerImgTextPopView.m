//
//  VoteCerImgTextPopView.m
//  ZhongQiBrand
//
//  Created by ios2 on 2019/11/6.
//  Copyright © 2019 CY. All rights reserved.
//

#import "VoteCerImgTextPopView.h"
#import "PointImageView.h"

@interface VoteCerImgTextPopView ()
@property (nonatomic,strong)UIView  *contentView;
@property (nonatomic,strong)UIImageView *logoImgView;
@property (nonatomic,strong)UILabel *brandNameLable;//品牌名称
@property (nonatomic,strong)PointImageView *pointImgView;
@property (nonatomic,strong)UILabel *tipMsgLable;//提示文字

@end

@implementation VoteCerImgTextPopView
+(instancetype)showInWindow
{
	UIWindow *window =  [[UIApplication sharedApplication].delegate window];
	VoteCerImgTextPopView *popView =  [[self alloc]initWithFrame:[UIScreen mainScreen].bounds];
	[window addSubview:popView];
	return popView;
}

-(instancetype)initWithFrame:(CGRect)frame
{
	self =[super initWithFrame:frame];
	if (self) {
		self.backgroundColor = [[UIColor blackColor]colorWithAlphaComponent:0.5];
		[self loadContentView];
	}
	return self;
}

#pragma mark - private method
-(void)loadContentView
{
	[self contentView];
	//加载关闭按钮
	UIButton *closeButton = [UIButton buttonWithType:UIButtonTypeCustom];
	[closeButton setImage:[UIImage imageNamed:@"vote_close_icon"] forState:UIControlStateNormal];
	[closeButton addTarget:self action:@selector(closeClicked:) forControlEvents:UIControlEventTouchUpInside];
	[self addSubview:closeButton];
	[closeButton mas_makeConstraints:^(MASConstraintMaker *make) {
		make.top.equalTo(self.contentView.mas_bottom).offset(px_scale(50));
		make.centerX.mas_equalTo(0);
		make.width.height.mas_equalTo(px_scale(80));
	}];
}

-(void)reloadImageData:(UIButton *)button
{
	[self.pointImgView reload];
}
-(void)closeClicked:(id)sender
{
	[self dismiss];
}
-(void)dismiss
{
	[self removeFromSuperview];
}
#pragma mark - getter
-(UIView *)contentView
{
	if (!_contentView) {
		_contentView = [[UIView alloc]init];
		_contentView.backgroundColor = [UIColor whiteColor];
		_contentView.layer.cornerRadius = 10;
		_contentView.clipsToBounds = YES;
		[self addSubview:_contentView];
		[_contentView mas_makeConstraints:^(MASConstraintMaker *make) {
			make.centerX.mas_equalTo(0);
			make.width.mas_equalTo(px_scale(600));
			make.height.mas_equalTo(px_scale(676));
			make.centerY.mas_equalTo(-px_scale(37));
		}];

		[_contentView addSubview:self.logoImgView];
		[_logoImgView mas_makeConstraints:^(MASConstraintMaker *make) {
			make.centerX.mas_equalTo(0);
			make.top.mas_equalTo(px_scale(133));
			make.size.mas_equalTo(CGSizeMake(px_scale(236), px_scale(126)));
		}];

		UILabel *titlelable = [self lableFont:[UIFont systemFontOfSize:19] textColor:[UIColor colorWithHexString:@"#333333"]];
		titlelable.text = @"投票验证";
		[_contentView addSubview:titlelable];

		[titlelable mas_makeConstraints:^(MASConstraintMaker *make) {
			make.centerX.mas_equalTo(0);
			make.height.mas_equalTo(px_scale(53));
			make.top.mas_equalTo(px_scale(50));
		}];

	  NSString *imgNames[] = {@"tpyz_zsxz_img",@"tpyz_zsxy_img"};
		for (int i = 0; i<2; i++) {
			UIImageView *lineImgV = [UIImageView new];
			lineImgV.image = [UIImage imageNamed:imgNames[i]];
			[_contentView addSubview:lineImgV];
			[lineImgV mas_makeConstraints:^(MASConstraintMaker *make) {
				make.centerY.equalTo(titlelable);
				make.size.mas_equalTo(CGSizeMake(px_scale(97), px_scale(12)));
				if (i==0) {
					make.left.mas_equalTo(px_scale(100));
				}else{
					make.right.mas_equalTo(-px_scale(100));
				}
			}];
		}

		[_contentView addSubview:self.brandNameLable];
		self.brandNameLable.text = @"------";
		[self.brandNameLable mas_makeConstraints:^(MASConstraintMaker *make) {
			make.left.mas_equalTo(px_scale(10));
			make.right.mas_equalTo(-px_scale(10));
			make.top.equalTo(self.logoImgView.mas_bottom).offset(px_scale(16));
			make.height.mas_equalTo(px_scale(48));
		}];
		[_contentView addSubview:self.pointImgView];
		[self.pointImgView reload];

		[self.pointImgView mas_makeConstraints:^(MASConstraintMaker *make) {
			make.top.mas_equalTo(px_scale(363));
			make.width.mas_equalTo(px_scale(500));
			make.height.mas_equalTo(px_scale(200));
			make.centerX.mas_equalTo(0);
		}];

		[_contentView addSubview:self.tipMsgLable];

		[self.tipMsgLable mas_makeConstraints:^(MASConstraintMaker *make) {
			make.top.equalTo(self.pointImgView.mas_bottom).offset(px_scale(20));
			make.left.equalTo(self.pointImgView.mas_left).offset(px_scale(14));
			make.height.mas_equalTo(px_scale(50));
			make.right.mas_equalTo(-px_scale(20));
		}];

		//加载转圈按钮
		UIButton *reloadButton = [UIButton buttonWithType:UIButtonTypeCustom];
		[reloadButton setImage:[UIImage imageNamed:@"vote_sx_icon"] forState:UIControlStateNormal];
		[_contentView insertSubview:reloadButton atIndex:0];
		[reloadButton addTarget:self action:@selector(reloadImageData:) forControlEvents:UIControlEventTouchUpInside];
		[reloadButton mas_makeConstraints:^(MASConstraintMaker *make) {
			make.right.mas_equalTo(-px_scale(50));
			make.centerY.equalTo(titlelable);
			make.size.mas_equalTo((CGSize){px_scale(50),px_scale(50)});
		}];
	 }
	return _contentView;
}

-(UIImageView *)logoImgView
{
	if (!_logoImgView) {
		_logoImgView = [[UIImageView alloc]init];
		_logoImgView.layer.cornerRadius = px_scale(5);
		_logoImgView.clipsToBounds = YES;
		_logoImgView.layer.borderColor = (__bridge CGColorRef _Nullable)([UIColor colorWithHexString:@"#CF0405"]);
		_logoImgView.layer.borderWidth  = 3.0;
		_logoImgView.backgroundColor = [UIColor colorWithHexString:@"#f3f3f3"];
	 }
	return _logoImgView;
}
//品牌名
-(UILabel *)brandNameLable
{
	if (!_brandNameLable)
	 {
		_brandNameLable = [self lableFont:[UIFont boldSystemFontOfSize:17] textColor:[UIColor colorWithHexString:@"#333333"]];
		_brandNameLable.textAlignment = NSTextAlignmentCenter;
	 }
	return _brandNameLable;
}

-(PointImageView *)pointImgView
{
	if (!_pointImgView)
	 {
		_pointImgView = [[PointImageView alloc]init];
		_pointImgView.frame = CGRectMake(0, 0, px_scale(500), px_scale(200));
		[_pointImgView setThumbUrlBlock:^NSString *(NSString *rand) {
			NSString *url = [NSString stringWithFormat:@"http://apizhengyang.10brandcn.com:88/captcha/clicaptcha.php?rand=%@",rand];
			return url;
		}];
		__weak typeof(self)ws = self;
		//验证数据时候会走的方法
		[_pointImgView setRequestYZPoint:^(NSString *pontJson, NSString *rand, YZCompletion completion) {
			[ws requestYzJson:pontJson andRand:rand andCompletion:completion];
		}];
		[_pointImgView setSucessCompletion:^(NSString *rand, NSString *itemId, NSString *json) {
			NSLog(@"最终结果/\?|?| 验证通过后调用输出:|%@",json);
		}];
		//切换数据时候走的方法 每次调用reload  会走的方法 回传一个 随机值
		[_pointImgView setChangeTextRequest:^(NSString *rand, LoadTextCompletion completion) {
			[ws requestTextWithRand:rand andCompletion:completion];
		}];
		//内部移除控制器
		[_pointImgView setDismissBlock:^{
			[ws removeFromSuperview];
		}];
	 }
	return _pointImgView;
}

//验证
-(void)requestYzJson:(NSString *)jsonString andRand:(NSString *)rand andCompletion:(YZCompletion)completion
{
	[RequestBaseTool postUrlStr:@"http://apizhengyang.10brandcn.com:88/captcha/clicaptcha.text.php" andParms:@{
																											   @"rand":rand
																											   } andCompletion:^(id obj) {
																												   if (completion) {
																													   completion(NO,jsonString);
																												   }
																											   } Error:^(NSError *errror) {
																												   if (completion) {
																													   completion(NO,jsonString);
																												   }
																											   }];
}
-(void)requestTextWithRand:(NSString *)rand andCompletion:(LoadTextCompletion)completion
{
	  [self configerTipMsg:@""]; //将提示文字隐藏
	[RequestBaseTool postUrlStr:@"http://apizhengyang.10brandcn.com:88/captcha/clicaptcha.text.php" andParms:@{
																											   @"rand":rand
																											   } andCompletion:^(id obj) {
																												   if (completion) {
																													   completion(@"中企品牌网",YES);
																													   [self configerTipMsg:@"中企品牌网"];
																												   }
																											   } Error:^(NSError *errror) {
																												   if (completion) {
																													   completion(@"",NO);
																													    [self configerTipMsg:@""];
																												   }
																											   }];
}
//设置提示文字
-(void)configerTipMsg:(NSString *)tipText
{
	if (NullString(tipText)) {
		self.tipMsgLable.hidden = YES;
		return;
	}
	self.tipMsgLable.hidden = NO;

	tipText = [NSString stringWithFormat:@" “%@” ",tipText];
	NSString *str = [NSString stringWithFormat:@"请按%@依次点击上面文字",tipText];
	NSMutableAttributedString *abs = [[NSMutableAttributedString alloc]initWithString:str attributes:@{
																									   NSForegroundColorAttributeName:[UIColor colorWithHexString:@"#999999"],
																									   NSFontAttributeName:[UIFont boldSystemFontOfSize:14]
																									   }];
	[abs setAttributes:@{
						 NSForegroundColorAttributeName:[UIColor colorWithHexString:@"#CF0405"],
						 NSFontAttributeName:[UIFont boldSystemFontOfSize:14]
						 } range:NSMakeRange(2, tipText.length)];
	self.tipMsgLable.attributedText = abs; //赋值富文本

}
-(UILabel *)tipMsgLable
{
	if (!_tipMsgLable) {
		_tipMsgLable = [self lableFont:[UIFont boldSystemFontOfSize:14] textColor:[UIColor colorWithHexString:@"#999999"]];
		_tipMsgLable.hidden =YES;
	 }
	return _tipMsgLable;
}

-(UILabel *)lableFont:(UIFont *)font textColor:(UIColor *)color
{
	UILabel *lable = [UILabel new];
	lable.font = font;
	lable.textColor = color;
	return lable;
}

@end
