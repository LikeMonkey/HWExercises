//
//  HWQuestionsVC.m
//  HWExercises
//
//  Created by sxmaps_w on 2017/6/1.
//  Copyright © 2017年 wqb. All rights reserved.
//

#import "HWQuestionsVC.h"
#import "HWQuestionsModel.h"
#import "HWQuestionsFooterView.h"
#import "HWAnswerView.h"
#import "HWFillAnswerView.h"
#import "HWAnalysisView.h"

@interface HWQuestionsVC ()<HWAnalysisViewDelegate, HWQuestionsFooterViewDelegate>

@property (nonatomic, strong) NSMutableArray *questionsArray;
@property (nonatomic, strong) HWQuestionsModel *model;
@property (nonatomic, weak) UIScrollView *scrollView;
@property (nonatomic, weak) UILabel *questionlabel;
@property (nonatomic, weak) HWQuestionsFooterView *footerView;
@property (nonatomic, weak) HWAnswerView *answerView;
@property (nonatomic, weak) HWFillAnswerView *fillAnswerView;
@property (nonatomic, weak) HWAnalysisView *analysisView;
@property (nonatomic, assign) NSInteger page;
@property (nonatomic, assign) BOOL isCreatControl;

@end

@implementation HWQuestionsVC

- (NSMutableArray *)questionsArray
{
    if (!_questionsArray) {
        _questionsArray = [NSMutableArray array];
    }
    
    return _questionsArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    //设置导航栏标题并添加返回按钮
    [self addBackBtnAndTitle:@"答题页面"];
    
    //初始化页码
    _page = 1;
    
    //模拟题目数据（服务端数据库）
    [self setQuestionsArray];
    
    //获取题目信息，每次获取当前目标题目信息
    [self getQuestionsInfo];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    //保存做题记录
    [self saveProgress];
}

//模拟题目数据（服务端数据库）
- (void)setQuestionsArray
{
    NSArray *array = @[
                        @{@"questionid" : @"1000", @"totalCount" : @"5", @"question" : @"如果昨天是明天的话就好了，这样今天就周五了。真实的今天可能是星期几？", @"questiontype" : @"1", @"questiontype_text" : @"单选题", @"questionselectnumber" : @"3", @"questiondescribe" : @"星期三：理想今天是星期五，昨天是星期四，真实明天是理想的昨天是星期四，真实的今天是星期三。\n星期日：理想今天是星期五，明天是星期六，真实昨天是理想的明天是星期六，真实的今天是星期日。", @"trueanswer" : @"A", @"userAnswer" : @[], @"tkselect" : @[@"A：星期三", @"B：星期四", @"C：星期五"]},
                        @{@"questionid" : @"1001", @"totalCount" : @"5", @"question" : @"这里是问题，这道题的答案是AC。这里是问题，这道题的答案是AC。这里是问题，这道题的答案是AC。", @"questiontype" : @"2", @"questiontype_text" : @"多选题", @"questionselectnumber" : @"5", @"questiondescribe" : @"这里是答案解析，这里可以很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长的。", @"trueanswer" : @"AC", @"userAnswer" : @[], @"tkselect" : @[@"A：这个选项是正确的。这个选项是正确的。这个选项是正确的。", @"B：这个选项是错误的。这个选项是错误的。这个选项是错误的。", @"C：这个选项是正确的。这个选项是正确的。这个选项是正确的。", @"D：这个选项是错误的。这个选项是错误的。这个选项是错误的。", @"E：这个选项是错误的。这个选项是错误的。这个选项是错误的。"]},
                        @{@"questionid" : @"1002", @"totalCount" : @"5", @"question" : @"小明被老师赶出来后决定进入IT行业，日以继夜的学习C、C++...，通过不断的努力学习，小明成功入职快递公司成为一名优秀的快递员。小明的做法是正确的么？", @"questiontype" : @"3", @"questiontype_text" : @"判断题", @"questionselectnumber" : @"4", @"questiondescribe" : @"小明读了《从入门到放弃》这本书。", @"trueanswer" : @"A", @"userAnswer" : @[], @"tkselect" : @[]},
                        @{@"questionid" : @"1003", @"totalCount" : @"5", @"question" : @"既然选择了____________，便只顾____________。", @"questiontype" : @"4", @"questiontype_text" : @"填空题", @"questionselectnumber" : @"2", @"questiondescribe" : @"参考答案：既然选择了远方，便只顾风雨兼程。", @"trueanswer" : @"", @"userAnswer" : @[], @"tkselect" : @[]},
                        @{@"questionid" : @"1004", @"totalCount" : @"5", @"question" : @"在ARC环境下这段代码为什么不会崩溃？\n@property (nonatomic, weak) void(^block)();\n\n- (void)viewDidLoad {\n    [super viewDidLoad];\n\n    void(^ __weak blockA)() = ^{\n        NSLog(@“just a block”);\n    }\n\n    _block = blockA;\n};\n\n _block();", @"questiontype" : @"5", @"questiontype_text" : @"简答题", @"questionselectnumber" : @"1", @"questiondescribe" : @"ARC 下 block 没有捕获外部变量，block 代码被放在静态代码区，程序运行后，内存地址不变。", @"trueanswer" : @"", @"userAnswer" : @[], @"tkselect" : @[]}
                        ];
    
    self.questionsArray = [HWQuestionsModel mj_objectArrayWithKeyValuesArray:array];
}

//获取题目信息，每次获取当前目标题目信息
- (void)getQuestionsInfo
{
    //更新模型
    _model = _questionsArray[_page - 1];
    
    //创建控件
    if (!_isCreatControl) [self creatControl];
    
    //刷新视图
    [self reloadView];
}

//保存做题记录，做过的题由服务端存储，不需要进行本地持久化保存
- (void)saveProgress
{
    if (([_model.questiontype intValue] < 4 && ![_answerView.selectAnswer isEqualToString:@""]) || ([_model.questiontype intValue] > 3 && ![_fillAnswerView.fillAnswer isEqualToString:@""])) {
        
        NSString *qranswer = _answerView.hidden ? _fillAnswerView.fillAnswer : _answerView.selectAnswer;
        NSString *qrnum = _answerView.hidden ? _fillAnswerView.qrnum : _answerView.qrnum;
        HWLog(@"保存做题记录参数：\n试题id：%@\n页码：%ld\n填写的答案：%@\n填写的答案角标:%@", _model.questionid, _page, qranswer, qrnum);
        
        //提交服务端保存记录
        HWQuestionsModel *model = _questionsArray[_page - 1];
        [model.userAnswer removeAllObjects];
        model.userAnswer = [[qranswer componentsSeparatedByString:@"|"] mutableCopy];
    }
}

//创建控件
- (void)creatControl
{
    _isCreatControl = YES;
    
    //滚动视图
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, KMainW, KMainH - 113)];
    scrollView.showsVerticalScrollIndicator = NO;
    [self.view addSubview:scrollView];
    self.scrollView = scrollView;
    
    //问题标签
    UILabel *questionLabel = [[UILabel alloc] init];
    questionLabel.textColor = [UIColor colorWithHexString:@"#292929"];
    questionLabel.font = [UIFont systemFontOfSize:15.f];
    questionLabel.numberOfLines = 0;
    [scrollView addSubview:questionLabel];
    self.questionlabel = questionLabel;
    
    //答案选择视图，单选、多选、判断
    HWAnswerView *answerView = [[HWAnswerView alloc] init];
    [scrollView addSubview:answerView];
    self.answerView = answerView;
    
    //答案填写视图，填空、简答
    HWFillAnswerView *fillAnswerView = [[HWFillAnswerView alloc] init];
    [scrollView addSubview:fillAnswerView];
    self.fillAnswerView = fillAnswerView;
    
    //解析视图
    HWAnalysisView *analysisView = [[HWAnalysisView alloc] init];
    analysisView.delegate = self;
    [scrollView addSubview:analysisView];
    self.analysisView = analysisView;
    
    //底部视图
    HWQuestionsFooterView *footerView = [[HWQuestionsFooterView alloc] initWithFrame:CGRectMake(0, KMainH - 49 - 64, KMainW, 49)];
    footerView.delegate = self;
    [self.view addSubview:footerView];
    self.footerView = footerView;
    [self reloadFooterViewState];
}

//刷新布局
- (void)reloadView
{
    //刷新问题相关数据
    NSString *questionlabelText = [NSString stringWithFormat:@"（%@）%ld. %@", _model.questiontype_text, _page, _model.question];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineSpacing:4.0f];
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:questionlabelText];
    NSDictionary *attrs = [NSDictionary dictionaryWithObjectsAndKeys:kMainColor, NSForegroundColorAttributeName, nil];
    [attributedString setAttributes:attrs range:NSMakeRange(0, 5)];
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [questionlabelText length])];
    NSDictionary *dic = @{NSFontAttributeName:[UIFont systemFontOfSize:15.f], NSParagraphStyleAttributeName:paragraphStyle};
    CGFloat questionLabelH = [questionlabelText boundingRectWithSize:CGSizeMake(KMainW - 20, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:dic context:nil].size.height;
    _questionlabel.attributedText = attributedString;
    _questionlabel.frame = CGRectMake(10, 10, KMainW - 20, questionLabelH);
    
    //刷新答案相关数据
    if ([_model.questiontype intValue] < 4) {
        //答案选择视图，单选、多选、判断
        _answerView.hidden = NO;
        _fillAnswerView.hidden = YES;
        [_answerView reloadViewWithFrame:CGRectMake(0, CGRectGetMaxY(_questionlabel.frame) + 15, KMainW, 0) style:[_model.questiontype intValue] - 1 answerArray:_model.tkselect userAnswers:_model.userAnswer];
        
    }else {
        //答案填写视图，填空、简答
        _answerView.hidden = YES;
        _fillAnswerView.hidden = NO;
        [_fillAnswerView reloadViewWithFrame:CGRectMake(0, CGRectGetMaxY(_questionlabel.frame) + 15, KMainW, 0) style:[_model.questiontype intValue] - 4 answerCount:_model.questionselectnumber userAnswers:_model.userAnswer];
    }
    
    //刷新解析相关数据
    CGFloat analysisViewY = _answerView.hidden ? CGRectGetMaxY(_fillAnswerView.frame) + 10 : CGRectGetMaxY(_answerView.frame) + 20;
    _analysisView.frame = CGRectMake(0, analysisViewY, KMainW, 44);
    _analysisView.trueAnswer = _model.trueanswer;
    _analysisView.analysisInfo = _model.questiondescribe;
    [_analysisView dismissAnalysisInfo];
    
    //设置滚动区域内容
    _scrollView.contentSize = CGSizeMake(KMainW, analysisViewY + 44);
}

#pragma mark - SXQuestionsFooterViewDelegate
- (void)questionsFooterView:(HWQuestionsFooterView *)questionsFooterView didClickOptionButton:(BOOL)isNextButton
{
    //保存做题记录
    [self saveProgress];
    
    //更新页码
    isNextButton ? _page++ : _page--;
    
    //获取目标题目信息
    [self getQuestionsInfo];
    
    //刷新底部视图状态
    [self reloadFooterViewState];
}

//刷新底部视图状态
- (void)reloadFooterViewState
{
    UIButton *btn = (UIButton *)[self.footerView viewWithTag:500];
    btn.enabled = _page == 1 ? NO : YES;
    UIButton *otButton = (UIButton *)[self.footerView viewWithTag:501];
    otButton.enabled = _page == [_model.totalCount integerValue] ? NO : YES;
}

#pragma mark - SXAnalysisViewDelegate
- (void)didClickAnaBtnInAnalysisView:(HWAnalysisView *)analysisView
{
    [analysisView reloadViewWithUserResult:_answerView.selectAnswer showTFView:[_model.questiontype intValue] < 4];
    
    CGFloat temH = _answerView.hidden ? CGRectGetMaxY(_fillAnswerView.frame) + 10 : CGRectGetMaxY(_answerView.frame) + 20;
    
    _scrollView.contentSize = CGSizeMake(KMainW, temH + 10 + analysisView.bounds.size.height);
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}

@end
