//
//  SettingOutCell.m
//  ZhongQiBrand
//
//  Created by iOS on 2019/10/17.
//  Copyright © 2019 CY. All rights reserved.
//

#import "SettingOutCell.h"

@interface SettingOutCell ()
@property (nonatomic, strong) UILabel *loginOutLabel;
@end

@implementation SettingOutCell

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
    SettingOutCell *cell = [tableView dequeueReusableCellWithIdentifier:CellID];
    if (cell == nil) {
        cell = [[SettingOutCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellID];
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
    [self.contentView addSubview:self.loginOutLabel];
    
    [self.loginOutLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15 * scaleX);
        make.right.mas_equalTo(-15 * scaleX);
        make.centerY.mas_equalTo(0);
    }];
}


#pragma mark - 懒加载
- (UILabel *)loginOutLabel {
    if (!_loginOutLabel) {
        _loginOutLabel = [[UILabel alloc]init];
        _loginOutLabel.textAlignment = NSTextAlignmentCenter;
        _loginOutLabel.textColor = [UIColor blackColor];
        _loginOutLabel.font = [UIFont systemFontOfSize:17];
        _loginOutLabel.text = @"退出登录";
    }
    return _loginOutLabel;
}
@end
