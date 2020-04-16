//
//  SettingCacheCell.m
//  ZhongQiBrand
//
//  Created by iOS on 2019/10/17.
//  Copyright © 2019 CY. All rights reserved.
//

#import "SettingCacheCell.h"

@interface SettingCacheCell ()
@property (nonatomic, strong) UILabel *leftLabel;
@property (nonatomic, strong) UIButton *rightBtn;
@property (nonatomic, strong) UIView *verticalLine;
@end

@implementation SettingCacheCell

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
    SettingCacheCell *cell = [tableView dequeueReusableCellWithIdentifier:CellID];
    if (cell == nil) {
        cell = [[SettingCacheCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellID];
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
    [self.contentView addSubview:self.rightBtn];
    [self.contentView addSubview:self.verticalLine];
    [self.contentView addSubview:self.rightLabel];
    
    [self.leftLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15 * scaleX);
        make.centerY.mas_equalTo(0);
    }];
    
    [self.rightBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-15 * scaleX);
        make.centerY.mas_equalTo(0);
    }];
    
    [self.verticalLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.rightBtn.mas_left).offset(-10 * scaleX);
        make.centerY.mas_equalTo(0);
        make.width.mas_equalTo(1 * scaleX);
        make.height.mas_equalTo(12 * scaleX);
    }];
    
    [self.rightLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.verticalLine.mas_left).offset(-10 * scaleX);
        make.centerY.mas_equalTo(0);
    }];
}


#pragma mark - 懒加载
- (UILabel *)leftLabel {
    if (!_leftLabel) {
        _leftLabel = [[UILabel alloc]init];
        _leftLabel.textAlignment = NSTextAlignmentLeft;
        _leftLabel.textColor = [UIColor blackColor];
        _leftLabel.font = [UIFont systemFontOfSize:17];
        _leftLabel.text = @"清除缓存";
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

- (UIButton *)rightBtn {
    if (!_rightBtn) {
        _rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_rightBtn setTitle:@"立即清除" forState:UIControlStateNormal];
        [_rightBtn setTitleColor:[UIColor colorWithHexString:@"#FE534D"] forState:UIControlStateNormal];
        _rightBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    }
    return _rightBtn;
}

- (UIView *)verticalLine {
    if (!_verticalLine) {
        _verticalLine = [[UIView alloc]init];
        _verticalLine.backgroundColor = [UIColor colorWithHexString:@"#E6E6E6"];
    }
    return _verticalLine;
}
@end
