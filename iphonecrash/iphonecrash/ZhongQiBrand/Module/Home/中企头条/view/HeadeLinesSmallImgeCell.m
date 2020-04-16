//
//  HeadeLinesSmallImgeCell.m
//  ZhongQiBrand
//
//  Created by ios2 on 2019/9/21.
//  Copyright © 2019 CY. All rights reserved.
//

#import "HeadeLinesSmallImgeCell.h"

@implementation HeadeLinesSmallImgeCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
//设置 视图的 约束  子类实现
-(void)setViewLayout
{
	[super setViewLayout];
	self.titleLable.numberOfLines = 2;
	[self.titleLable mas_makeConstraints:^(MASConstraintMaker *make) {
		make.height.mas_greaterThanOrEqualTo(10);
		make.left.mas_equalTo(px_scale(30));
		make.right.mas_equalTo(-px_scale(237));
		make.top.mas_equalTo(px_scale(20));
	}];

	[self.thumb mas_makeConstraints:^(MASConstraintMaker *make) {
		make.size.mas_equalTo(CGSizeMake(px_scale(184), px_scale(134)));
		make.right.mas_equalTo(-px_scale(30));
		make.top.mas_equalTo(px_scale(20));
		make.bottom.mas_equalTo(-px_scale(20));
	}];
}
@end
