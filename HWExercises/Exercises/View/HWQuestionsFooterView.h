//
//  HWQuestionsFooterView.h
//  HWExercises
//
//  Created by sxmaps_w on 2017/6/1.
//  Copyright © 2017年 wqb. All rights reserved.
//

#import <UIKit/UIKit.h>

@class HWQuestionsFooterView;

@protocol HWQuestionsFooterViewDelegate <NSObject>

- (void)questionsFooterView:(HWQuestionsFooterView *)questionsFooterView didClickOptionButton:(BOOL)isNextButton;

@end

@interface HWQuestionsFooterView : UIView

@property (nonatomic, weak) id<HWQuestionsFooterViewDelegate> delegate;

@end
