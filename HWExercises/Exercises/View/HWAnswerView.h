//
//  HWAnswerView.h
//  HWExercises
//
//  Created by sxmaps_w on 2017/6/1.
//  Copyright © 2017年 wqb. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum {
    HWAnswerViewStyleSingleChoice = 0,  //单选题
    HWAnswerViewStyleMultipleChoice,    //多选题
    HWAnswerViewStyleTrueOrFalse,       //判断题
} HWAnswerViewStyle;

@interface HWAnswerView : UIView

//答案样式
@property (nonatomic, assign, readonly) HWAnswerViewStyle style;

//答案数组
@property (nonatomic, strong, readonly) NSArray *answerArray;

//选中答案
@property (nonatomic, copy, readonly) NSString *selectAnswer;

//选中答案角标
@property (nonatomic, copy, readonly) NSString *qrnum;

//刷新布局
- (void)reloadViewWithFrame:(CGRect)frame style:(HWAnswerViewStyle)style answerArray:(NSArray *)answerArray userAnswers:(NSArray *)userAnswers;

@end
