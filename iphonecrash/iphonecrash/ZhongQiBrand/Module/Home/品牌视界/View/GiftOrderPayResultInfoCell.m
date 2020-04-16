//
//  GiftOrderPayResultInfoCell.m
//  ZhongQiBrand
//
//  Created by ios 001 on 2019/10/22.
//  Copyright © 2019 CY. All rights reserved.
//

#import "GiftOrderPayResultInfoCell.h"

@implementation GiftOrderPayResultInfoCell

/* 快速创建Cell */
+(instancetype)cellWithTableView:(UITableView *)tableView withIdentifier:(NSString *)cellIdentifier indexPath:(NSIndexPath *)indexPath{
    
    GiftOrderPayResultInfoCell *cell=[tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
    
}
/* 自定义Cell */
-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    self =[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self){
        [self setUpView];
    }
    return self;
}
-(void)setUpView{
    [self.contentView addSubview:self.infoLabel];
    [self.contentView addSubview:self.contentLabel];
    [self.infoLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.contentView);
        make.left.mas_offset(px_scale(170));
    }];
    [self.contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.contentView);
        make.left.mas_offset(px_scale(330));
    }];
}
#pragma mark ——— lazy

- (UILabel *)infoLabel {
    if (!_infoLabel) {
        _infoLabel = [[UILabel alloc]init];
        [_infoLabel setFont:[UIFont systemFontOfSize:13]];
        _infoLabel.textColor = [UIColor colorWithHexString:@"#666666"];
        _infoLabel.textAlignment = NSTextAlignmentLeft;
    }
    return _infoLabel;
}

- (UILabel *)contentLabel {
    if (!_contentLabel) {
        _contentLabel = [[UILabel alloc]init];
        [_contentLabel setFont:[UIFont systemFontOfSize:13]];
        _contentLabel.textColor = [UIColor colorWithHexString:@"#333333"];
        _contentLabel.textAlignment = NSTextAlignmentLeft;
    }
    return _contentLabel;
}
@end
