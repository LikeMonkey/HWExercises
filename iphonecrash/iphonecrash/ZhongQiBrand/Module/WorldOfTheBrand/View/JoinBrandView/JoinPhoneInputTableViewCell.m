//
//  JoinPhoneInputTableViewCell.m
//  ZhongQiBrand
//
//  Created by ios2 on 2019/10/21.
//  Copyright © 2019 CY. All rights reserved.
//

#import "JoinPhoneInputTableViewCell.h"
#import "JoinTopView.h"
#import "JoinPhoneView.h"

@implementation JoinPhoneInputTableViewCell{
	JoinPhoneView *_phoneView;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}


-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
	self =[super initWithStyle:style reuseIdentifier:reuseIdentifier];
	if (self) {
		[self setupUI];
	}
	return self;
}

-(void)setupUI
{
	JoinTopView *topView =[[JoinTopView alloc]initWithFrame:CGRectZero];
	topView.titleLable.text = @"身份验证";
	[self.contentView addSubview:topView];
	[topView  mas_makeConstraints:^(MASConstraintMaker *make) {
		make.top.mas_equalTo(px_scale(20));
		make.left.right.mas_equalTo(0);
		make.height.mas_equalTo(px_scale(77));
	}];

	JoinPhoneView *phoneView =[[JoinPhoneView alloc]initWithFrame:CGRectZero];
	[self.contentView addSubview:phoneView];
	_phoneView = phoneView;
	
	[phoneView mas_makeConstraints:^(MASConstraintMaker *make) {
		make.left.right.mas_equalTo(0);
		make.top.equalTo(topView.mas_bottom);
		make.bottom.equalTo(self.contentView.mas_bottom);
	}];
	phoneView.phoneTf.delegate = self;
	phoneView.codeTf.delegate = self;
	phoneView.smsTf.delegate = self;

	UIView *spaceView = [UIView new];
	[self.contentView addSubview:spaceView];
	spaceView.backgroundColor = [UIColor colorWithHexString:@"#F6F6F6"];
	[spaceView mas_makeConstraints:^(MASConstraintMaker *make) {
		make.left.right.top.mas_equalTo(0);
		make.bottom.equalTo(topView.mas_top);
	}];

}


//代理协议
-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
	if (_shouldEditeCheck) {
		return  _shouldEditeCheck();
	}
	return YES;
}

-(BOOL)becomeFirstResponder
{
	if (NullString(_phoneView.phoneTf.text)) {
		return [_phoneView.phoneTf becomeFirstResponder];
	}
	if (NullString(_phoneView.codeTf.text)) {
		return [_phoneView.codeTf becomeFirstResponder];
	}
	if (NullString(_phoneView.smsTf.text)) {
		return [_phoneView.smsTf becomeFirstResponder];
	}
	return YES;
}

#pragma mark - publick method
-(void)configerWithDic:(NSDictionary *)brandDic
{
	_phoneView.phoneTf.text = brandDic[@"3210"];
	_phoneView.codeTf.text = brandDic[@"3211"];
	_phoneView.smsTf.text = brandDic[@"3212"];
}
@end
