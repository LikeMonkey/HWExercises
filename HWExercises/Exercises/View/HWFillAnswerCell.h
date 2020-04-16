//
//  HWFillAnswerCell.h
//  HWExercises
//
//  Created by sxmaps_w on 2017/6/1.
//  Copyright © 2017年 wqb. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HWFillAnswerCell : UITableViewCell

//填写的文字
@property (nonatomic, copy) NSString *answerStr;

//默认提示文字
@property (nonatomic, copy) NSString *placeHolder;

//输入框高度
@property (nonatomic, assign) CGFloat textViewHieght;

//编辑完成时的回调
@property (nonatomic, copy) void(^answerEndEditing)(NSString *answerText);

+ (instancetype)cellWithTableView:(UITableView *)tableView;

@end
