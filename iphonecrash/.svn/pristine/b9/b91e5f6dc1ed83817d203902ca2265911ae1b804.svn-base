//
//  NewsTableViewCell.m
//  ZhongQiBrand
//
//  Created by iOS on 2019/10/18.
//  Copyright © 2019 CY. All rights reserved.
//

#import "NewsTableViewCell.h"

@interface NewsTableViewCell ()
@property (nonatomic, strong) UIImageView *labaImageView;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *timeLabel;
@property (nonatomic, strong) UIView *horizonLine;
@end

@implementation NewsTableViewCell

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
    NewsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellID];
    if (cell == nil) {
        cell = [[NewsTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellID];
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
    [self.contentView addSubview:self.labaImageView];
    [self.contentView addSubview:self.titleLabel];
    [self.contentView addSubview:self.timeLabel];
    [self.contentView addSubview:self.horizonLine];
    
    [self.labaImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15 * scaleX);
        make.width.mas_equalTo(17 * scaleX);
        make.height.mas_equalTo(14 * scaleX);
        make.top.mas_equalTo(20 * scaleX);
    }];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.labaImageView.mas_right).offset(13 * scaleX);
        make.centerY.equalTo(self.labaImageView.mas_centerY).offset(0);
        make.right.mas_equalTo(-15 * scaleX);
        
    }];
    
    [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.titleLabel.mas_left).offset(0);
        make.right.mas_equalTo(-15 * scaleX);
        make.bottom.mas_equalTo(-15 * scaleX);
    }];
    
    [self.horizonLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(0);
        make.left.mas_equalTo(15 * scaleX);
        make.right.mas_equalTo(-15 * scaleX);
        make.height.mas_equalTo(1 * scaleX);
    }];
 
}

- (void)setNewsModel:(NewsModel *)newsModel{
    _newsModel = newsModel;
    self.titleLabel.text = newsModel.title;
    self.timeLabel.text = [NSString stringWithFormat:@"发布时间：%@",newsModel.timer];
}


#pragma mark - 懒加载
- (UIImageView *)labaImageView {
    if (!_labaImageView) {
        _labaImageView = [[UIImageView alloc]init];
        _labaImageView.contentMode = UIViewContentModeScaleAspectFit;
        _labaImageView.image = [UIImage imageNamed:@"sz_laba_icon"];
    }
    return _labaImageView;
}

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc]init];
        _titleLabel.textColor  = [UIColor blackColor];
        _titleLabel.textAlignment = NSTextAlignmentLeft;
        _titleLabel.font = [UIFont systemFontOfSize:17];
    }
    return _titleLabel;
}

- (UILabel *)timeLabel {
    if (!_timeLabel) {
        _timeLabel = [[UILabel alloc]init];
        _timeLabel.textColor = [UIColor colorWithHexString:@"#A7A7A7"];
        _timeLabel.textAlignment = NSTextAlignmentLeft;
        _timeLabel.font = [UIFont systemFontOfSize:12];
    }
    return _timeLabel;
}

- (UIView *)horizonLine {
    if (!_horizonLine) {
        _horizonLine = [[UIView alloc]init];
        _horizonLine.backgroundColor = [UIColor colorWithHexString:@"#E6E6E6"];
    }
    return _horizonLine;
}

@end
