//
//  HWAnalysisView.h
//  HWExercises
//
//  Created by sxmaps_w on 2017/6/1.
//  Copyright © 2017年 wqb. All rights reserved.
//

#import <UIKit/UIKit.h>

@class HWAnalysisView;

@protocol HWAnalysisViewDelegate <NSObject>

- (void)didClickAnaBtnInAnalysisView:(HWAnalysisView *)analysisView;

@end

@interface HWAnalysisView : UIView

//正确答案
@property (nonatomic, copy) NSString *trueAnswer;

//解析
@property (nonatomic, copy) NSString *analysisInfo;

//代理
@property (nonatomic, weak) id<HWAnalysisViewDelegate> delegate;

//根据回答结果显示解析视图
- (void)reloadViewWithUserResult:(NSString *)userResult showTFView:(BOOL)show;

//隐藏解析视图解析视图
- (void)dismissAnalysisInfo;

@end
