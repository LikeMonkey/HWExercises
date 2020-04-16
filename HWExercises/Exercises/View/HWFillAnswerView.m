//
//  HWFillAnswerView.m
//  HWExercises
//
//  Created by sxmaps_w on 2017/6/1.
//  Copyright © 2017年 wqb. All rights reserved.
//

#import "HWFillAnswerView.h"
#import "HWFillAnswerCell.h"

@interface HWFillAnswerView ()<UITableViewDataSource>

@property (nonatomic, strong) NSMutableArray *array;
@property (nonatomic, weak) UITableView *tableView;
@property (nonatomic, copy, readwrite) NSString *fillAnswer;
@property (nonatomic, assign, readwrite) HWFillAnswerViewStyle style;
@property (nonatomic, assign) NSInteger answerCount;

@end

@implementation HWFillAnswerView

- (NSMutableArray *)array
{
    if (!_array) {
        _array = [NSMutableArray array];
    }
    
    return _array;
}

- (instancetype)init
{
    if (self = [super init]) {
        UITableView *tableView = [[UITableView alloc] init];
        tableView.dataSource = self;
        tableView.showsVerticalScrollIndicator = NO;
        tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [self addSubview:tableView];
        self.tableView = tableView;
    }
    
    return self;
}

- (void)reloadViewWithFrame:(CGRect)frame style:(HWFillAnswerViewStyle)style answerCount:(NSString *)answerCount userAnswers:(NSArray *)userAnswers
{
    self.style = style;
    self.answerCount = [answerCount integerValue] > 1 ? [answerCount integerValue] : 1;
    _fillAnswer = @"";
    _qrnum = @"";
    
    [_array removeAllObjects];
    for (int i = 0; i < _answerCount; i++) {
        [self.array addObject:@""];
    }
    
    if (userAnswers.count > 0) {
        _array = [userAnswers mutableCopy];
        _fillAnswer = [userAnswers componentsJoinedByString:@"|"];
        for (int i = 0; i < userAnswers.count; i++) {
            if ([_qrnum isEqualToString:@""]) {
                _qrnum = [NSString stringWithFormat:@"%d", i];
            }else {
                _qrnum = [_qrnum stringByAppendingString:[NSString stringWithFormat:@"|%d", i]];
            }
        }
    }
    
    [self creatControlWithFrame:frame];
}

- (void)creatControlWithFrame:(CGRect)frame
{
    _tableView.rowHeight = _style == HWFillAnswerViewStyleFillsUp ? 60 : 80;
    _tableView.frame = CGRectMake(10, 0, frame.size.width - 20, _tableView.rowHeight * _answerCount);
    frame.size.height = _tableView.frame.size.height;
    self.frame = frame;
    [_tableView reloadData];
}

- (void)setStyle:(HWFillAnswerViewStyle)style
{
    _style = style;
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _answerCount;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    HWFillAnswerCell *cell = [HWFillAnswerCell cellWithTableView:tableView];
    
    cell.textViewHieght = _style == HWFillAnswerViewStyleFillsUp ? 50 : 70;
    cell.placeHolder = _style == HWFillAnswerViewStyleFillsUp ? [NSString stringWithFormat:@"请填写第%ld个空白处的答案。", indexPath.row + 1] : @"请填写答案。";
    cell.answerStr = _array[indexPath.row];
    
    cell.answerEndEditing = ^(NSString *answerText) {
        if (_style == HWFillAnswerViewStyleFillsUp) {
            for (int i = 0; i < _answerCount; i++) {
                HWFillAnswerCell *anCell = [tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:i inSection:0]];
                if (i == 0) {
                    _fillAnswer = anCell.answerStr;
                    _qrnum = @"0";
                }else {
                    _fillAnswer = [_fillAnswer stringByAppendingString:[NSString stringWithFormat:@"|%@", anCell.answerStr]];
                    _qrnum = [_qrnum stringByAppendingString:[NSString stringWithFormat:@"|%d", i]];
                }
            }
            
        }else if (_style == HWFillAnswerViewStyleShortAnswer) {
            _fillAnswer = answerText;
            _qrnum = @"0";
        }
    };
    
    return cell;
}

@end
