//
//  HomeTableHeaderView.m
//  ZhongQiBrand
//
//  Created by ios2 on 2019/9/17.
//  Copyright © 2019 CY. All rights reserved.
//

#import "HomeTableHeaderView.h"

@implementation HomeTableHeaderView {
    UIButton * _moreButton;
}

-(instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier {
    self =[super initWithReuseIdentifier:reuseIdentifier];
    if (self) {
        [self setUpUI];
    }
    return self;
}

#pragma mark  - 初始化UI
-(void)setUpUI {
    self.contentView.backgroundColor = [UIColor whiteColor];
    [self.contentView addSubview:self.titleLable];
    [self.contentView addSubview:self.engLishTitle];
    [self.contentView addSubview:self.lineView];
    
    //设置约束
    [_titleLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(px_scale(30));
        make.top.mas_equalTo(px_scale(40));
        make.height.mas_equalTo(px_scale(53));
    }];
    
    [_engLishTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.lineView.mas_right).offset(px_scale(20));
        make.centerY.equalTo(self.titleLable);
        make.height.equalTo(self.titleLable);
    }];
    
    [_lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.titleLable);
        make.height.mas_equalTo(px_scale(20));
        make.width.mas_equalTo(px_scale(6));
        make.left.mas_equalTo(px_scale(204));
    }];
    
    UIButton *moreButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [moreButton setTitleColor:[UIColor colorWithHexString:@"#999999"] forState:UIControlStateNormal];
    moreButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    [moreButton setImage:[UIImage imageNamed:@"ckgd_btn_icon"] forState:UIControlStateNormal];
    [moreButton setTitle:@"更多" forState:UIControlStateNormal];
    moreButton.titleLabel.font = [UIFont systemFontOfSize:12];
    moreButton.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0,-px_scale(50));
    moreButton.titleEdgeInsets = UIEdgeInsetsMake(0, 0, 0, px_scale(10));
    [self.contentView addSubview:moreButton];
	[moreButton addTarget:self action:@selector(moreButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    _moreButton = moreButton;
    [moreButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-px_scale(30));
        make.height.mas_equalTo(px_scale(40));
        make.width.mas_equalTo(px_scale(120));
        make.centerY.equalTo(self.titleLable);
    }];
}

-(void)configerTitle:(NSString *)title
          andEnglish:(NSString *)english
       andIsShowMore:(BOOL)isShowMore
{
    self.titleLable.text = title;
    self.engLishTitle.text = english;
    _moreButton.hidden = isShowMore?NO:YES;
}
//点击查看更多按钮
-(void)moreButtonClicked:(UIButton *)button
{
	!_didClickedMoreBlock?:_didClickedMoreBlock(self.index);
}

#pragma mark - getter
-(UILabel *)titleLable
{
    if (!_titleLable) {
        _titleLable = [[UILabel alloc]init];
        _titleLable.font = [UIFont boldSystemFontOfSize:19];
        _titleLable.textColor = [UIColor colorWithHexString:@"#333333"];
    }
    return _titleLable;
}

-(UILabel *)engLishTitle
{
    if (!_engLishTitle) {
        _engLishTitle = [[UILabel alloc]init];
        _engLishTitle.textColor = [UIColor colorWithHexString:@"#333333"];
        _engLishTitle.font = [UIFont systemFontOfSize:12];
    }
    return _engLishTitle;
}

-(UIView *)lineView
{
    if (!_lineView) {
        _lineView = [[UILabel alloc]init];
        _lineView.backgroundColor =[UIColor colorWithHexString:@"#DD131C"];
        _lineView.layer.cornerRadius = px_scale(3);
        _lineView.layer.masksToBounds = YES;
    }
    return _lineView;
}


@end

