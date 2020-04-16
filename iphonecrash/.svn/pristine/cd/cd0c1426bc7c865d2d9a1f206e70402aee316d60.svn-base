//
//  CycleTitleView.m
//  VoteCloud
//
//  Created by ios2 on 2019/8/27.
//  Copyright © 2019 CY. All rights reserved.
//

#import "CycleTitleView.h"
#import "MarqueeLabel.h"
@interface CycleTitleView()
@property (nonatomic,strong)MarqueeLabel *textLable;
@end
@implementation CycleTitleView


-(instancetype)init
{
	self = [super init];
	if (self) {
		[self setUpUI];
	}
	return self;
}

-(void)setUpUI
{
	//添加一个跑马灯View
	UIView *runBgView = [UIView new];
	runBgView.backgroundColor = [UIColor whiteColor];
	runBgView.layer.cornerRadius = px_scale(20);
	runBgView.layer.masksToBounds = YES;
	[self addSubview:runBgView];
	UIImageView *hornImgV = [UIImageView new];
	hornImgV.image = [UIImage imageNamed:@"tpy_lb_icon"];
	[runBgView addSubview:hornImgV];
	[hornImgV mas_makeConstraints:^(MASConstraintMaker *make) {
		make.left.mas_equalTo(px_scale(26));
		make.centerY.mas_equalTo(0);
		make.size.mas_equalTo((CGSize){px_scale(30),px_scale(30)});
	}];
	[runBgView mas_makeConstraints:^(MASConstraintMaker *make) {
		make.left.mas_equalTo(px_scale(0));
		make.right.mas_equalTo(-px_scale(0));
		make.top.mas_equalTo(0);
		make.bottom.mas_equalTo(0);
	}];
	_textLable = [[MarqueeLabel alloc]init];
	_textLable.font = [UIFont systemFontOfSize:12];
	_textLable.textAlignment = NSTextAlignmentLeft;
	_textLable.textColor = [UIColor colorWithHexString:@"#666666"];
	_textLable.marqueeType = MLContinuous;
	_textLable.scrollDuration = 20.0;
	_textLable.animationCurve = UIViewAnimationOptionCurveEaseInOut;
	_textLable.fadeLength = 0.0f;
    _textLable.leadingBuffer = 10.0f;
	_textLable.trailingBuffer = 20.0f;
    _textLable.adjustsFontSizeToFitWidth = YES;
    [_textLable triggerScrollStart];
	[runBgView addSubview:_textLable];
	[_textLable mas_makeConstraints:^(MASConstraintMaker *make) {
		make.left.equalTo(hornImgV.mas_right).mas_equalTo(px_scale(20));
		make.right.mas_equalTo(-px_scale(26));
		make.top.bottom.mas_equalTo(0);
	}];
}
#pragma mark - setter
-(void)setText:(NSString *)text
{
	_text = text;
    if (text.length > 0) {
        NSMutableString *newText = [[NSMutableString alloc] initWithString:text];
        NSDictionary *attributes = @{NSFontAttributeName:self.textLable.font};
        CGSize textSize = [newText boundingRectWithSize:CGSizeMake(CGFLOAT_MAX, self.textLable.height) options:NSStringDrawingTruncatesLastVisibleLine attributes:attributes context:nil].size;
        while (textSize.width < self.textLable.width) {
            [newText appendString:@" "];
            textSize = [newText boundingRectWithSize:CGSizeMake(CGFLOAT_MAX, self.textLable.height) options:NSStringDrawingTruncatesLastVisibleLine attributes:attributes context:nil].size;
        }
        self.textLable.text = [NSString stringWithFormat:@"%@", newText];
    }
}

@end
