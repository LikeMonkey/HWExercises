//
//  PPVersonAleteView.m
//  PPWBrand
//
//  Created by ios2 on 2019/5/6.
//  Copyright © 2019 ShanZhou. All rights reserved.
//

#import "PPVersonAleteView.h"

@implementation PPVersonAleteView {
	NSMutableArray *argsArray;
	BOOL hasCancelBtn;
	UIView *_containtView;
	NSString *_detail;
	NSString *_title;
	__weak id <AlertDelegate> _delegate;
}
- (instancetype)initWithTitle:(NSString *)title
					  message:(NSString *)message
					 delegate:(id /*<AlertDelegate>*/)delegate
			cancelButtonTitle:(NSString *)cancelButtonTitle
			otherButtonTitles:(NSString *)otherButtonTitles, ...NS_REQUIRES_NIL_TERMINATION {
	self = [super init];
	if(self){
		_title = title;
		argsArray = [[NSMutableArray alloc] init];
		hasCancelBtn = NO;
		_detail = message;
		_delegate = delegate;
		if (cancelButtonTitle) {
			hasCancelBtn = YES;
			[argsArray insertObject:cancelButtonTitle atIndex:0];
		}
		va_list params; //定义一个指向个数可变的参数列表指针;
		va_start(params,otherButtonTitles);//va_start 得到第一个可变参数地址,
		id arg;
		if (otherButtonTitles) {
				//将第一个参数添加到array
			id prev = otherButtonTitles;
			[argsArray addObject:prev];
				//va_arg 指向下一个参数地址
				//这里是问题的所在 网上的例子，没有保存第一个参数地址，后边循环，指针将不会在指向第一个参数
			while( (arg = va_arg(params,id)) ){
				if ( arg ){
					[argsArray addObject:arg];
				}
			}
		   //置空
			va_end(params);
		}
	}
	self.frame = [UIScreen mainScreen].bounds;
	[[[UIApplication sharedApplication].delegate window] addSubview:self];
	[self setUpUI];
	return self;
}

-(void)setUpUI
{
	UIView *bgImgV = [UIView new];
	bgImgV.backgroundColor = [[UIColor blackColor]colorWithAlphaComponent:0.4];
	[self addSubview:bgImgV];
	[bgImgV mas_makeConstraints:^(MASConstraintMaker *make) {
		make.edges.mas_equalTo(UIEdgeInsetsZero);
	}];
	_containtView = [UIView new];
	_containtView.backgroundColor =[UIColor whiteColor];
	_containtView.layer.cornerRadius = px_scale(10);
	_containtView.layer.masksToBounds = YES;
	[self addSubview:_containtView];
	UILabel *titleLable;
	UIView *lastView;

	UIImageView *topImgView = [UIImageView new];
	topImgView.image = [UIImage imageNamed:@"gengxin_tanc_img"];
	[self addSubview:topImgView];
	[topImgView mas_makeConstraints:^(MASConstraintMaker *make) {
		make.top.equalTo(self->_containtView.mas_top).offset(px_scale(-48));
		make.left.right.equalTo(self->_containtView);
		make.height.mas_offset(px_scale(210));
	}];
	titleLable = [UILabel new];
	titleLable.text = _title?_title:@"更新说明";
	[_containtView addSubview:titleLable];
	titleLable.textColor = [UIColor colorWithHexString:@"#333333"];
	titleLable.font =[UIFont boldSystemFontOfSize:17];
	titleLable.textAlignment = NSTextAlignmentCenter;
	[titleLable mas_makeConstraints:^(MASConstraintMaker *make) {
		make.top.mas_equalTo(px_scale(210-42+20));
		make.left.right.mas_equalTo(0);
	}];
	UILabel *desTitle = [UILabel new];
	desTitle.numberOfLines = 0;
	desTitle.textColor = [UIColor colorWithHexString:@"#333333"];
	desTitle.font= [UIFont systemFontOfSize:14];
	desTitle.textAlignment = NSTextAlignmentLeft;
	[_containtView addSubview:desTitle];
	NSMutableParagraphStyle *  paragraphStyle = [[NSMutableParagraphStyle alloc]init];
	paragraphStyle.lineSpacing = px_scale(4);
	NSMutableAttributedString *abs = [[NSMutableAttributedString alloc]initWithString:_detail attributes:@{NSParagraphStyleAttributeName:paragraphStyle}];
	desTitle.attributedText = abs;
	CGFloat height  = [desTitle sizeThatFits:CGSizeMake(px_scale(520 - 60), CGFLOAT_MAX)].height;
	[desTitle mas_makeConstraints:^(MASConstraintMaker *make) {
		make.height.mas_equalTo(height);
		make.left.mas_equalTo(px_scale(30));
		make.right.mas_equalTo(px_scale(-30));
		if (titleLable) {
			make.top.equalTo(titleLable.mas_bottom).offset(px_scale(44));
		}else{
			make.top.mas_equalTo(px_scale(44));
		}
	}];

	UIView *bottomView =[UIView new];
	bottomView.backgroundColor =[UIColor colorWithHexString:@"#E9E9E9"];
	[_containtView addSubview:bottomView];
	NSInteger actionCount = [argsArray count];
	[bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
		if (actionCount == 0||actionCount<3) {
			make.height.mas_equalTo(px_scale(90));
		}else{
			make.height.mas_equalTo(px_scale(90)*actionCount);
		}
		make.left.right.mas_equalTo(0);
		make.top.equalTo(desTitle.mas_bottom).offset(px_scale(60));
	}];
	UIButton *lastBtn;
	for (int i = 0; i< actionCount; i++) {
		UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
		btn.backgroundColor  = [UIColor whiteColor];
		[btn addTarget:self action:@selector(actionClicked:) forControlEvents:UIControlEventTouchUpInside];
		btn.tag = 100 + i;
		[btn setTitleColor:ThemeColor forState:UIControlStateNormal];
		[btn setTitle:argsArray[i] forState:UIControlStateNormal];
		btn.titleLabel.font = [UIFont systemFontOfSize:15];
		[bottomView addSubview:btn];
		if (hasCancelBtn) {
			if (i == 0) {
				[btn setTitleColor:[UIColor colorWithHexString:@"#333333"] forState:UIControlStateNormal];
			}
		}
		[btn setTitle:argsArray[i] forState:UIControlStateNormal];
		if (actionCount !=2) {
			[btn mas_makeConstraints:^(MASConstraintMaker *make) {
				if (!lastBtn) {
					make.top.mas_equalTo(px_scale(1));
				}else{
					make.top.equalTo(lastBtn.mas_bottom).offset(1);
				}
				make.left.right.mas_equalTo(0);
				make.height.mas_equalTo(px_scale(90-1));
			}];
		}else{
			[btn mas_makeConstraints:^(MASConstraintMaker *make) {
				make.top.mas_equalTo(px_scale(1));
				if (lastBtn) {
					make.left.equalTo(lastBtn.mas_right).offset(px_scale(0.5));
					make.right.mas_equalTo(0);
				}else{
					make.left.mas_equalTo(0);
					make.right.equalTo(self->_containtView.mas_centerX).offset(-px_scale(0.5));
				}
				make.bottom.mas_equalTo(0);
			}];
		}
		lastBtn = btn;
	}

	lastView = bottomView;

	[_containtView mas_makeConstraints:^(MASConstraintMaker *make) {
		make.width.mas_equalTo(px_scale(520));
		make.centerX.mas_equalTo(0);
		make.centerY.mas_equalTo(0);
		make.bottom.equalTo(lastView.mas_bottom);
	}];
}

-(void)actionClicked:(UIButton *)button
{
	if (_delegate) {
		if ([_delegate respondsToSelector:@selector(alertView:clickedButtonAtIndex:)]) {
			[_delegate alertView:self clickedButtonAtIndex:button.tag - 100];
		}
	}
	if (_canDismiss) {
		[self removeFromSuperview];
	}
}



@end
