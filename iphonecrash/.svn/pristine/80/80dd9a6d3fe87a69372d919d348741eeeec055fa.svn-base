//
//  ServiceTypeCell.m
//  ZhongQiBrand
//
//  Created by iOS on 2019/10/21.
//  Copyright © 2019 CY. All rights reserved.
//

#import "ServiceTypeCell.h"

@implementation ServiceTypeCell

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
    ServiceTypeCell *cell = [tableView dequeueReusableCellWithIdentifier:CellID];
    if (cell == nil) {
        cell = [[ServiceTypeCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellID];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.backgroundColor = [UIColor clearColor];
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
    [self.contentView addSubview:self.serviceImg];
    [self.contentView addSubview:self.serviceLabel];
    [_serviceImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-10.5 * scaleX);
        make.height.mas_equalTo(62 * scaleX);
        make.width.mas_equalTo(62 * scaleX);
        make.centerY.mas_equalTo(0);
    }];
    
    [_serviceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.serviceImg.mas_left).offset(-8.5 * scaleX);
        make.centerY.mas_equalTo(0);
    }];
}

- (UIImageView *)serviceImg {
    if (!_serviceImg) {
        _serviceImg = [[UIImageView alloc]init];
        _serviceImg.contentMode = UIViewContentModeScaleAspectFit;
    }
    return _serviceImg;
}

- (UILabel *)serviceLabel {
    if (!_serviceLabel) {
        _serviceLabel = [[UILabel alloc]init];
        _serviceLabel.textColor = [UIColor colorWithHexString:@"#333333"];
        _serviceLabel.textAlignment = NSTextAlignmentRight;
        _serviceLabel.font = [UIFont systemFontOfSize:13];
    }
    return _serviceLabel;
}
@end
