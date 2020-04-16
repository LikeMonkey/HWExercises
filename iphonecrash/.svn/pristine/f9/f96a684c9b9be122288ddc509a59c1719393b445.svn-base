//
//  HeadeLinesBigImgeCell.m
//  ZhongQiBrand
//
//  Created by ios2 on 2019/9/21.
//  Copyright © 2019 CY. All rights reserved.
//

#import "HeadeLinesBigImgeCell.h"

@implementation HeadeLinesBigImgeCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
-(void)setViewLayout
{
	[super setViewLayout];
	[self.titleLable mas_makeConstraints:^(MASConstraintMaker *make) {
		make.top.mas_equalTo(px_scale(30));
		make.left.mas_equalTo(px_scale(30));
		make.right.mas_equalTo(-px_scale(30));
		make.height.mas_equalTo(px_scale(42));
	}];

	[self.thumb mas_makeConstraints:^(MASConstraintMaker *make) {
		make.top.equalTo(self.titleLable.mas_bottom).offset(px_scale(26));
		make.left.mas_equalTo(px_scale(32));
		make.right.mas_equalTo(-px_scale(32));
		make.height.mas_equalTo(px_scale(268));
		make.bottom.equalTo(self.contentView.mas_bottom).offset(-px_scale(83));
	}];
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
