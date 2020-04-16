//
//  HomeActionTableViewCell.m
//  ZhongQiBrand
//
//  Created by ios2 on 2019/9/17.
//  Copyright © 2019 CY. All rights reserved.
//

#import "HomeActionTableViewCell.h"

@implementation HomeActionTableViewCell{
    NSMutableArray *_itemCaches;
}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setUpUI];
    }
    return self;
}

-(void)setUpUI
{
    _itemCaches = [NSMutableArray array];
    NSArray *titles = @[
                        @"品牌宗旨",
                        @"参加活动",
                        @"帮助中心",
                        @"中企头条" ];
    NSString *imgNames[] = {
        @"home_ppzz_icon",
        @"home_cjhd_icon",
        @"home_bzzx_icon",
        @"home_zqtt_icon",};
    
    UIButton *lastBtn = nil;
    CGFloat leftSpace = px_scale(58.0f);
    NSInteger itemCount = titles.count;
    CGFloat itemWidth =  px_scale(90.0);
    CGFloat itemSpace = (MAINScreenWidth - leftSpace * 2 - itemCount *itemWidth)/(itemCount - 1);
    for (int i = 0; i < titles.count; i++) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.tag = 100+i;
        [btn setImage:[UIImage imageNamed:imgNames[i]] forState:UIControlStateNormal];
        [self.contentView addSubview:btn];
        [btn addTarget:self action:@selector(actionClicked:) forControlEvents:UIControlEventTouchUpInside];
        UILabel *titleLable = [UILabel new];
        titleLable.font = [UIFont boldSystemFontOfSize:13];
        titleLable.textColor = [UIColor colorWithHexString:@"#737373"];
        titleLable.textAlignment = NSTextAlignmentCenter;
        titleLable.text = titles[i];
        [self.contentView addSubview:titleLable];
        [btn mas_makeConstraints:^(MASConstraintMaker *make) {
            if (lastBtn) {
                make.left.equalTo(lastBtn.mas_right).offset(itemSpace);
            }else{
                make.left.mas_equalTo(leftSpace);
            }
            make.size.mas_equalTo(CGSizeMake(itemWidth, px_scale(90)));
            make.top.mas_equalTo(px_scale(50));
        }];
        [_itemCaches addObject:btn];
        btn.translatesAutoresizingMaskIntoConstraints = NO;
        titleLable.translatesAutoresizingMaskIntoConstraints = NO;
        lastBtn = btn;
        [titleLable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(btn.mas_bottom).offset(px_scale(20.0));
            make.height.mas_equalTo(px_scale(28.0f));
            make.centerX.equalTo(btn);
        }];
    }
    
    UIView *spaceView =[UIView new];
    spaceView.backgroundColor =[UIColor colorWithHexString:@"#F8F8F8"];
    [self.contentView addSubview:spaceView];
    [spaceView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.mas_equalTo(0);
        make.height.mas_equalTo(px_scale(20));
    }];
}

-(void)actionClicked:(UIButton *)sender
{
    NSInteger index = sender.tag  - 100;
    !_homeActionClicked?:_homeActionClicked(index);
}

+(CGFloat)cellHeight
{
    return px_scale(247 + 20);
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

@end


