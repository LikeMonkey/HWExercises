//
//  HWFillAnswerView.h
//  HWExercises
//
//  Created by sxmaps_w on 2017/6/1.
//  Copyright © 2017年 wqb. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum {
    HWFillAnswerViewStyleFillsUp = 0,   //填空题
    HWFillAnswerViewStyleShortAnswer,   //简答题
} HWFillAnswerViewStyle;

@interface HWFillAnswerView : UIView

//题型样式
@property (nonatomic, assign, readonly) HWFillAnswerViewStyle style;

//填写的答案
@property (nonatomic, copy, readonly) NSString *fillAnswer;

//填写的答案角标
@property (nonatomic, copy, readonly) NSString *qrnum;

//刷新布局
- (void)reloadViewWithFrame:(CGRect)frame style:(HWFillAnswerViewStyle)style answerCount:(NSString *)answerCount userAnswers:(NSArray *)userAnswers;

@end
