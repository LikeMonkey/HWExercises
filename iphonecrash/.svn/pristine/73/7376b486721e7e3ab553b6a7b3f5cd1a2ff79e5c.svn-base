	//
	//  PlatformBottomView.m
	//  VoteCloud
	//
	//  Created by ios2 on 2019/11/6.
	//  Copyright © 2019 CY. All rights reserved.
	//

#import "PlatformBottomView.h"

@implementation PlatformBottomView{
	UILabel *_textLable;
}

-(instancetype)init
{
	self = [super init];
	if (self) {
		UILabel *textLable =[UILabel new];
		textLable.text = @"由共享投票（voteyun.com）提供技术支持"; //默认文字
		textLable.textAlignment = NSTextAlignmentCenter;
		textLable.font = [UIFont systemFontOfSize:13];
		textLable.textColor = [UIColor colorWithRed:0x66/255.0 green:0x66/255.0 blue:0x66/255.0 alpha:1];
		[self addSubview:textLable];
		_textLable = textLable;
		[textLable mas_makeConstraints:^(MASConstraintMaker *make) {
			make.left.right.top.bottom.mas_equalTo(0);
		}];
	}
	return self;
}
-(void)setTextFont:(UIFont *)textFont
{
	_textLable.font = textFont;
}
-(UIFont *)textFont
{
	return _textLable.font;
}
-(void)setTitle:(NSString *)title
{
	_textLable.text = title;
}
-(NSString *)title
{
	return _textLable.text;
}
-(void)setTextColor:(UIColor *)textColor
{
	_textLable.textColor = textColor;
}
-(UIColor *)textColor
{
	return _textLable.textColor;
}
-(void)changeFrame
{
	UIScrollView *scrollView =  (UIScrollView *)_bg_View;
	if (![scrollView isKindOfClass:[UIScrollView class]]) return;
	CGFloat maxY =  scrollView.contentSize.height;
	if (maxY >=(CGRectGetHeight(_bg_View.frame)-self.height)) {
		UIEdgeInsets edg = scrollView.contentInset;
		if (scrollView.mj_footer) {
			if (scrollView.mj_footer.hidden) {
				edg.bottom = (self.hidden)?0:self.height;
			}else{
				edg.bottom = scrollView.mj_footer.height + (self.hidden?0:self.height);
			}
		}else{
			edg.bottom = self.height;
		}
		scrollView.contentInset = edg;
		self.y = maxY + edg.bottom - self.height;
	}else{
		UIEdgeInsets edg = scrollView.contentInset;
		edg.bottom = 0;
		scrollView.contentInset = edg;
		if (self.isNotBottom) {
			if (scrollView.mj_footer&&(!scrollView.mj_footer.hidden)) {
				self.y = scrollView.mj_footer.height + maxY;
			}else{
				self.y = maxY;
			}
		}else{
			self.y = CGRectGetHeight(_bg_View.frame) - self.height;
		}
	}
}

-(void)setHidden:(BOOL)hidden
{
	[super setHidden:hidden];
	if ([self.superview isKindOfClass:[UIScrollView class]]) return;
	[self changeFrame];//修改位置
}

@end
