//
//  HWFillAnswerCell.m
//  HWExercises
//
//  Created by sxmaps_w on 2017/6/1.
//  Copyright © 2017年 wqb. All rights reserved.
//

#import "HWFillAnswerCell.h"

@interface HWFillAnswerCell ()<UITextViewDelegate>

@property (nonatomic, weak) UITextView *textView;
@property (nonatomic, weak) UIView *paddView;;
@property (nonatomic, weak) UILabel *label;

@end

@implementation HWFillAnswerCell

+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *identifier = @"HWFillAnswerCell";
    HWFillAnswerCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[HWFillAnswerCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    return cell;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        //输入框
        UITextView *textView = [[UITextView alloc] init];
        textView.delegate = self;
        textView.layer.cornerRadius = 2.f;
        textView.layer.masksToBounds = YES;
        textView.layer.borderWidth = 1.f;
        textView.layer.borderColor = [KLineColor CGColor];
        textView.font = [UIFont systemFontOfSize:14.f];
        textView.backgroundColor = KWhiteColor;
        [self.contentView addSubview:textView];
        self.textView = textView;
        
        //默认提示标签
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(3, 6, 200, 20)];
        label.font = [UIFont systemFontOfSize:14.f];
        label.textColor = [UIColor colorWithHexString:@"#c8c8c8"];
        [textView addSubview:label];
        self.label = label;
        
        //间距
        UIView *paddView = [[UIView alloc] init];
        paddView.backgroundColor = KWhiteColor;
        [self.contentView addSubview:paddView];
        self.paddView = paddView;
    }
    
    return self;
}

- (void)setTextViewHieght:(CGFloat)textViewHieght
{
    _textViewHieght = textViewHieght;
    
    _textView.frame = CGRectMake(0, 0, KMainW - 20, textViewHieght);
    _paddView.frame = CGRectMake(0, CGRectGetMaxY(_textView.frame), _textView.bounds.size.width, 10);
}

- (void)setPlaceHolder:(NSString *)placeHolder
{
    _label.text = placeHolder;
}

- (void)textViewDidChange:(UITextView *)textView
{
    _label.hidden = [textView.text length] == 0 ? NO : YES;
}

- (void)textViewDidEndEditing:(UITextView *)textView
{
    _answerStr = textView.text;
    
    if (_answerEndEditing) _answerEndEditing(textView.text);
}

- (void)setAnswerStr:(NSString *)answerStr
{
    _answerStr = answerStr;
    
    _textView.text = answerStr;
    
    _label.hidden = answerStr.length > 0 ? YES : NO;
}

@end
