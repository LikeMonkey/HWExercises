//
//  JoinPhoneView.m
//  ZhongQiBrand
//
//  Created by ios2 on 2019/10/21.
//  Copyright © 2019 CY. All rights reserved.
//

#import "JoinPhoneView.h"

@interface JoinPhoneView()
{
	NSTimer *_timer;
}
//秒数
@property (nonatomic,assign)NSInteger seconds;

@end

@implementation JoinPhoneView

-(instancetype)initWithFrame:(CGRect)frame
{
	self= [super initWithFrame:frame];
	if (self) {
		[self setUpUI];
	}
	return self;
}

-(void)setUpUI
{
	[self addSubview:self.phoneTitle]; //第一组
	[self addSubview:self.phoneTf];

	[self addSubview:self.codeTitle];
	[self addSubview:self.codeTf];
	[self addSubview:self.codeImgView];
	[self addSubview:self.codeBottomLable];


	[self addSubview:self.smsTitle];
	[self addSubview:self.smsTf];

	[self addSubview:self.smsButton];


	[_phoneTitle mas_makeConstraints:^(MASConstraintMaker *make) {
		make.left.mas_equalTo(px_scale(36));
		make.height.mas_equalTo(px_scale(40));
		make.top.mas_equalTo(px_scale(32));
	}];

	[_codeTitle mas_makeConstraints:^(MASConstraintMaker *make) {
		make.left.mas_equalTo(px_scale(36));
		make.height.mas_equalTo(px_scale(40));
		make.top.equalTo(self.phoneTitle.mas_bottom).offset(px_scale(60));
	}];

	[_smsTitle mas_makeConstraints:^(MASConstraintMaker *make) {
		make.left.mas_equalTo(px_scale(36));
		make.height.mas_equalTo(px_scale(40));
		make.top.equalTo(self.codeTitle.mas_bottom).offset(px_scale(98));
		make.bottom.equalTo(self.mas_bottom).offset(-px_scale(34));
	}];


	[_phoneTf mas_makeConstraints:^(MASConstraintMaker *make) {
		make.left.mas_equalTo(px_scale(232));
		make.centerY.equalTo(self.phoneTitle);
		make.height.mas_equalTo(px_scale(70));
		make.right.mas_equalTo(-px_scale(30));
	}];

	[_codeTf mas_makeConstraints:^(MASConstraintMaker *make) {
		make.left.mas_equalTo(px_scale(232));
		make.centerY.equalTo(self.codeTitle);
		make.height.mas_equalTo(px_scale(70));
		make.right.equalTo(self.codeImgView.mas_left).offset(px_scale(-10));
	}];

	[_smsTf mas_makeConstraints:^(MASConstraintMaker *make) {
		make.left.mas_equalTo(px_scale(232));
		make.centerY.equalTo(self.smsTitle);
		make.height.mas_equalTo(px_scale(70));
		make.right.equalTo(self.codeTf);
	}];

	[_codeImgView mas_makeConstraints:^(MASConstraintMaker *make) {
		make.top.mas_equalTo(px_scale(122));
		make.right.mas_equalTo(-px_scale(34));
		make.size.mas_equalTo((CGSize){px_scale(160),px_scale(66)});
	}];

	[_codeBottomLable mas_makeConstraints:^(MASConstraintMaker *make) {
		make.height.mas_equalTo(px_scale(33));
		make.centerX.equalTo(self.codeImgView);
		make.top.equalTo(self.codeImgView.mas_bottom).offset(px_scale(16));
		make.width.mas_equalTo(px_scale(175));
	}];

	[self.smsButton mas_makeConstraints:^(MASConstraintMaker *make) {
		make.right.mas_equalTo(0);
		make.height.mas_equalTo(px_scale(50));
		make.width.mas_equalTo(px_scale(188));
		make.centerY.equalTo(self.smsTitle);
	}];

	CGFloat line_tops[] = {px_scale(102),px_scale(249),px_scale(342)};
	for (int i = 0; i<3; i++) {
		CGFloat top = line_tops[i];
		UIView *line =[UIView new];
		line.backgroundColor =[UIColor colorWithHexString:@"#F1F1F1"];
		[self addSubview:line];
		[line mas_makeConstraints:^(MASConstraintMaker *make) {
			make.left.mas_equalTo(px_scale(30));
			make.right.mas_equalTo(-px_scale(30));
			make.height.mas_equalTo(0.8);
			make.top.mas_equalTo(top);
		}];
	}
}

#pragma mark - gertter

-(UILabel *)phoneTitle
{
	if (!_phoneTitle)
	 {
		_phoneTitle = [[UILabel alloc]init];
		_phoneTitle.font = [UIFont systemFontOfSize:14];
		_phoneTitle.attributedText = [self abs:@"手机号"];
	 }
	return _phoneTitle;
}
-(UILabel *)codeTitle
{
	if (!_codeTitle)
	 {
		_codeTitle = [[UILabel alloc]init];
		_codeTitle.font = [UIFont systemFontOfSize:14];
		_codeTitle.attributedText = [self abs:@"验证码"];
	 }
	return _codeTitle;
}

-(UILabel *)smsTitle
{
	if (!_smsTitle)
	 {
		_smsTitle = [[UILabel alloc]init];
		_smsTitle.font = [UIFont systemFontOfSize:14];
		_smsTitle.attributedText = [self abs:@"短信验证码"];
	 }
	return _smsTitle;
}

-(UITextField *)phoneTf
{
	if (!_phoneTf)
	 {
		_phoneTf = [[UITextField alloc]init];
		_phoneTf.placeholder = @"请填写手机号";
		_phoneTf.font = [UIFont systemFontOfSize:15];
		_phoneTf.textColor = [UIColor colorWithHexString:@"#333333"];
		_phoneTf.tag = PHONE_TAG;
		_phoneTf.keyboardType = UIKeyboardTypeNumberPad;
	 }
	return _phoneTf;
}

-(UITextField *)codeTf
{
	if (!_codeTf)
	 {
		_codeTf = [[UITextField alloc]init];
		_codeTf.placeholder = @"请输入验证码";
		_codeTf.font = [UIFont systemFontOfSize:15];
		_codeTf.textColor = [UIColor colorWithHexString:@"#333333"];
		_codeTf.tag = CODE_TAG;
		_codeTf.keyboardType = UIKeyboardTypeASCIICapable;
	 }
	return _codeTf;
}

-(UITextField *)smsTf
{
	if (!_smsTf)
	 {
		_smsTf = [[UITextField alloc]init];
		_smsTf.placeholder = @"请输入短信验证码";
		_smsTf.font = [UIFont systemFontOfSize:15];
		_smsTf.textColor = [UIColor colorWithHexString:@"#333333"];
		_smsTf.tag = SMS_TAG;
		_codeTf.keyboardType = UIKeyboardTypeASCIICapable;
	 }
	return _smsTf;
}

-(UIImageView *)codeImgView
{
	if (!_codeImgView)
	 {
		_codeImgView = [[UIImageView alloc]init];
		_codeImgView.layer.borderColor = [UIColor colorWithHexString:@"#DBDBDB"].CGColor;
		_codeImgView.layer.borderWidth = 0.8;
	 }
	return _codeImgView;
}

-(UIButton *)smsButton
{
	if (!_smsButton)
	 {
		_smsButton = [[UIButton alloc]init];
		[_smsButton setTitle:@"获取验证码" forState:UIControlStateNormal];
		[_smsButton setTitleColor:[UIColor colorWithHexString:@"#739EFC"] forState:UIControlStateNormal];
		_smsButton.titleLabel.font = [UIFont systemFontOfSize:12];
		[_smsButton addTarget:self action:@selector(smsClicked:) forControlEvents:UIControlEventTouchUpInside];
	 }
	return _smsButton;
}

-(UILabel *)codeBottomLable
{
	if (!_codeBottomLable)
	 {
		_codeBottomLable = [[UILabel alloc]init];
		_codeBottomLable.text = @"看不清，换一张";
		_codeBottomLable.font =[UIFont systemFontOfSize:12];
		_codeBottomLable.textColor = [UIColor colorWithHexString:@"#666666"];
		_codeBottomLable.userInteractionEnabled = YES;
		UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(ontap:)];
		[_codeBottomLable addGestureRecognizer:tap];
	 }
	return _codeBottomLable;
}

#pragma mark - private method
-(NSAttributedString *)abs:(NSString *)title
{
	NSString *str = [NSString stringWithFormat:@"%@ *",title];
	NSMutableAttributedString *abs = [[NSMutableAttributedString alloc]initWithString:str attributes:@{
																									   NSFontAttributeName:[UIFont systemFontOfSize:14],
																									   NSForegroundColorAttributeName:[UIColor colorWithHexString:@"#555555"]
																									   }];
	[abs setAttributes:@{
						 NSFontAttributeName:[UIFont systemFontOfSize:14],
						 NSForegroundColorAttributeName:[UIColor colorWithHexString:@"#D3141C"]
						 } range:(NSRange){(title.length +1),1}];
	return abs;
}


-(void)ontap:(UITapGestureRecognizer *)tap
{
	if (tap.state == UIGestureRecognizerStateEnded) {
		NSLog(@"点击切换图片");
		self.codeTf.text = @"";
		[[NSNotificationCenter defaultCenter]postNotificationName:UITextFieldTextDidChangeNotification object:self.codeTf];
	}
}

-(void)smsClicked:(id)sender
{
	
	[self startTimer];
	[self requstSMSCode];
}

-(void)requstSMSCode
{

}

-(void)startTimer
{
	self.smsButton.userInteractionEnabled = NO;
	[self endTimer];
	self.seconds = 61;
	NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(onTimer) userInfo:nil repeats:YES];
	_timer = timer;
	[timer fire];
	[[NSRunLoop mainRunLoop]addTimer:timer forMode:(NSRunLoopCommonModes)];
}

-(void)onTimer
{
	self.seconds --;
	if (_seconds == 0) {
		[self endTimer];
		NSString *text = @"获取验证码";
		[self.smsButton setTitle:text forState:UIControlStateNormal];
		self.smsButton.userInteractionEnabled = YES;
	}else{
		NSString *text = [NSString stringWithFormat:@"%lds",(long)self.seconds];
		[self.smsButton setTitle:text forState:UIControlStateNormal];
	}
}
-(void)endTimer
{
	if (_timer) {
		[_timer invalidate];
		_timer = nil;
	}
}

-(void)willMoveToSuperview:(UIView *)newSuperview
{
	if (!newSuperview) {
		[self endTimer];
	}
}

@end
