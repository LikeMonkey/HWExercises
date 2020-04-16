
//
//  SettingCell.m
//  ZhongQiBrand
//
//  Created by iOS on 2019/10/17.
//  Copyright © 2019 CY. All rights reserved.
//

#import "SettingCell.h"

@interface SettingCell()
@property (nonatomic, strong) UIImageView *arrowImg;
@property (nonatomic, strong) UIView *horizonLine;
@end

@implementation SettingCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

+ (instancetype)cellWithTableView:(UITableView *)tableView {
    static NSString *CellID = @"Cell";
    SettingCell *cell = [tableView dequeueReusableCellWithIdentifier:CellID];
    if (cell == nil) {
        cell = [[SettingCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellID];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.contentView.backgroundColor = [UIColor whiteColor];
    }
    return cell;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setUpUI];
    }
    return self;
}

- (void)setUpUI
{
    [self.contentView addSubview:self.leftLabel];
    [self.contentView addSubview:self.arrowImg];
    [self.contentView addSubview:self.rightLabel];
    [self.contentView addSubview:self.horizonLine];
    
    [self.leftLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15 * scaleX);
        make.centerY.mas_equalTo(0);
    }];
    
    [self.arrowImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-17 * scaleX);
        make.centerY.mas_equalTo(0);
        make.width.mas_equalTo(8 * scaleX);
        make.height.mas_equalTo(13 * scaleX);
    }];
    
    [self.rightLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.arrowImg.mas_left).offset(-16 * scaleX);
        make.centerY.mas_equalTo(0);
    }];
    
    [self.horizonLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(0);
        make.left.mas_equalTo(15 * scaleX);
        make.right.mas_equalTo(-15 * scaleX);
        make.height.mas_equalTo(1 * scaleX);
    }];
    
    self.horizonLine.hidden = self.isHiddenLine;
}

- (void)setIsHasArrow:(BOOL)isHasArrow {
    _isHasArrow = isHasArrow;
    if (self.isHasArrow) {
        [self.rightLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.arrowImg.mas_left).offset(-16 * scaleX);
            make.centerY.mas_equalTo(0);
        }];
    }else {
        [self.rightLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(-17 * scaleX);
            make.centerY.mas_equalTo(0);
        }];
    }
}

- (void)setIsHiddenLine:(BOOL)isHiddenLine {
    _isHiddenLine = isHiddenLine;
    self.horizonLine.hidden = self.isHiddenLine;
}

#pragma mark - 懒加载
- (UILabel *)leftLabel {
    if (!_leftLabel) {
        _leftLabel = [[UILabel alloc]init];
        _leftLabel.textAlignment = NSTextAlignmentLeft;
        _leftLabel.textColor = [UIColor blackColor];
        _leftLabel.font = [UIFont systemFontOfSize:17];
    }
    return _leftLabel;
}

- (UILabel *)rightLabel {
    if (!_rightLabel) {
        _rightLabel = [[UILabel alloc]init];
        _rightLabel.textAlignment = NSTextAlignmentRight;
        _rightLabel.textColor = [UIColor colorWithHexString:@"#666666"];
        _rightLabel.font = [UIFont systemFontOfSize:16];
    }
    return _rightLabel;
}

- (UIImageView *)arrowImg {
    if (!_arrowImg) {
        _arrowImg = [[UIImageView alloc]init];
        _arrowImg.contentMode = UIViewContentModeScaleAspectFit;
        _arrowImg.image = [UIImage imageNamed:@"sz_arrow_icon"];
    }
    return _arrowImg;
}

- (UIView *)horizonLine {
    if (!_horizonLine) {
        _horizonLine = [[UIView alloc]init];
        _horizonLine.backgroundColor = [UIColor colorWithHexString:@"#E6E6E6"];
    }
    return _horizonLine;
}

@end
