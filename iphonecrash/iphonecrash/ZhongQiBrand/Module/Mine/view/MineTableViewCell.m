//
//  MineTableViewCell.m
//  ZhongQiBrand
//
//  Created by iOS on 2019/10/14.
//  Copyright © 2019 CY. All rights reserved.
//

#import "MineTableViewCell.h"

@interface MineTableViewCell ()
@property (nonatomic, strong) UIView *lineView;

@end

@implementation MineTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setSelectionStyle:UITableViewCellSelectionStyleNone];
        [self setUpUI];
    }
    return self;
}

- (void)setUpUI
{
    [self.contentView addSubview:self.img];
    [self.contentView addSubview:self.textLbl];
    [self.contentView addSubview:self.arrowImg];
    [self.contentView addSubview:self.lineView];
    
    [self.img mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(px_scale(34));
        make.centerY.mas_equalTo(0);
        make.width.height.mas_equalTo(px_scale(34));
    }];
    
    [self.textLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.img.mas_right).offset(px_scale(18));
        make.centerY.equalTo(self.img);
        make.height.mas_equalTo(px_scale(60));
    }];
    
    [self.arrowImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(px_scale(18));
        make.height.mas_equalTo(px_scale(28));
        make.right.mas_equalTo(-17);
        make.centerY.equalTo(self.img);
    }];
    
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(px_scale(30));
        make.height.mas_equalTo(0.8);
        make.right.mas_equalTo(-30);
        make.bottom.mas_equalTo(0);
    }];
}

#pragma mark - =========

- (UIImageView *)img{
    if (!_img) {
        _img = [[UIImageView alloc] init];
        _img.contentMode = UIViewContentModeScaleAspectFit;
    }
    return _img;
}

- (UILabel *)textLbl{
    if (!_textLbl) {
        _textLbl = [[UILabel alloc] init];
        _textLbl.textColor = [UIColor colorWithHexString:@"#000000"];
        _textLbl.font = [UIFont boldSystemFontOfSize:17];
    }
    return _textLbl;
}

- (UIImageView *)arrowImg{
    if (!_arrowImg) {
        _arrowImg = [[UIImageView alloc] init];
        _arrowImg.image = [UIImage imageNamed:@"wd_arrow_icon"];
        _arrowImg.contentMode = UIViewContentModeScaleAspectFit;
    }
    return _arrowImg;
}

- (UIView *)lineView {
    if (!_lineView) {
        _lineView = [[UIView alloc]init];
        _lineView.backgroundColor = [UIColor colorWithHexString:@"#E6E6E6"];
    }
    return _lineView;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

@end
