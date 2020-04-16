//
//  JoinActivityTableViewCell.m
//  ZhongQiBrand
//
//  Created by iOS002 on 2019/10/21.
//  Copyright © 2019 CY. All rights reserved.
//

#import "JoinActivityTableViewCell.h"


@interface JoinActivityTableViewCell()
@property (nonatomic, strong) UILabel *titleShowLabel;
@property (nonatomic, strong) UITextField *contentTextField;
@property (nonatomic, strong) UIView *lineView;
@property (nonatomic, strong) JKCountDownButton *countDownBtn;
@property (nonatomic, strong) UIImageView *showCodeView;
@property (nonatomic, strong) UIButton *noClearBtn;

@end


@implementation JoinActivityTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self layoutJoinActivityTableViewCell];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textFieldContentChange:) name:UITextFieldTextDidChangeNotification object:nil];
    }
    return self;
}

- (void)textFieldContentChange:(NSNotification *)notification
{
    UITextField *textField = (UITextField *)notification.object;
    self.showModel.textFieldStr = textField.text;
}

- (void)countDownBtnClick:(JKCountDownButton *)btn{
    if (self.clickGetSMSCodeBlock) {
        self.clickGetSMSCodeBlock(btn);
    }
}
- (void)clickRefreshCodeAction
{
    if (self.clickRefreshImageCodeBlock) {
        self.clickRefreshImageCodeBlock();
    }
    
}
- (void)setShowModel:(JoinActivityShowModel *)showModel
{
    _showModel = showModel;
    NSString *titleShowStr = [NSString stringWithFormat:@"%@ *",showModel.title];
    NSMutableAttributedString *attributeStr = [[NSMutableAttributedString alloc] initWithString:titleShowStr];
    [attributeStr addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithHexString:@"#D3141C"]range:NSMakeRange(titleShowStr.length - 1,1)];
    self.titleShowLabel.attributedText = attributeStr;
    self.contentTextField.placeholder = showModel.placeholder;
    self.contentTextField.text = showModel.textFieldStr;
    self.countDownBtn.hidden = [showModel.title isEqualToString:@"短信验证码"] ? NO: YES;
    self.showCodeView.hidden = self.noClearBtn.hidden = [showModel.title isEqualToString:@"验证码"] ? NO: YES;
}

- (void)layoutJoinActivityTableViewCell
{
    [self.contentView addSubview:self.titleShowLabel];
    [self.titleShowLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.contentView.mas_top).offset(px_scale(32));
        make.left.mas_equalTo(self.contentView.mas_left).offset(px_scale(36));
        make.height.mas_greaterThanOrEqualTo(0);
        make.width.mas_lessThanOrEqualTo(px_scale(200));
    }];
    
    [self.contentView addSubview:self.contentTextField];
    [self.contentTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.titleShowLabel.mas_centerY);
        make.left.mas_equalTo(self.contentView.mas_left).offset(px_scale(232));
        make.right.mas_equalTo(self.contentView.mas_right).offset(-px_scale(200));
        make.height.equalTo(@(px_scale(42)));
    }];
    
    [self.contentView addSubview:self.lineView];
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.bottom.equalTo(self.contentView);
        make.height.equalTo(@(1));
       
        make.left.mas_equalTo(self.contentView.mas_left).offset(px_scale(30));
        make.right.mas_equalTo(self.contentView.mas_right).offset(-px_scale(30));
        
    }];
    
    [self.contentView addSubview:self.countDownBtn];
    [self.countDownBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_offset(-px_scale(71));
        make.centerY.equalTo(self.titleShowLabel.mas_centerY);
        make.height.mas_offset(40);
    }];
    
    [self.contentView addSubview:self.showCodeView];
    [self.showCodeView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.contentView.mas_top).offset(px_scale(20));
        make.right.mas_equalTo(self.contentView.mas_right).offset(-px_scale(36));
        make.width.equalTo(@(px_scale(160)));
        make.height.equalTo(@(px_scale(66)));
    }];
    
    [self.contentView addSubview:self.noClearBtn];
    [self.noClearBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.showCodeView.mas_bottom).offset(px_scale(16));
        make.right.mas_equalTo(self.showCodeView.mas_right);
        make.bottom.mas_equalTo(self.mas_bottom).offset(-px_scale(12));
    }];
    
}

-(UILabel *)titleShowLabel{
    
    if (!_titleShowLabel) {
        _titleShowLabel = [UILabel new];
        _titleShowLabel.textAlignment = NSTextAlignmentLeft;
        _titleShowLabel.font = [UIFont systemFontOfSize:14];
//        _titleShowLabel.text = @"手机号 *";
        _titleShowLabel.textColor = [UIColor colorWithHexString:@"#555555"];
    }
    return _titleShowLabel;
}

- (UITextField *)contentTextField {
if (!_contentTextField) {
    _contentTextField = [[UITextField alloc]init];
    _contentTextField.font = [UIFont systemFontOfSize:15];
    _contentTextField.textColor = [UIColor colorWithHexString:@"#000000"];
//    _contentTextField.delegate = self;
    
    NSString *holderText = @"手机号";
    NSMutableAttributedString *placeholder = [[NSMutableAttributedString alloc] initWithString:holderText];
    [placeholder addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithHexString:@"#BDBDBD"] range:NSMakeRange(0, holderText.length)];
    [placeholder addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:15] range:NSMakeRange(0, holderText.length)];
    
    _contentTextField.attributedPlaceholder = placeholder;
    _contentTextField.clearButtonMode = UITextFieldViewModeAlways;
    _contentTextField.keyboardType = UIKeyboardTypeNumberPad;
    }
    return _contentTextField;
}

- (UIView *)lineView
{
    if (!_lineView) {
        _lineView = [[UIView alloc] init];
        _lineView.backgroundColor = [UIColor colorWithHexString:@"#E5E5E5"];
    }
    return _lineView;
}

- (JKCountDownButton *)countDownBtn{
    if (!_countDownBtn) {
        _countDownBtn = [[JKCountDownButton alloc] init];
        [_countDownBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
        [_countDownBtn setTitleColor:[UIColor colorWithHexString:@"#739EFC"] forState:UIControlStateNormal];
        _countDownBtn.hidden = YES;
        [_countDownBtn setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
        _countDownBtn.titleLabel.font = [UIFont systemFontOfSize:12];
        [_countDownBtn addTarget:self action:@selector(countDownBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        
        [_countDownBtn countDownFinished:^NSString *(JKCountDownButton *countDownButton, NSUInteger second) {
            countDownButton.enabled = YES;
            [countDownButton setTitleColor:ThemeColor forState:UIControlStateNormal];
            return @"重新获取验证码";
        }];
        [_countDownBtn countDownChanging:^NSString *(JKCountDownButton *countDownButton, NSUInteger second) {
            return [NSString stringWithFormat:@"重新获取验证码（%@）", @(second)];
        }];
    }
    return _countDownBtn;
}

- (UIImageView *)showCodeView
{
    if (!_showCodeView) {
        _showCodeView = [[UIImageView alloc] init];
        _showCodeView.hidden = YES;
        _showCodeView.layer.borderWidth = 1;
        _showCodeView.layer.borderColor = [UIColor colorWithHexString:@"#DBDBDB"].CGColor;
    }
    return _showCodeView;
}

- (UIButton *)noClearBtn
{
    if (!_noClearBtn) {
        _noClearBtn = [UIButton new];
        [_noClearBtn setTitle:@"看不清，换一张" forState:UIControlStateNormal];
        [_noClearBtn setTitleColor:[UIColor colorWithHexString:@"#666666"] forState:UIControlStateNormal];
        _noClearBtn.titleLabel.font = [UIFont systemFontOfSize:12];
        [_noClearBtn addTarget:self action:@selector(clickRefreshCodeAction) forControlEvents:UIControlEventTouchUpInside];
        _noClearBtn.hidden = YES;
    }
    return _noClearBtn;
}



@end
