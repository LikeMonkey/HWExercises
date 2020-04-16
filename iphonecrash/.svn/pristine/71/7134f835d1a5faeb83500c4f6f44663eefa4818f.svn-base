//
//  JoinTextViewTableViewCell.m
//  ZhongQiBrand
//
//  Created by ios2 on 2019/10/21.
//  Copyright © 2019 CY. All rights reserved.
//

#import "JoinTextViewTableViewCell.h"

@interface JoinTextViewTableViewCell ()
@property (nonatomic,strong)UIView *bgView;
@property (nonatomic,strong)UILabel *textCountLable;
@end


@implementation JoinTextViewTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
	self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
	if (self) {
		[self setUpUI];
		[self registNotification];
	}
	return self;
}

-(void)registNotification
{
	[[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyBoardDidShowNotification:) name:UIKeyboardDidShowNotification object:nil];
}

-(void)keyBoardDidShowNotification:(NSNotification *)noti
{
	if (self.textView.isFirstResponder) {
		UITableView *tableView = [self tableView];
		if (tableView) {
       [tableView scrollToRowAtIndexPath:[tableView indexPathForCell:self] atScrollPosition:UITableViewScrollPositionBottom animated:YES];
		}
	}
}
-(UITableView *)tableView
{
	UIResponder *res = self;
	while (res.nextResponder&&(![res isKindOfClass:[UITableView class]])) {
		res = res.nextResponder;
		if ([res isKindOfClass: [UITableView class]]) {
			return (UITableView *)res;
		}
	}
	return nil;
}

-(void)setUpUI
{
	[self.contentView addSubview:self.titleLable];
	[self.contentView addSubview:self.textView];

	[self.contentView addSubview:self.bgView];
	[self.bgView addSubview:self.textView];
	[self.textView insertSubview:self.placeLable atIndex:0];
	[self.bgView addSubview:self.textCountLable];

	[self.titleLable mas_makeConstraints:^(MASConstraintMaker *make) {
		make.top.mas_equalTo(0);
		make.left.mas_equalTo(px_scale(36));
		make.height.mas_equalTo(px_scale(40));
	}];

	[self.bgView mas_makeConstraints:^(MASConstraintMaker *make) {
		make.left.mas_equalTo(px_scale(30));
		make.right.mas_equalTo(-px_scale(30));
		make.top.equalTo(self.titleLable.mas_bottom).offset(px_scale(10));
		make.height.mas_equalTo(px_scale(162));
		make.bottom.equalTo(self.contentView.mas_bottom).offset(px_scale(-30));
	}];


	//设置输入框的约束
	[self.textView mas_makeConstraints:^(MASConstraintMaker *make) {
		make.bottom.mas_equalTo(-px_scale(50));
		make.left.mas_equalTo(px_scale(10));
		make.top.mas_equalTo(px_scale(14));
		make.right.mas_equalTo(-px_scale(10));
	}];

	[self.placeLable mas_makeConstraints:^(MASConstraintMaker *make) {
		make.left.mas_equalTo(3.5);
		make.top.mas_equalTo(0);
		make.height.mas_equalTo(px_scale(40));
	}];

	[self.textCountLable mas_makeConstraints:^(MASConstraintMaker *make) {
		make.right.mas_equalTo(-px_scale(10));
		make.bottom.mas_equalTo(-px_scale(10));
		make.height.mas_equalTo(px_scale(40));
	}];
}

-(void)textViewDidChange:(UITextView *)textView
{
	NSInteger count = textView.text.length;
	if (count >0) {
		self.placeLable.hidden =YES;
	}else{
		self.placeLable.hidden = NO;
	}
	self.textCountLable.text = [NSString stringWithFormat:@"%@/800",@(count)];
	
	//向外部回调
	!_textViewDidChangeBlock?:_textViewDidChangeBlock(textView,self);
}

-(void)setTitleText:(NSString *)titleText
{
	_titleText = titleText;
	self.placeLable.text = [NSString stringWithFormat:@"请输入%@",titleText];
	self.titleLable.text = titleText;
}

#pragma mark Getter
-(UITextView *)textView {
	if (!_textView) {
		_textView = [[UITextView alloc]init];
		_textView.font = [UIFont systemFontOfSize:14];
		[_textView setTextContainerInset:UIEdgeInsetsZero];
		_textView.delegate = self;
		_textView.textColor = [UIColor colorWithHexString:@"#333333"];
		_textView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0];
	}
	return _textView;
}

-(UIView *)bgView
{
	if (!_bgView)
	 {
		_bgView = [[UIView alloc]init];
		_bgView.backgroundColor = [UIColor colorWithHexString:@"#FBFBFB"];
		_bgView.layer.borderColor = [UIColor colorWithHexString:@"#B2B2B2"].CGColor;
		_bgView.layer.borderWidth = 0.8;
		_bgView.layer.cornerRadius = px_scale(10);
	 }
	return _bgView;
}

-(UILabel *)titleLable {
	if (!_titleLable) {
		_titleLable = [[UILabel alloc]init];
		_titleLable.font = [UIFont systemFontOfSize:14];
		_titleLable.textColor = [UIColor colorWithHexString:@"#666666"];
	}
	return _titleLable;
}

-(UILabel *)placeLable {
	if (!_placeLable) {
		_placeLable = [[UILabel alloc]init];
		_placeLable.font = [UIFont systemFontOfSize:14];
		_placeLable.textColor = [UIColor colorWithHexString:@"#CCCCCC"];
		_placeLable.text = @"请输入......";
	}
	return _placeLable;
}

-(UILabel *)textCountLable
{
	if (!_textCountLable) {
		_textCountLable = [[UILabel alloc]init];
		_textCountLable.textAlignment = NSTextAlignmentRight;
		_textCountLable.textColor = [UIColor colorWithHexString:@"#CFCFCF"];
		_textCountLable.font = [UIFont systemFontOfSize:14];
		_textCountLable.text = @"0/800";
	 }
	return _textCountLable;
}

-(BOOL)becomeFirstResponder
{
	[super becomeFirstResponder];
	return [self.textView becomeFirstResponder];
}


@end
