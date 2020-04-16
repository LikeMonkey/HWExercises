//
//  HWQuestionsFooterView.m
//  HWExercises
//
//  Created by sxmaps_w on 2017/6/1.
//  Copyright © 2017年 wqb. All rights reserved.
//

#import "HWQuestionsFooterView.h"

@implementation HWQuestionsFooterView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        //上一题、下一题
        NSArray *titleArray = @[@"上一题", @"下一题"];
        for (int i = 0; i < titleArray.count; i++) {
            UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(KMainW * 0.5 * i, 0, KMainW * 0.5, 49)];
            btn.tag = i + 500;
            btn.backgroundColor = KWhiteColor;
            btn.titleLabel.font = [UIFont systemFontOfSize:15.f];
            [btn setTitle:titleArray[i] forState:UIControlStateNormal];
            [btn setBackgroundImage:[UIImage imageWithColor:KWhiteColor] forState:UIControlStateNormal];
            [btn setBackgroundImage:[UIImage imageWithColor:kMainColor] forState:UIControlStateHighlighted];
            [btn setTitleColor:kMainColor forState:UIControlStateNormal];
            [btn setTitleColor:KWhiteColor forState:UIControlStateHighlighted];
            [btn setTitleColor:[UIColor colorWithHexString:@"#999999"] forState:UIControlStateDisabled];
            [btn addTarget:self action:@selector(changeQuestionBtnOnClick:) forControlEvents:UIControlEventTouchUpInside];
            [self addSubview:btn];
        }
        
        //线
        for (int i = 0; i < 2; i++) {
            UIView *line = [[UIView alloc] initWithFrame:CGRectMake((KMainW - 1) * 0.5, 0, 1, self.bounds.size.height)];
            if (i == 1) line.frame = CGRectMake(0, 0, self.bounds.size.width, 1);
            line.backgroundColor = KLineColor;
            [self addSubview:line];
        }
    }
    
    return self;
}

- (void)changeQuestionBtnOnClick:(UIButton *)btn
{
    if (_delegate && [_delegate respondsToSelector:@selector(questionsFooterView:didClickOptionButton:)]) {
        [_delegate questionsFooterView:self didClickOptionButton:btn.tag == 501];
    }
}

@end
