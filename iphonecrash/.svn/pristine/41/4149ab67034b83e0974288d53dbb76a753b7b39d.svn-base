//
//  JoinBrandInputTableViewCell.m
//  ZhongQiBrand
//
//  Created by ios2 on 2019/10/21.
//  Copyright © 2019 CY. All rights reserved.
//

#import "JoinBrandInputTableViewCell.h"

@implementation JoinBrandInputTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
	self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
	if (self) {
		[self setUpUI];
	}
	return self;
}

-(void)setUpUI
{
	[self.contentView addSubview:self.titleLable];
	[self.contentView addSubview:self.inputFiled];

	[self.titleLable mas_makeConstraints:^(MASConstraintMaker *make) {
		make.left.mas_equalTo(px_scale(36));
		make.top.mas_equalTo(0);
		make.height.mas_equalTo(px_scale(100));
		make.bottom.equalTo(self.contentView.mas_bottom);
	}];

	[_inputFiled mas_makeConstraints:^(MASConstraintMaker *make) {
		make.left.mas_equalTo(px_scale(230));
		make.right.mas_equalTo(-px_scale(30));
		make.top.bottom.mas_equalTo(0);
	}];

	
	UIView *line = [UIView new];
	[self.contentView addSubview:line];
	line.backgroundColor = [UIColor colorWithHexString:@"#F1F1F1"];
	[line mas_makeConstraints:^(MASConstraintMaker *make) {
		make.left.mas_equalTo(px_scale(30));
		make.right.mas_equalTo(-px_scale(30));
		make.height.mas_equalTo(0.8);
		make.bottom.mas_equalTo(0);
	}];
}

#pragma mark - setter
-(void)setLeftTitle:(NSString *)leftTitle
{
	_leftTitle = leftTitle;
	NSString *str = [NSString stringWithFormat:@"%@ *",leftTitle];
	NSMutableAttributedString *abs = [[NSMutableAttributedString alloc]initWithString:str attributes:@{
																									   NSFontAttributeName:[UIFont systemFontOfSize:14],
																									   NSForegroundColorAttributeName:[UIColor colorWithHexString:@"#666666"]
																										  }];
	[abs setAttributes:@{
						 NSFontAttributeName:[UIFont systemFontOfSize:14],
						 NSForegroundColorAttributeName:[UIColor colorWithHexString:@"#D3141C"]
						 } range:(NSRange){(leftTitle.length +1),1}];
	self.titleLable.attributedText = abs;
	_inputFiled.placeholder = [NSString stringWithFormat:@"请输入%@",leftTitle];
}

#pragma mark - getter

-(UILabel *)titleLable {
	if (!_titleLable) {
		_titleLable = [[UILabel alloc]init];
		_titleLable.numberOfLines = 2;
		_titleLable.font = [UIFont systemFontOfSize:14];
		_titleLable.textColor = [UIColor colorWithHexString:@"#666666"];
	}
	return _titleLable;
}
-(UITextField *)inputFiled {
	if (!_inputFiled) {
		_inputFiled = [[UITextField alloc]init];
		_inputFiled.font = [UIFont systemFontOfSize:15];
		_inputFiled.textColor = [UIColor colorWithHexString:@"#666666"];
		_inputFiled.clearButtonMode = UITextFieldViewModeAlways;
	}
	return _inputFiled;
}

-(BOOL)becomeFirstResponder
{
	[super becomeFirstResponder];
	return [self.inputFiled becomeFirstResponder];
}


@end
