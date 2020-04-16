//
//  FastVoteItemCell.m
//  ZhongQiBrand
//
//  Created by ios2 on 2019/9/17.
//  Copyright © 2019 CY. All rights reserved.
//

#import "FastVoteItemCell.h"
#import "HomeTimeManager.h"
#import "HomeResponse.h"
@interface FastVoteItemCell()<TimeRunProtocol>
@end
@implementation FastVoteItemCell
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
	[self.contentView addSubview:self.bgImageView];
	[self.contentView addSubview:self.industryLable];
	[self.contentView addSubview:self.tenBrandLable];
	[self.contentView addSubview:self.voteButton];

	[self.bgImageView mas_makeConstraints:^(MASConstraintMaker *make) {
		make.top.mas_equalTo(-px_scale(15));
		make.left.mas_equalTo(-px_scale(15));
		make.right.mas_equalTo(px_scale(15));
		make.bottom.mas_equalTo(px_scale(15));
	}];

	[_industryLable mas_makeConstraints:^(MASConstraintMaker *make) {
		make.top.mas_equalTo(px_scale(62-15));
		make.left.mas_equalTo(px_scale(53-15));
		make.height.mas_equalTo(px_scale(42));
		make.right.mas_equalTo(-px_scale(10));
	}];

	[_tenBrandLable mas_makeConstraints:^(MASConstraintMaker *make) {
		make.left.right.equalTo(self.industryLable);
		make.top.equalTo(self.industryLable.mas_bottom);
		make.height.mas_equalTo(px_scale(37));
	}];

	[self.voteButton mas_makeConstraints:^(MASConstraintMaker *make) {
		make.top.equalTo(self.tenBrandLable.mas_bottom).offset(px_scale(25));
		make.left.equalTo(self.tenBrandLable);
		make.size.mas_equalTo((CGSize){px_scale(124),px_scale(50)});
	}];

	[self configerIsCanVote:NO];

	[self.voteButton addTarget:self action:@selector(voteClicked:) forControlEvents:UIControlEventTouchUpInside];
//	__weak typeof(self)ws = self;
//	TimeRunBlock block = ^(void){
//		[ws onTimer]; 		//定时器调用
//	};
//	[HomeTimeManager addBlock:block andTarget:self];
	[HomeTimeManager addTimeRunObject:self];
}

-(void)setModel:(id)model
{
	_model = model;
	return;
	HomeVoteModel *voteModel  = _model;
	self.industryLable.text = voteModel.title;
	self.tenBrandLable.text = voteModel.show;
}

-(void)onTimer
{
	NSNumber *timeLine =  [[NSUserDefaults standardUserDefaults]valueForKey:@"last_voteTimeLine"];
	if (!timeLine) {
		[self configerIsCanVote:YES];
	}else{
		NSString *currentTimeLine =  [NSString spaceTimeLine];
		NSInteger voteSpace = ([timeLine integerValue] - [currentTimeLine integerValue]);
		if (voteSpace < 0) {
			[HomeTimeManager stopTime];
			[self configerIsCanVote:YES];
		}else{
			[self configerIsCanVote:NO];
			NSString *title = [NSString stringWithFormat:@"%lds",(long)(voteSpace<=0?(1):voteSpace)];
			[self.voteButton setTitle:title forState:UIControlStateNormal];
		}
	}
}
#pragma mark - target method
-(void)voteClicked:(UIButton *)button
{

}
#pragma mark - getter

-(UIImageView *)bgImageView {
	if (!_bgImageView) {
		_bgImageView = [[UIImageView alloc]init];
		_bgImageView.image =[UIImage imageNamed:@"xghy_dw_img"];
	 }
	return _bgImageView;
}
-(UILabel *)industryLable {
	if (!_industryLable) {
		_industryLable = [[UILabel alloc]init];
		_industryLable.textColor = [UIColor colorWithHexString:@"#333333"];
		_industryLable.font = [UIFont boldSystemFontOfSize:15];
		_industryLable.text = @"家居建材行业";
	 }
	return _industryLable;
}
-(UIButton *)voteButton {
	if (!_voteButton) {
		_voteButton = [[UIButton alloc]init];
		_voteButton.layer.cornerRadius = px_scale(25);
		_voteButton.clipsToBounds = YES;
		_voteButton.titleLabel.font = [UIFont systemFontOfSize:12];
	 }
	return _voteButton;
}

-(UILabel *)tenBrandLable {
	if (!_tenBrandLable) {
		_tenBrandLable = [[UILabel alloc]init];
		_tenBrandLable.textColor = [UIColor colorWithHexString:@"#333333"];
		_tenBrandLable.font =[UIFont systemFontOfSize:13];
		_tenBrandLable.text = @"2019年度十大品牌";
	 }
	return _tenBrandLable;
}

-(void)configerIsCanVote:(BOOL)isCanVote {
	if (isCanVote) {
		[self.voteButton setTitle:@"立即投票" forState:UIControlStateNormal];
		self.voteButton.backgroundColor = [UIColor colorWithHexString:@"#DD131C"];
		[self.voteButton setTitleColor:[UIColor colorWithHexString:@"#FFFFFF"] forState:UIControlStateNormal];
		self.voteButton.userInteractionEnabled = YES;
	}else{
		self.voteButton.backgroundColor = [UIColor colorWithHexString:@"#F2F2F2"];
		[self.voteButton setTitleColor:[UIColor colorWithHexString:@"#999999"] forState:UIControlStateNormal];
		self.voteButton.userInteractionEnabled = NO;
	}
}

-(void)dealloc
{
	[HomeTimeManager deleteBlock:self];
}
//协议
-(void)time_did_runprotocol
{
	[self onTimer];//协议方式进行调用
}


@end
