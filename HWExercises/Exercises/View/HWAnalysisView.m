//
//  HWAnalysisView.m
//  HWExercises
//
//  Created by sxmaps_w on 2017/6/1.
//  Copyright © 2017年 wqb. All rights reserved.
//

#import "HWAnalysisView.h"

@interface HWAnalysisView ()

@property (nonatomic, weak) UIImageView *tfView;
@property (nonatomic, weak) UIView *anaView;
@property (nonatomic, weak) UILabel *trueAnswerLabel;
@property (nonatomic, weak) UILabel *anaInfoLabel;

@end

@implementation HWAnalysisView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        //解析按钮
        UIButton *anaBtn = [[UIButton alloc] initWithFrame:CGRectMake(KMainW - 80, 0, 80, 44)];
        [anaBtn setImage:[UIImage imageNamed:@"exerc_analysisView_anaBtn"] forState:UIControlStateNormal];
        [anaBtn addTarget:self action:@selector(anaBtnOnClick) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:anaBtn];
        
        //正误标识图
        UIImageView *tfView = [[UIImageView alloc] initWithFrame:CGRectMake(KMainW - 115, 0, 44, 44)];
        tfView.hidden = YES;
        tfView.contentMode = UIViewContentModeCenter;
        [self addSubview:tfView];
        self.tfView = tfView;
        
        //答案解析视图
        UIView *anaView = [[UIView alloc] init];
        anaView.hidden = YES;
        [self addSubview:anaView];
        self.anaView = anaView;
        
        //线
        UIView *line = [[UIView alloc] initWithFrame:CGRectMake(10, 0, KMainW - 20, 0.5)];
        line.backgroundColor = KLineColor;
        [anaView addSubview:line];
        
        //解析标签
        UILabel *anaLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 15, 48, 15)];
        anaLabel.text = @"解析：";
        anaLabel.textColor = [UIColor colorWithHexString:@"#080103"];
        anaLabel.font = [UIFont systemFontOfSize:15.f];
        [anaView addSubview:anaLabel];
        
        //正确答案
        UILabel *trueAnswerLabel = [[UILabel alloc] init];
        trueAnswerLabel.textColor = [UIColor colorWithHexString:@"#297ce3"];
        trueAnswerLabel.font = [UIFont systemFontOfSize:14.f];
        trueAnswerLabel.numberOfLines = 0;
        [anaView addSubview:trueAnswerLabel];
        self.trueAnswerLabel = trueAnswerLabel;
        
        //解析信息
        UILabel *anaInfoLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(anaLabel.frame), CGRectGetMaxY(trueAnswerLabel.frame) + 10, KMainW - 25, 50)];
        anaInfoLabel.textColor = [UIColor colorWithHexString:@"#616161"];
        anaInfoLabel.font = [UIFont systemFontOfSize:14.f];
        anaInfoLabel.numberOfLines = 0;
        [anaView addSubview:anaInfoLabel];
        self.anaInfoLabel = anaInfoLabel;
    }
    
    return self;
}

- (void)anaBtnOnClick
{
    if (_delegate && [_delegate respondsToSelector:@selector(didClickAnaBtnInAnalysisView:)]) {
        [_delegate didClickAnaBtnInAnalysisView:self];
    }
}

- (void)setTrueAnswer:(NSString *)trueAnswer
{
    _trueAnswer = trueAnswer;
}

- (void)setAnalysisInfo:(NSString *)analysisInfo
{
    _analysisInfo = analysisInfo;
}

- (void)reloadViewWithUserResult:(NSString *)userResult showTFView:(BOOL)show
{
    //正确、错误提示图片
    _tfView.hidden = !show;
    NSString *uR = [userResult stringByReplacingOccurrencesOfString:@"|" withString:@""];
    _tfView.image = [_trueAnswer isEqualToString:uR] ? [UIImage imageNamed:@"exerc_analysisView_right"] : [UIImage imageNamed:@"exerc_analysisView_fause"];
    
    //解析标签配置
    CGFloat labelW = KMainW - 68;
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineSpacing:4.0f];
    NSDictionary *dic = @{NSFontAttributeName:[UIFont systemFontOfSize:14.f], NSParagraphStyleAttributeName:paragraphStyle};
    
    //刷新正确答案标签
    NSString *trueAnswerLabelText = [NSString stringWithFormat:@"正确答案：%@", _trueAnswer];
    NSMutableAttributedString *trueAnswerLabelAttributedString = [[NSMutableAttributedString alloc] initWithString:trueAnswerLabelText];
    [trueAnswerLabelAttributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [trueAnswerLabelText length])];
    CGFloat trueAnswerLabelH = [trueAnswerLabelText boundingRectWithSize:CGSizeMake(labelW, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:dic context:nil].size.height;
    _trueAnswerLabel.attributedText = trueAnswerLabelAttributedString;
    _trueAnswerLabel.frame = CGRectMake(58, 15, labelW, trueAnswerLabelH);
    
    //刷新解析详情标签
    NSMutableAttributedString *anaInfoLabelAttributedString = [[NSMutableAttributedString alloc] initWithString:_analysisInfo];
    [anaInfoLabelAttributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [_analysisInfo length])];
    CGFloat anaInfoLabelH = [_analysisInfo boundingRectWithSize:CGSizeMake(labelW, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:dic context:nil].size.height;
    _anaInfoLabel.attributedText = anaInfoLabelAttributedString;
    _anaInfoLabel.frame = CGRectMake(58, CGRectGetMaxY(_trueAnswerLabel.frame) + 10, labelW, anaInfoLabelH);
    
    //刷新视图区域
    _anaView.hidden = NO;
    _anaView.frame = CGRectMake(0, 44, KMainW, 15 + trueAnswerLabelH + 10 + anaInfoLabelH);
    
    //改变自身区域
    CGRect frame = self.frame;
    frame.size.height = 44 + _anaView.bounds.size.height;
    self.frame = frame;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [[HWToolBox findViewController:self].view endEditing:YES];
}

- (void)dismissAnalysisInfo
{
    _tfView.hidden = YES;
    _anaView.hidden = YES;
    
    CGRect frame = self.frame;
    frame.size.height = 44;
    self.frame = frame;
}

@end
