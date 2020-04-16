//
//  MessageContentCell.m
//  ZhongQiBrand
//
//  Created by iOS on 2019/10/21.
//  Copyright © 2019 CY. All rights reserved.
//

#import "MessageContentCell.h"

@interface MessageContentCell ()<UITextViewDelegate>

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIImageView *signImg;
@property (nonatomic, strong) UIButton *rewriteBtn;

@end

@implementation MessageContentCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setUpUI];
        [self registNotification];
    }
    return self;
}

- (void)setUpUI {
    
    UIView *topSpaceView = [[UIView alloc]init];
    topSpaceView.backgroundColor = [UIColor colorWithHexString:@"#F8F8F8"];
    [self.contentView addSubview:topSpaceView];
    [topSpaceView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.mas_equalTo(0);
        make.height.mas_equalTo(8 * scaleX);
    }];
    
    [self.contentView addSubview:self.titleLabel];
    [self.contentView addSubview:self.signImg];
    [self.contentView addSubview:self.rewriteBtn];
    [self.contentView addSubview:self.contentTextView];
    [self.contentView addSubview:self.placeLable];
    
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(topSpaceView.mas_bottom).offset(15 * scaleX);
        make.left.mas_equalTo(15 * scaleX);
    }];
    
    [_signImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.titleLabel.mas_centerY).offset(2 * scaleX);
        make.left.equalTo(self.titleLabel.mas_right).offset(10.5 * scaleX);
        make.width.mas_equalTo(7.5 * scaleX);
        make.height.mas_equalTo(21 * scaleX);
    }];
    
    [_rewriteBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.titleLabel.mas_centerY).offset(0);
        make.right.mas_equalTo(-15 * scaleX);
      
    }];
    
    [_contentTextView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.titleLabel.mas_bottom).offset(15 * scaleX);
        make.left.mas_equalTo(15 * scaleX);
        make.right.mas_equalTo(-15 * scaleX);
        make.height.mas_equalTo(81 * scaleX);
        make.bottom.mas_equalTo (-33.5 * scaleX);
    }];
    
    [_placeLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentTextView.mas_top).offset(7 * scaleX);
        make.left.equalTo(self.contentTextView.mas_left).offset(4.5 * scaleX);
        make.right.equalTo(self.contentTextView.mas_right).offset(-4.5 * scaleX);
        make.height.mas_equalTo(40 * scaleX);
    }];
    
    UIView *footerSpace = [[UIView alloc]init];
    footerSpace.backgroundColor = [UIColor colorWithHexString:@"#F8F8F8"];
    [self.contentView addSubview:footerSpace];
    [footerSpace mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentTextView.mas_bottom).offset(22.5 * scaleX);
        make.bottom.left.right.mas_equalTo(0);
        make.height.mas_equalTo(11 * scaleX);
    }];
}

-(void)registNotification
{
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyBoardDidShowNotification:) name:UIKeyboardDidShowNotification object:nil];
}

-(void)keyBoardDidShowNotification:(NSNotification *)noti
{
    if (self.contentTextView.isFirstResponder) {
        UITableView *tableView = [self tableView];
        if (tableView) {
            [tableView scrollToRowAtIndexPath:[tableView indexPathForCell:self] atScrollPosition:UITableViewScrollPositionBottom animated:YES];
        }
    }
}

-(UITableView *)tableView {
    UIResponder *res = self;
    while (res.nextResponder&&(![res isKindOfClass:[UITableView class]])) {
        res = res.nextResponder;
        if ([res isKindOfClass: [UITableView class]]) {
            return (UITableView *)res;
        }
    }
    return nil;
}

-(void)textViewDidChange:(UITextView *)textView
{
    NSInteger count = textView.text.length;
    if (count >0) {
        self.placeLable.hidden =YES;
    }else{
        self.placeLable.hidden = NO;
    }
}

- (void)rewriteBtnClicked {
    if (self.clickRewriteBtnBlock) {
        self.clickRewriteBtnBlock();
    }
}

#pragma mark - 懒加载
- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc]init];
        _titleLabel.text = @"留言内容";
        _titleLabel.textColor = [UIColor blackColor];
        _titleLabel.font = [UIFont systemFontOfSize:16];
        _titleLabel.textAlignment = NSTextAlignmentLeft;
    }
    return _titleLabel;
}

- (UIImageView *)signImg {
    if (!_signImg) {
        _signImg = [[UIImageView alloc]init];
        _signImg.contentMode = UIViewContentModeScaleAspectFit;
        _signImg.image = [UIImage imageNamed:@"xinghao_icon"];
    }
    return _signImg;
}

- (UIButton *)rewriteBtn {
    if (!_rewriteBtn) {
        _rewriteBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_rewriteBtn setImage:[UIImage imageNamed:@"feedback_qb_icon"] forState:UIControlStateNormal];
        [_rewriteBtn setTitle:@"重写" forState:UIControlStateNormal];
        [_rewriteBtn setTitleColor:[UIColor colorWithHexString:@"#FE534D"] forState:UIControlStateNormal];
        
        _rewriteBtn.titleLabel.font = [UIFont systemFontOfSize:13];
        [_rewriteBtn addTarget:self action:@selector(rewriteBtnClicked) forControlEvents:UIControlEventTouchUpInside];
    }
    return _rewriteBtn;
}

- (UITextView *)contentTextView {
    if (!_contentTextView) {
        _contentTextView = [[UITextView alloc]init];
        _contentTextView.font = [UIFont systemFontOfSize:14];
        [_contentTextView setTextContainerInset:UIEdgeInsetsMake(7 * scaleX, 4.5 * scaleX, -7 * scaleX, -4.5 * scaleX)];
        _contentTextView.delegate = self;
        _contentTextView.backgroundColor = [UIColor colorWithHexString:@"#FAFAFA"];
        _contentTextView.textColor = [UIColor blackColor];
    }
    return _contentTextView;
}

- (UILabel *)placeLable {
    if (!_placeLable) {
        _placeLable = [[UILabel alloc]init];
        _placeLable.text = @"为了您的反馈得到及时处理，请详细描述所遇到的问题 谢谢！";
        _placeLable.textColor = [UIColor colorWithHexString:@"#CFCFCF"];
        _placeLable.textAlignment = NSTextAlignmentLeft;
        _placeLable.font = [UIFont systemFontOfSize:14];
        _placeLable.numberOfLines = 2;
    }
    return _placeLable;
}

-(BOOL)becomeFirstResponder
{
    [super becomeFirstResponder];
    return [self.contentTextView becomeFirstResponder];
}
@end
