//
//  HWQuestionsModel.h
//  HWExercises
//
//  Created by sxmaps_w on 2017/6/1.
//  Copyright © 2017年 wqb. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HWQuestionsModel : NSObject

//统计题数总量
@property (nonatomic, copy) NSString *totalCount;

//试题id
@property (nonatomic, copy) NSString *questionid;

//试题标题
@property (nonatomic, copy) NSString *question;

//题目类型（1单选题 2多选题 3判断题 4填空题 5简答题）
@property (nonatomic, copy) NSString *questiontype;

//题目类型文本（单选题、多选题、判断题、填空题、简答题）
@property (nonatomic, copy) NSString *questiontype_text;

//选项数量
@property (nonatomic, copy) NSString *questionselectnumber;

//用户填写的答案
@property (nonatomic, strong) NSMutableArray *userAnswer;

//答案选项
@property (nonatomic, strong) NSMutableArray *tkselect;

//正确答案（单选题、多选题、判断题）
@property (nonatomic, copy) NSString *trueanswer;

//答案分析
@property (nonatomic, copy) NSString *questiondescribe;

@end
