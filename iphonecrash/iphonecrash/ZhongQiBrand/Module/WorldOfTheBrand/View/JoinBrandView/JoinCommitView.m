//
//  JoinCommitView.m
//  ZhongQiBrand
//
//  Created by ios2 on 2019/10/21.
//  Copyright © 2019 CY. All rights reserved.
//

#import "JoinCommitView.h"

@implementation JoinCommitView

-(instancetype)initWithFrame:(CGRect)frame
{
	self =[super initWithFrame:frame];
	if (self) {
		self.backgroundColor =[UIColor whiteColor];
		[self setUpUI];
	}
	return self;
}

-(void)setUpUI
{
	[self addSubview:self.customserverButton];
	[self addSubview:self.commitButton];

	[_customserverButton mas_makeConstraints:^(MASConstraintMaker *make) {
		make.top.mas_equalTo(px_scale(75));
		make.left.mas_equalTo(px_scale(30));
		make.width.mas_equalTo(px_scale(210));
		make.height.mas_equalTo(px_scale(82));
	}];

	[_commitButton mas_makeConstraints:^(MASConstraintMaker *make) {
		make.top.mas_equalTo(px_scale(75));
		make.right.mas_equalTo(-px_scale(30));
		make.width.mas_equalTo(px_scale(415));
		make.height.mas_equalTo(px_scale(82));
	}];

}

-(UIButton *)commitButton
{
	if (!_commitButton)
	 {
		_commitButton = [[UIButton alloc]init];
		_commitButton.layer.cornerRadius = px_scale(41);
		_commitButton.backgroundColor = [UIColor colorWithHexString:@"#D3141C"];
		[_commitButton setTitle:@"提交" forState:UIControlStateNormal];
		_commitButton.clipsToBounds = YES;
		[_commitButton addTarget:self action:@selector(commitClicked:) forControlEvents:UIControlEventTouchUpInside];
	 }
	return _commitButton;
}
-(UIButton *)customserverButton
{
	if (!_customserverButton)
	 {
		_customserverButton = [[UIButton alloc]init];
		_customserverButton.layer.cornerRadius = px_scale(41);
		_customserverButton.clipsToBounds = YES;
		[_customserverButton addTarget:self action:@selector(customserverClicked:) forControlEvents:UIControlEventTouchUpInside];
		_customserverButton.backgroundColor = [UIColor colorWithHexString:@"#E2C87B"];
		[_customserverButton setTitle:@"客服" forState:UIControlStateNormal];
		[_customserverButton setImage:[UIImage imageNamed:@"icon"] forState:UIControlStateNormal];
		_customserverButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
		_customserverButton.titleEdgeInsets = UIEdgeInsetsMake(0, px_scale(57), 0,0);
		_customserverButton.imageEdgeInsets = UIEdgeInsetsMake(0, px_scale(50), 0, 0);
	 }
	return _customserverButton;
}


-(void)customserverClicked:(UIButton *)sender
{
	!_buttonOnClickedAction?:_buttonOnClickedAction(sender,0);
}

-(void)commitClicked:(UIButton *)sender
{
	!_buttonOnClickedAction?:_buttonOnClickedAction(sender,1);
}




@end
