//
//  ChangePhoneController.m
//  ZhongQiBrand
//
//  Created by iOS on 2019/10/17.
//  Copyright © 2019 CY. All rights reserved.
//

#import "ChangePhoneController.h"

@interface ChangePhoneController ()<UIScrollViewDelegate,UITextFieldDelegate>
{
    NSInteger num;
}
@property (nonatomic, strong) UIScrollView *myScrollView;
@property (nonatomic, strong) UILabel *currentPhone;
@property (nonatomic, strong) UITextField *phoneTextFiled;
@property (nonatomic, strong) UITextField *codeTextFiled;
@property (nonatomic, strong) UIButton *codeBtn;
@property (nonatomic, strong) UIButton *nextBtn;

/** 倒计时 */
@property (nonatomic, strong) NSTimer *timer;

@end

@implementation ChangePhoneController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initNavView];
    self.lineView.hidden = YES;
    BlackStatusBar;
    [self initBackNavItem];
    self.title = @"更换手机号";
    self.view.backgroundColor = [UIColor colorWithHexString:@"#F8F8F8"];
    
    num = 60;
    _timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timeDown) userInfo:nil repeats:YES];
    [_timer setFireDate:[NSDate distantFuture]];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(phoneTextFieldChange) name:UITextFieldTextDidChangeNotification object:_phoneTextFiled];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(verificationTextFieldChange) name:UITextFieldTextDidChangeNotification object:_codeTextFiled];
    
    [self setupUI];
}

/** 视图初始化 */
- (void)setupUI {
    
    [self.view addSubview:self.myScrollView];
    [_myScrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.mas_equalTo(0);
        make.top.equalTo(self.navView.mas_bottom).with.offset(0);
    }];
    
    
    UIView *currentView = [[UIView alloc]init];
    currentView.backgroundColor = [UIColor whiteColor];
    
    [self.myScrollView addSubview:currentView];
    [currentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.top.mas_equalTo(8 * scaleX);
        make.width.mas_equalTo(MAINScreenWidth);
        make.height.mas_equalTo(75 * scaleX);
    }];
    
    [currentView addSubview:self.currentPhone];
    [_currentPhone mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.mas_equalTo(15 * scaleX);
    }];
    
    UILabel *descripLabel = [[UILabel alloc]init];
    descripLabel.text = @"请输入新的手机号码";
    descripLabel.textColor = [UIColor colorWithHexString:@"#999999"];
    descripLabel.font = [UIFont systemFontOfSize:12];
    descripLabel.textAlignment = NSTextAlignmentLeft;
    
    [currentView addSubview:descripLabel];
    [descripLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15 * scaleX);
        make.bottom.mas_equalTo(-15 * scaleX);
    }];
    
    UIView *phoneView = [[UIView alloc]init];
    phoneView.backgroundColor = [UIColor whiteColor];
    
    [self.myScrollView addSubview:phoneView];
    [phoneView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.top.equalTo(currentView.mas_bottom).offset(8 * scaleX);
        make.width.mas_equalTo(MAINScreenWidth);
        make.height.mas_equalTo(54 * scaleX);
    }];
    
    UILabel *prefixLabel = [[UILabel alloc]init];
    prefixLabel.text = @"中国大陆 86+";
    prefixLabel.textColor = [UIColor colorWithHexString:@"#FE534D"];
    prefixLabel.textAlignment = NSTextAlignmentLeft;
    prefixLabel.font = [UIFont systemFontOfSize:17];
    
    [phoneView addSubview:prefixLabel];
    [prefixLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15 * scaleX);
        make.centerY.mas_equalTo(0);
        make.height.mas_equalTo(30 * scaleX);
    }];
    
    UIView *lineView = [[UIView alloc]init];
    lineView.backgroundColor = [UIColor colorWithHexString:@"#DCDCDC"];
    
    [phoneView addSubview:lineView];
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(prefixLabel.mas_right).offset(14 * scaleX);
        make.centerY.mas_equalTo(0);
        make.width.mas_equalTo(1 * scaleX);
        make.height.mas_equalTo(18 * scaleX);
    }];
    
    [phoneView addSubview:self.phoneTextFiled];
    [_phoneTextFiled mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(lineView.mas_right).offset(14 * scaleX);
        make.centerY.mas_equalTo(0);
        make.width.mas_equalTo(150 * scaleX);
        make.height.mas_equalTo(35 * scaleX);
    }];
    
    UIView *codeView = [[UIView alloc]init];
    codeView.backgroundColor = [UIColor whiteColor];
    
    [self.myScrollView addSubview:codeView];
    [codeView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.top.equalTo(phoneView.mas_bottom).offset(8 * scaleX);
        make.width.mas_equalTo(MAINScreenWidth);
        make.height.mas_equalTo(54 * scaleX);
    }];
    
    [codeView addSubview:self.codeBtn];
    [_codeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-16 * scaleX);
        make.width.mas_equalTo(113 * scaleX);
        make.height.mas_equalTo(34 * scaleX);
        make.centerY.mas_equalTo(0);
    }];
    
    [codeView addSubview:self.codeTextFiled];
    [_codeTextFiled mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(77 * scaleX);
        make.right.equalTo(self.codeBtn.mas_left).offset(0);
        make.centerY.mas_equalTo(0);
        make.height.mas_equalTo(54 * scaleX);
    }];
    
    [self.myScrollView addSubview:self.nextBtn];
    [_nextBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(codeView.mas_bottom).offset(8 * scaleX);
        make.centerX.mas_equalTo(0);
        make.width.mas_equalTo(345 * scaleX);
        make.height.mas_equalTo(44 * scaleX);
    }];
}


- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UITextFieldTextDidChangeNotification object:_phoneTextFiled];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UITextFieldTextDidChangeNotification object:_codeTextFiled];
}

#pragma mark - UITextFieldDelegate
- (void)textFieldDidBeginEditing:(UITextField *)textField {
    
}

- (void)initBackNavItem
{
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc]initWithImage:[[UIImage imageNamed:@"all_fahuia_btn"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:(UIBarButtonItemStylePlain) target:self action:@selector(backClicked:)];
    self.navigationItem.leftBarButtonItem = backItem;
}

#pragma mark - Target Mehtods
- (void)backClicked:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - 计时器
- (void)timeDown
{
    num--;
    if (0 == num)
    {
        [self returnOriginalStatus];
    } else
    {
        NSString *second = [NSString stringWithFormat:@"%ld秒后获取", (long)num];
        [_codeBtn setTitle:second forState:UIControlStateNormal];
        [_codeBtn setTitleColor:[UIColor colorWithHexString:@"#B2B2B2"] forState:UIControlStateNormal];
        [_codeBtn setBackgroundImage:[UIImage imageNamed:@"sz_code_selected"] forState:UIControlStateNormal];
        _codeBtn.userInteractionEnabled = NO;
    }
}


- (void)returnOriginalStatus
{
    num = 60;
    [_codeBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
    [_codeBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_codeBtn setBackgroundImage:[UIImage imageNamed:@"sz_code_normal"] forState:UIControlStateNormal];
    _codeBtn.userInteractionEnabled = YES;
    [_timer setFireDate:[NSDate distantFuture]];
}


- (void)phoneTextFieldChange {
    
    if ([NSString valiMobile:self.phoneTextFiled.text] && self.phoneTextFiled.text.length > 11) {
        self.phoneTextFiled.text = [self.phoneTextFiled.text substringToIndex:11];
        SHOW_MSG(@"请输入正确的手机号", 0.5);
        return;
    }
    
}

- (void)verificationTextFieldChange {
    if (self.codeTextFiled.text.length > 4) {
        self.codeTextFiled.text = [self.codeTextFiled.text substringToIndex:4];
        SHOW_MSG(@"请输入正确的验证码", 0.5);
        return;
    }
    
    if (self.phoneTextFiled.text.length == 11 && self.codeTextFiled.text.length == 4) {
        
        [_nextBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_nextBtn setBackgroundImage:[UIImage imageNamed:@"sz_next_selected"] forState:UIControlStateNormal];
        
        
    }else {
        
        [_nextBtn setTitleColor:[UIColor colorWithHexString:@"#BFBFBF"] forState:UIControlStateNormal];
        [_nextBtn setBackgroundImage:[UIImage imageNamed:@"sz_next_normal"] forState:UIControlStateNormal];
    }
}

- (void)codeBtnClicked:(UIButton *)sender {
    
    if ([_phoneTextFiled.text hasPrefix:@"1"] && [_phoneTextFiled.text length] == 11)
    {
        [_codeTextFiled becomeFirstResponder];
        _codeBtn.userInteractionEnabled = NO;
        [_timer setFireDate:[NSDate distantPast]];
    } else
    {
        SHOW_MSG(@"请输入正确的手机号", 0.5);
    }
}

- (void)nextBtnClicked:(UIButton *)sender {
    
}

#pragma mark - 懒加载
- (UIScrollView *)myScrollView {
    if (!_myScrollView) {
        _myScrollView = [[UIScrollView alloc]init];
        _myScrollView.backgroundColor = [UIColor clearColor];
        _myScrollView.showsVerticalScrollIndicator = NO;
        _myScrollView.showsHorizontalScrollIndicator = NO;
        _myScrollView.bounces = YES;
        _myScrollView.scrollEnabled = YES;
        _myScrollView.delegate = self;
        /** 拖动键盘消失 */
        _myScrollView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
        _myScrollView.contentSize = CGSizeMake(0, MAINScreenHeight - CGRectGetMaxY(self.navView.frame));
    }
    return _myScrollView;
}

- (UILabel *)currentPhone {
    if (!_currentPhone) {
        _currentPhone = [[UILabel alloc]init];
        _currentPhone.textAlignment = NSTextAlignmentLeft;
        _currentPhone.textColor = [UIColor blackColor];
        _currentPhone.font = [UIFont systemFontOfSize:17];
        _currentPhone.text = @"当前绑定手机号13****8911";
    }
    return _currentPhone;
}

- (UITextField *)phoneTextFiled {
    if (!_phoneTextFiled) {
        _phoneTextFiled = [[UITextField alloc]init];
        _phoneTextFiled.font = [UIFont systemFontOfSize:15];
        _phoneTextFiled.textColor = [UIColor blackColor];
        _phoneTextFiled.delegate = self;
        
        NSString *holderText = @"手机号";
        NSMutableAttributedString *placeholder = [[NSMutableAttributedString alloc] initWithString:holderText];
        [placeholder addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithHexString:@"#DCDCDC"] range:NSMakeRange(0, holderText.length)];
        [placeholder addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:15] range:NSMakeRange(0, holderText.length)];
        
        _phoneTextFiled.attributedPlaceholder = placeholder;
        _phoneTextFiled.clearButtonMode = UITextFieldViewModeAlways;
        _phoneTextFiled.keyboardType = UIKeyboardTypeNumberPad;
    }
    return _phoneTextFiled;
}

- (UITextField *)codeTextFiled {
    if (!_codeTextFiled) {
        _codeTextFiled = [[UITextField alloc]init];
        _codeTextFiled.font = [UIFont systemFontOfSize:17];
        _codeTextFiled.textColor = [UIColor blackColor];
        _codeTextFiled.delegate = self;
        
        NSString *holderText = @"请输入验证码";
        NSMutableAttributedString *placeholder = [[NSMutableAttributedString alloc] initWithString:holderText];
        [placeholder addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithHexString:@"#DCDCDC"] range:NSMakeRange(0, holderText.length)];
        [placeholder addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:17] range:NSMakeRange(0, holderText.length)];
        
        _codeTextFiled.attributedPlaceholder = placeholder;
        _codeTextFiled.clearButtonMode = UITextFieldViewModeAlways;
        _codeTextFiled.keyboardType = UIKeyboardTypeNumberPad;
    }
    return _codeTextFiled;
}

- (UIButton *)codeBtn {
    if (!_codeBtn) {
        _codeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_codeBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
        [_codeBtn setBackgroundImage:[UIImage imageNamed:@"sz_code_normal"] forState:UIControlStateNormal];
        [_codeBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _codeBtn.titleLabel.font = [UIFont systemFontOfSize:17];
        [_codeBtn addTarget:self action:@selector(codeBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _codeBtn;
}

- (UIButton *)nextBtn {
    if (!_nextBtn) {
        _nextBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _nextBtn.userInteractionEnabled = NO;
        [_nextBtn setTitle:@"下一步" forState:UIControlStateNormal];
        [_nextBtn setBackgroundImage:[UIImage imageNamed:@"sz_next_normal"] forState:UIControlStateNormal];
        [_nextBtn setTitleColor:[UIColor colorWithHexString:@"#BFBFBF"] forState:UIControlStateNormal];
        _nextBtn.titleLabel.font = [UIFont systemFontOfSize:17];
        [_nextBtn addTarget:self action:@selector(nextBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _nextBtn;
}
@end
