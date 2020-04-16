//
//  HWAnswerView.m
//  HWExercises
//
//  Created by sxmaps_w on 2017/6/1.
//  Copyright © 2017年 wqb. All rights reserved.
//

#import "HWAnswerView.h"

@interface HWAnswerView ()

@property (nonatomic, weak) UIView *view;
@property (nonatomic, assign, readwrite) HWAnswerViewStyle style;
@property (nonatomic, strong, readwrite) NSArray *answerArray;
@property (nonatomic, copy, readwrite) NSString *selectAnswer;
@property (nonatomic, copy, readwrite) NSString *qrnum;

@end

@implementation HWAnswerView

- (UIView *)view
{
    if (!_view) {
        UIView *view = [[UIView alloc] init];
        [self addSubview:view];
        _view = view;
    }
    
    return _view;
}

- (instancetype)init
{
    if (self = [super init]) {
        
    }
    
    return self;
}

- (void)reloadViewWithFrame:(CGRect)frame style:(HWAnswerViewStyle)style answerArray:(NSArray *)answerArray userAnswers:(NSArray *)userAnswers
{
    self.style = style;
    self.answerArray = answerArray;
    if (_style == HWAnswerViewStyleTrueOrFalse) self.answerArray = @[@"正确", @"错误"];
    
    _selectAnswer = @"";
    _qrnum = @"";
    
    if (userAnswers.count > 0) {
        _selectAnswer = [userAnswers componentsJoinedByString:@"|"];
        for (int i = 0; i < userAnswers.count; i++) {
            if ([_qrnum isEqualToString:@""]) {
                _qrnum = [NSString stringWithFormat:@"%d", [userAnswers[i] characterAtIndex:0] - 65];
            }else {
                _qrnum = [_qrnum stringByAppendingString:[NSString stringWithFormat:@"|%d", [userAnswers[i] characterAtIndex:0] - 65]];
            }
        }
    }
    
    [self removeView];
    [self creatControlWithFrame:frame];
}

- (void)creatControlWithFrame:(CGRect)frame
{
    CGFloat btnH = 25;
    CGFloat padding = 10.f;
    CGFloat labelY = 0;
    UIFont *font = [UIFont systemFontOfSize:14.f];
    
    for (int i = 0; i < _answerArray.count; i++) {
        //去回车、换行
        NSString *labelText = _answerArray[i];
        labelText = [labelText stringByReplacingOccurrencesOfString:@"\r" withString:@""];
        labelText = [labelText stringByReplacingOccurrencesOfString:@"\n" withString:@""];
        
        //内容高度
        CGFloat labelH = [HWToolBox sizeWithText:labelText font:font maxSize:CGSizeMake(KMainW - 50, MAXFLOAT)].height;
        
        //选项标签
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(btnH + 5, labelY + 4, KMainW - 50, labelH)];
        label.text = labelText;
        label.font = font;
        label.numberOfLines = 0;
        label.textColor = [UIColor colorWithHexString:@"#616161"];
        [self.view addSubview:label];
        
        labelY += MAX(labelH, btnH) + padding;
        
        //选项框
        UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(0, CGRectGetMinY(label.frame) - 4, btnH, btnH)];
        btn.tag = i + 100;
        btn.showsTouchWhenHighlighted = NO;
        [btn setImage:[UIImage imageNamed:@"exerc_answer_option_nor"] forState:UIControlStateNormal];
        [btn setImage:[UIImage imageNamed:@"exerc_answer_option_sel"] forState:UIControlStateSelected];
        [btn addTarget:self action:@selector(btnOnClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:btn];
        
        //标签点击区域
        UIButton *labelBtn = [[UIButton alloc] initWithFrame:label.frame];
        labelBtn.tag = i + 200;
        [labelBtn addTarget:self action:@selector(labelBtnOnClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:labelBtn];
        
        if ([_qrnum rangeOfString:[NSString stringWithFormat:@"%d", i]].location != NSNotFound) {
            btn.selected = YES;
            labelBtn.selected = YES;
        }
    }
    
    self.view.frame = CGRectMake(10, 0, KMainW - 20, labelY - padding);
    frame.size.height = labelY - padding;
    self.frame = frame;
}

- (void)btnOnClick:(UIButton *)btn
{
    [self selectOptionWithBtn:btn tag:100];
    
    [self setBtnSelectedWithTag:100];
}

- (void)labelBtnOnClick:(UIButton *)labelBtn
{
    [self selectOptionWithBtn:labelBtn tag:200];
    
    [self setBtnSelectedWithTag:200];
}

- (void)selectOptionWithBtn:(UIButton *)btn tag:(int)tag
{
    NSString *selStr = [NSString stringWithFormat:@"%c", (int)btn.tag - tag + 65];
    
    if (_style == HWAnswerViewStyleTrueOrFalse || _style == HWAnswerViewStyleSingleChoice) {
        _selectAnswer = selStr;
        _qrnum = [NSString stringWithFormat:@"%ld", btn.tag - tag];
        for (int i = 0; i < _answerArray.count; i++) {
            UIButton *btn = [self.view viewWithTag:i + tag];
            btn.selected = NO;
        }
        btn.selected = YES;
        
    }else if (_style == HWAnswerViewStyleMultipleChoice) {
        btn.selected = !btn.selected;
        _selectAnswer = @"";
        _qrnum = @"";
        for (int i = 0; i < _answerArray.count; i++) {
            UIButton *selBtn = [self.view viewWithTag:i + tag];
            if (selBtn.selected) {
                if ([_selectAnswer isEqualToString:@""]) {
                    _selectAnswer = [NSString stringWithFormat:@"%c", i + 65];
                    _qrnum = [NSString stringWithFormat:@"%d", i];
                }else {
                    _selectAnswer = [_selectAnswer stringByAppendingString:[NSString stringWithFormat:@"|%@", [NSString stringWithFormat:@"%c", i + 65]]];
                    _qrnum = [_qrnum stringByAppendingString:[NSString stringWithFormat:@"|%d", i]];
                }
            }
        }
    }
}

- (void)setBtnSelectedWithTag:(NSInteger)tag
{
    NSInteger otTag = tag == 100 ? 200 : 100;
    
    for (int i = 0; i < _answerArray.count; i++) {
        UIButton *btn = [self.view viewWithTag:i + tag];
        UIButton *otBtn = [self.view viewWithTag:i + otTag];
        otBtn.selected = btn.selected;
    }
}

- (void)removeView
{
    [self.view removeFromSuperview];
    self.view = nil;
}

- (void)setStyle:(HWAnswerViewStyle)style
{
    _style = style;
}

@end
