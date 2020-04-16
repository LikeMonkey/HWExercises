//
//  MobilePhoneVerificationView.m
//  VoteCloud
//
//  Created by 孙程 on 2019/8/16.
//  Copyright © 2019 CY. All rights reserved.
//

#import "MobilePhoneVerificationView.h"
#import "JKCountDownButton.h"

@interface MobilePhoneVerificationView () <UITextFieldDelegate>

@property (nonatomic, strong) UIView *maskView;
@property (nonatomic, strong) UIView *bgView;
@property (nonatomic, strong) UILabel *titleLbl;
@property (nonatomic, strong) UIView *titleLine;
@property (nonatomic, strong) UITextField *phoneNumberTF;
@property (nonatomic, strong) UIView *phoneNumberLine;
@property (nonatomic, strong) UITextField *codeTF;
@property (nonatomic, strong) UIView *codeLine;
@property (nonatomic, strong) JKCountDownButton *countDownBtn;
@property (nonatomic, strong) UIButton *submitBtn;
@property (nonatomic, strong) UIButton *closeBtn;
@property (nonatomic,strong) NSURLSessionDataTask *task;


@property (nonatomic, copy) MobilePhoneVerificationViewButtonClickBlock block;

@end

@implementation MobilePhoneVerificationView

+ (instancetype)showWithHandler:(MobilePhoneVerificationViewButtonClickBlock)block{
    MobilePhoneVerificationView *v = [[MobilePhoneVerificationView alloc] initWithFrame:CGRectMake(0, 0, MAINScreenWidth, MAINScreenHeight)];
    [v showWithHandler:block];
    [v show];
    return v;
}

//注册键盘监听
-(void)registNotification
{
	[[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyBoardWillShow:) name:UIKeyboardWillShowNotification object:nil];
	[[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyBoardWillHide:) name:UIKeyboardWillHideNotification object:nil];
}

-(void)removeNotification
{
	[[NSNotificationCenter defaultCenter]removeObserver:self name:UIKeyboardWillShowNotification object:nil];
	[[NSNotificationCenter defaultCenter]removeObserver:self name:UIKeyboardWillHideNotification object:nil];
}

#pragma mark - Notification Method
-(void)keyBoardWillShow:(NSNotification *)noti
{
	NSDictionary *useInfo = [noti userInfo];
	CGFloat duration =  [useInfo[UIKeyboardAnimationDurationUserInfoKey] floatValue];
	NSValue * value = [useInfo objectForKey:UIKeyboardFrameEndUserInfoKey];
	CGFloat _bottomH = CGRectGetHeight(value.CGRectValue) + 10;
	CGFloat bgCenterY =  MAINScreenHeight/2.0;
	CGFloat bgHeight = CGRectGetHeight(self.bgView.bounds);
	CGFloat bottomY = bgCenterY + bgHeight/2.0;
	CGFloat change = (MAINScreenHeight - bottomY) - _bottomH;

	[UIView animateWithDuration:duration animations:^{
		[self.bgView mas_updateConstraints:^(MASConstraintMaker *make) {
			make.centerY.mas_equalTo(change);
		}];
		[self layoutIfNeeded];
	}];

}
-(void)keyBoardWillHide:(NSNotification *)noti
{
	NSDictionary *useInfo = [noti userInfo];
	CGFloat duration =  [useInfo[UIKeyboardAnimationDurationUserInfoKey] floatValue];
	[UIView animateWithDuration:duration animations:^{
		[self.bgView mas_updateConstraints:^(MASConstraintMaker *make) {
			make.centerY.mas_equalTo(0);
		}];
		[self layoutIfNeeded];
	}];

}

- (void)showWithHandler:(MobilePhoneVerificationViewButtonClickBlock)block{
	[self registNotification]; //添加键盘监听
    self.block = block;
    [self addSubview:self.maskView];
    [self.maskView addSubview:self.bgView];
    [self.bgView addSubview:self.titleLine];
    [self.bgView addSubview:self.titleLbl];
    [self.bgView addSubview:self.closeBtn];
    [self.bgView addSubview:self.phoneNumberTF];
    [self.bgView addSubview:self.phoneNumberLine];
    [self.bgView addSubview:self.codeTF];
    [self.bgView addSubview:self.codeLine];
    [self.bgView addSubview:self.countDownBtn];
    [self.bgView addSubview:self.submitBtn];
    
    [self.maskView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self).with.insets(UIEdgeInsetsMake(0, 0, 0, 0));
    }];
    
    
    [self.bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(px_scale(30));
        make.centerY.equalTo(self.maskView.mas_centerY);
        make.right.mas_offset(-px_scale(30));
    }];
    
    [self.titleLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(px_scale(51));
        make.top.mas_offset(px_scale(82));
        make.height.mas_offset(px_scale(24));
        make.width.mas_offset(px_scale(216));
    }];
    
    [self.titleLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(px_scale(50));
        make.top.mas_offset(px_scale(50));
        make.bottom.equalTo(self.titleLine.mas_bottom).offset(0);
        make.width.mas_offset(px_scale(200));
    }];
    
    [self.closeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_offset(-px_scale(20));
        make.top.mas_offset(px_scale(20));
        make.width.height.mas_offset(40);
    }];
    
    [self.phoneNumberTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(px_scale(50));
        make.top.equalTo(self.titleLine).offset(px_scale(77));
        make.right.mas_offset(-px_scale(50));
    }];
    
    [self.phoneNumberLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(px_scale(50));
        make.top.equalTo(self.phoneNumberTF.mas_bottom).offset(16);
        make.right.mas_offset(-px_scale(50));
        make.height.mas_offset(PixelOne);
    }];
    
    [self.codeTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(px_scale(50));
        make.top.equalTo(self.phoneNumberLine).offset(px_scale(60));
        make.right.equalTo(self.countDownBtn.mas_left).offset(-px_scale(5));
    }];
    
    [self.codeLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(px_scale(50));
        make.top.equalTo(self.codeTF.mas_bottom).offset(16);
        make.right.mas_offset(-px_scale(50));
        make.height.mas_offset(PixelOne);
    }];
    
    [self.countDownBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_offset(-px_scale(71));
        make.centerY.equalTo(self.codeTF.mas_centerY);
        make.height.mas_offset(40);
    }];
    
    [self.submitBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.codeLine).offset(px_scale(70));
        make.height.mas_offset(px_scale(78));
        make.left.mas_offset(px_scale(120));
        make.right.mas_offset(-px_scale(120));
        make.bottom.equalTo(self.bgView.mas_bottom).offset(-px_scale(59));
    }];
	if (@available(iOS 12.0, *)) {
		_codeTF.textContentType = UITextContentTypeOneTimeCode;
		_codeTF.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
	}else{
		_codeTF.keyboardType = UIKeyboardTypeNumberPad;
	}
}

- (void)show{

    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    [self.bgView setNeedsUpdateConstraints];
    [self.bgView updateConstraintsIfNeeded];
    [self.bgView layoutIfNeeded];
    [window addSubview:self];
}

- (void)hiden{
    [self.countDownBtn stopCountDown];
    [self removeFromSuperview];
}

- (void)countDownBtnClick:(JKCountDownButton *)btn{
    [self.phoneNumberTF resignFirstResponder];
    // 请求验证码
    if (self.phoneNumberTF.text.length == 0) {
        SHOW_MSG(@"请输入手机号", 0.5);
        return;
    }
    SHOW_LOAD;
    TokenModel *model = [TokenModel new];
    NSMutableDictionary *parms = [model.dictionary mutableCopy];
    parms[@"u"] = USER_ID; // 用户id
    parms[@"phone"] = self.phoneNumberTF.text;
    WS(ws);
    if (ws.task) {
        [ws.task cancel];
    }

    ws.task = [RequestBaseTool postUrlStr:AppendAPI(APPURL_prefix, @"")
                                 andParms:parms andCompletion:^(id obj) {
                                     HIDDEN_HUD;
                                     NSInteger status = [obj[@"status"] integerValue];
                                     if (status == 1) {
                                         [ws.countDownBtn startCountDownWithSecond:60];
                                         ws.countDownBtn.enabled = NO;
                                         [ws.countDownBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
                                         SHOW_MSG(obj[@"msg"], 0.5);
                                     }
                                     else{
                                         SHOW_MSG(obj[@"msg"], 0.5);
                                     }

                                 } Error:^(NSError *errror) {
                                     HIDDEN_HUD;
                                     if (errror.code != -900) {
                                         //错误码 -900 代表上一个任务取消
                                     }
                                 }];
    
}

- (void)submit:(UIButton *)btn{
    [self.phoneNumberTF resignFirstResponder];
    [self.codeTF resignFirstResponder];
    // 提交
    if (self.phoneNumberTF.text.length == 0) {
        SHOW_MSG(@"请输入手机号", 0.5);
        return;
    }
    if ([NSString valiMobile:self.phoneNumberTF.text]) {
        SHOW_MSG(@"请输入正确的手机号", 0.5);
        return;
    }
    if (self.codeTF.text.length == 0) {
        SHOW_MSG(@"请输入验证码", 0.5);
        return;
    }
    SHOW_LOAD;
    TokenModel *model = [TokenModel new];
    NSMutableDictionary *parms = [model.dictionary mutableCopy];
    parms[@"u"] = USER_ID; // 用户id
    parms[@"mobile"] = self.phoneNumberTF.text;
    parms[@"mobilecode"] = self.codeTF.text;
    WS(ws);
    if (ws.task) {
        [ws.task cancel];
    }
    
    ws.task = [RequestBaseTool postUrlStr:AppendAPI(APPURL_prefix, @"")
                                 andParms:parms andCompletion:^(id obj) {
                                     HIDDEN_HUD;
                                     NSInteger status = [obj[@"status"] integerValue];
                                     if (status == 1) {
                                         SHOW_MSG(obj[@"msg"], 0.5);
                                         [ws hiden];
                                         self.block(btn);
                                     }
                                     else{
                                         SHOW_MSG(obj[@"msg"], 0.5);
                                     }
                                     
                                 } Error:^(NSError *errror) {
                                     HIDDEN_HUD;
                                     if (errror.code != -900) {
                                         //错误码 -900 代表上一个任务取消
                                     }
                                 }];
    
    
}

- (void)close:(UIButton *)btn{
    [self hiden];
    self.block(btn);
}

#pragma mark - ========= UITextFieldDelegate

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
	if ([string isEqualToString:@""]) {
		//允许用户删字
		return YES;
	}
    if (textField.tag == 100) {
        if (textField.text.length > 10) {
            SHOW_MSG(@"手机号不能超过11位", 0.5);
            return NO;
        }
    }
    
    return YES;
}

#pragma mark - =========

- (UIView *)maskView{
    if (!_maskView) {
        _maskView = [[UIView alloc] init];
        _maskView.backgroundColor = [UIColor colorWithWhite:0 alpha:0.4];
    }
    return _maskView;
}

- (UIView *)bgView{
    if (!_bgView) {
        _bgView = [[UIView alloc] init];
        _bgView.backgroundColor = [UIColor whiteColor];
        
        _bgView.layer.masksToBounds = YES;
        _bgView.layer.cornerRadius = 5;
    }
    return _bgView;
}

- (UILabel *)titleLbl{
    if (!_titleLbl) {
        _titleLbl = [[UILabel alloc] init];
        _titleLbl.textColor = [UIColor blackColor];
        _titleLbl.font = [UIFont boldSystemFontOfSize:24];
        _titleLbl.text = @"手机验证";
    }
    return _titleLbl;
}

- (UIView *)titleLine{
    if (!_titleLine) {
        _titleLine = [[UILabel alloc] init];
        _titleLine.backgroundColor = [UIColor colorGradientChangeWithSize:CGSizeMake(px_scale(216), px_scale(24)) startPoint:CGPointMake(0.7, 0) direction:GradientChangeDirectionLevel startColor:ThemeColor endColor:[UIColor whiteColor]];
    }
    return _titleLine;
}

- (UITextField *)phoneNumberTF{
    if (!_phoneNumberTF) {
        _phoneNumberTF = [[UITextField alloc] init];
        _phoneNumberTF.textColor = [UIColor colorWithHexString:@"#333333"];
        _phoneNumberTF.font = [UIFont systemFontOfSize:15];
        _phoneNumberTF.placeholder = @"请输入手机号";
        _phoneNumberTF.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"请输入手机号" attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15], NSForegroundColorAttributeName:[UIColor colorWithHexString:@"#CCCCCC"]}];
        _phoneNumberTF.keyboardType = UIKeyboardTypeNumberPad;
        _phoneNumberTF.clearButtonMode = UITextFieldViewModeWhileEditing;
        _phoneNumberTF.tag = 100;
        _phoneNumberTF.delegate = self;
		
    }
    return _phoneNumberTF;
}

- (UIView *)phoneNumberLine{
    if (!_phoneNumberLine) {
        _phoneNumberLine = [[UIView alloc] init];
        _phoneNumberLine.backgroundColor = [UIColor colorWithHexString:@"#DDDDDD"];
    }
    return _phoneNumberLine;
}

- (UITextField *)codeTF{
    if (!_codeTF) {
        _codeTF = [[UITextField alloc] init];
        _codeTF.textColor = [UIColor colorWithHexString:@"#333333"];
        _codeTF.font = [UIFont systemFontOfSize:15];
        _codeTF.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"请输入验证码" attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15], NSForegroundColorAttributeName:[UIColor colorWithHexString:@"#CCCCCC"]}];
        _codeTF.keyboardType = UIKeyboardTypeNumberPad;
        _codeTF.clearButtonMode = UITextFieldViewModeWhileEditing;
        _codeTF.tag = 100;
    }
    return _codeTF;
}

- (UIView *)codeLine{
    if (!_codeLine) {
        _codeLine = [[UIView alloc] init];
        _codeLine.backgroundColor = [UIColor colorWithHexString:@"#DDDDDD"];
    }
    return _codeLine;
}


- (JKCountDownButton *)countDownBtn{
    if (!_countDownBtn) {
        _countDownBtn = [[JKCountDownButton alloc] init];
        [_countDownBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
        [_countDownBtn setTitleColor:ThemeColor forState:UIControlStateNormal];
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

- (UIButton *)submitBtn{
    if (!_submitBtn) {
        _submitBtn = [[UIButton alloc] init];
        [_submitBtn setTitle:@"立即验证" forState:UIControlStateNormal];
        _submitBtn.titleLabel.font = [UIFont systemFontOfSize:14];
        [_submitBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_submitBtn setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
        [_submitBtn setBackgroundImage:[UIImage imageNamed:@"themecolorimg"] forState:UIControlStateNormal];
        [_submitBtn addTarget:self action:@selector(submit:) forControlEvents:UIControlEventTouchUpInside];
        _submitBtn.layer.masksToBounds = YES;
        _submitBtn.layer.cornerRadius = px_scale(78) / 2.0;
        _submitBtn.tag = 101;
    }
    return _submitBtn;
}

- (UIButton *)closeBtn{
    if (!_closeBtn) {
        _closeBtn = [[UIButton alloc] init];
        [_closeBtn setImage:[UIImage imageNamed:@"rqzl_close_btn"] forState:UIControlStateNormal];
        [_closeBtn addTarget:self action:@selector(close:) forControlEvents:UIControlEventTouchUpInside];
        _closeBtn.tag = 100;
    }
    return _closeBtn;
}

-(void)dealloc
{
	//移除监听 ……
	[self removeNotification];
}


@end
