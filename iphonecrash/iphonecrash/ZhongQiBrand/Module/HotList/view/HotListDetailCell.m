//
//  HotListDetailCell.m
//  ZhongQiBrand
//
//  Created by iOS on 2019/10/18.
//  Copyright © 2019 CY. All rights reserved.
//

#import "HotListDetailCell.h"

@interface HotListDetailCell ()
/** 背景图 */
@property (nonatomic, strong) UIImageView *bgImgView;
/** 品牌logo */
@property (nonatomic, strong) UIImageView *logoIconImg;
/** 前三奖牌序号 */
@property (nonatomic, strong) UIImageView *topThreeMedalNum;
/** 其余奖牌序号 */
@property (nonatomic, strong) UILabel *otherMedalNum;
/** 品牌名称 */
@property (nonatomic, strong) UILabel *brandName;
/** 公司名称 */
@property (nonatomic, strong) UILabel *companyName;
/** 公司地址 */
@property (nonatomic, strong) UILabel *companyAddress;
/** 公司网址 */
@property (nonatomic, strong) UILabel *companyUrl;

@end

@implementation HotListDetailCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

+ (instancetype)cellWithTableView:(UITableView *)tableView {
    static NSString *CellID = @"HotListDetailCell";
    HotListDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:CellID];
    if (cell == nil) {
        cell = [[HotListDetailCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellID];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return cell;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.backgroundColor = [UIColor clearColor];
        [self.contentView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_offset(px_scale(30));
            make.right.mas_offset(px_scale(-30));
            make.top.mas_offset(px_scale(20));
            make.bottom.mas_equalTo(self);
        }];
        
        [self setUpUI];
    }
    return self;
}

- (void)setUpUI {
    
    [self.contentView addSubview:self.bgImgView];
    [self.contentView addSubview:self.logoIconImg];
    [self.contentView addSubview:self.brandName];
    [self.contentView addSubview:self.companyName];
    [self.contentView addSubview:self.companyAddress];
    [self.contentView addSubview:self.companyUrl];
    [self.contentView addSubview:self.topThreeMedalNum];
    [self.contentView addSubview:self.otherMedalNum];
    
    [_bgImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(0);
        make.right.mas_offset(0);
        make.top.mas_offset(0);
        make.bottom.mas_equalTo(0);;
    }];
    
    [_logoIconImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.mas_equalTo(12.5 * scaleX);
        make.width.mas_equalTo(101.5 * scaleX);
        make.height.mas_equalTo(59 * scaleX);
    }];
    
    [_brandName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.logoIconImg.mas_centerX).offset(0);
        make.bottom.mas_equalTo(-8 * scaleX);
    }];
    
    [_companyName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.logoIconImg.mas_right).offset(20 * scaleX);
        make.top.mas_equalTo(18 * scaleX);
        make.right.mas_equalTo(20 * scaleX);
    }];
    
    [_companyName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.logoIconImg.mas_right).offset(20 * scaleX);
        make.top.mas_equalTo(18 * scaleX);
        make.right.mas_equalTo(-20 * scaleX);
    }];
    
    [_companyAddress mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.logoIconImg.mas_right).offset(20 * scaleX);
        make.top.equalTo(self.companyName.mas_bottom).offset(8 * scaleX);
        make.right.mas_equalTo(-20 * scaleX);
    }];
    
    [_companyUrl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.logoIconImg.mas_right).offset(20 * scaleX);
        make.top.equalTo(self.companyAddress.mas_bottom).offset(8 * scaleX);
        make.right.mas_equalTo(-20 * scaleX);
    }];
    
    [_topThreeMedalNum mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.logoIconImg.mas_left).offset(0);
        make.top.equalTo(self.logoIconImg.mas_top).offset(0);
        make.width.mas_equalTo(19 * scaleX);
        make.height.mas_equalTo(26 * scaleX);
    }];
    
    [_otherMedalNum mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.logoIconImg.mas_left).offset(0);
        make.top.equalTo(self.logoIconImg.mas_top).offset(0);
        make.width.mas_equalTo(13 * scaleX);
        make.height.mas_equalTo(18 * scaleX);
    }];
}

#pragma mark - set
- (void)setModel:(HotListDetailModel *)model {
    _model = model;
    
    [self.logoIconImg sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@", model.thumb]] placeholderImage:kGetImage(@"")];
    self.brandName.text = model.title;
    self.companyName.text = model.company;
    self.companyAddress.text = model.address;
    self.companyUrl.text = model.homepage;
    
    if (model.ranking.intValue < 4) {
        self.topThreeMedalNum.hidden = NO;
        self.otherMedalNum.hidden = YES;
        self.topThreeMedalNum.image = [UIImage imageNamed:[NSString stringWithFormat:@"jxz_jp%d_icon",model.ranking.intValue]];
    }else {
        self.topThreeMedalNum.hidden = YES;
        self.otherMedalNum.hidden = NO;
        self.otherMedalNum.text = model.ranking;
    }
    
    [self setIconImgViewBoderStyle:model];
}

- (void)setIconImgViewBoderStyle:(HotListDetailModel *)m{
    if ([m.ranking integerValue] == 1) {
        [self iconImgViewBoderColor:[UIColor colorWithHexString:@"#FAE04B"] borderWidth:px_scale(6) cornerRadius:px_scale(10)];
    }
    else if ([m.ranking integerValue] == 2){
        [self iconImgViewBoderColor:[UIColor colorWithHexString:@"#AEAEAE"] borderWidth:px_scale(6) cornerRadius:px_scale(10)];
    }
    else if ([m.ranking integerValue] == 3){
        [self iconImgViewBoderColor:[UIColor colorWithHexString:@"#F4AE83"] borderWidth:px_scale(6) cornerRadius:px_scale(10)];
    }
    else{
        [self iconImgViewBoderColor:[UIColor colorWithHexString:@"#E9E9E9"] borderWidth:px_scale(2) cornerRadius:px_scale(10)];
    }
}

- (void)iconImgViewBoderColor:(UIColor *)color borderWidth:(CGFloat)borderWidth cornerRadius:(CGFloat)cornerRadius{
    self.logoIconImg.layer.cornerRadius = cornerRadius;
    self.logoIconImg.layer.borderColor = color.CGColor;
    self.logoIconImg.layer.borderWidth = borderWidth;
}

#pragma mark - 懒加载

- (UIImageView *)bgImgView {
    if (!_bgImgView) {
        _bgImgView = [[UIImageView alloc]init];
        _bgImgView.contentMode = UIViewContentModeScaleAspectFit;
        _bgImgView.image = [UIImage imageNamed:@"bd_bgview_img"];
    }
    return _bgImgView;
}

- (UIImageView *)logoIconImg{
    if (!_logoIconImg) {
        _logoIconImg = [[UIImageView alloc] init];
        _logoIconImg.layer.masksToBounds = YES;
        _logoIconImg.layer.cornerRadius = px_scale(10);
        _logoIconImg.layer.borderColor = [UIColor colorWithHexString:@"#E9E9E9"].CGColor;
        _logoIconImg.layer.borderWidth = px_scale(2);
    }
    return _logoIconImg;
}

- (UILabel *)brandName{
    if (!_brandName) {
        _brandName = [[UILabel alloc] init];
        _brandName.textColor = [UIColor colorWithHexString:@"#333333"];
        _brandName.font = [UIFont boldSystemFontOfSize:15];
        _brandName.textAlignment = NSTextAlignmentCenter;
    }
    return _brandName;
}

- (UILabel *)companyName{
    if (!_companyName) {
        _companyName = [[UILabel alloc] init];
        _companyName.textColor = [UIColor colorWithHexString:@"#333333"];
        _companyName.font = [UIFont systemFontOfSize:12];
        _companyName.textAlignment = NSTextAlignmentLeft;
    }
    return _companyName;
}

- (UILabel *)otherMedalNum{
    if (!_otherMedalNum) {
        _otherMedalNum = [[UILabel alloc] init];
        _otherMedalNum.textColor = [UIColor whiteColor];
        _otherMedalNum.backgroundColor = [UIColor colorWithHexString:@"#D3141C"];
        _otherMedalNum.font = [UIFont boldSystemFontOfSize:11];
        _otherMedalNum.textAlignment = NSTextAlignmentCenter;
    }
    return _otherMedalNum;
}

- (UIImageView *)topThreeMedalNum
{
    if (!_topThreeMedalNum) {
        _topThreeMedalNum = [[UIImageView alloc] init];
        _topThreeMedalNum.contentMode = UIViewContentModeScaleAspectFit;
    }
    return _topThreeMedalNum;
}

- (UILabel *)companyAddress {
    if (!_companyAddress) {
        _companyAddress = [[UILabel alloc]init];
        _companyAddress.textColor = [UIColor colorWithHexString:@"#333333"];
        _companyAddress.textAlignment = NSTextAlignmentLeft;
        _companyAddress.font = [UIFont systemFontOfSize:12];
    }
    return _companyAddress;
}

- (UILabel *)companyUrl {
    if (!_companyUrl) {
        _companyUrl = [[UILabel alloc]init];
        _companyUrl.textColor = [UIColor colorWithHexString:@"#333333"];
        _companyUrl.textAlignment = NSTextAlignmentLeft;
        _companyUrl.font = [UIFont systemFontOfSize:12];
    }
    return _companyUrl;
}

@end
