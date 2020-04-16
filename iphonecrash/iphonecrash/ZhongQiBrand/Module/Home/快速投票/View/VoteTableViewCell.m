//
//  VoteTableViewCell.m
//  ZhongQiBrand
//
//  Created by 孙程 on 2019/9/17.
//  Copyright © 2019 CY. All rights reserved.
//

#import "VoteTableViewCell.h"

@interface VoteTableViewCell ()
@property (nonatomic, strong) UIImageView *iconImgView;
@property (nonatomic, strong) UILabel     *titleLab;
@property (nonatomic, strong) UILabel     *votenumLab;

@property (nonatomic, strong) UIButton    *voteBtn;

@property (nonatomic, strong) UIImageView *tagImgView;

@property (nonatomic, strong) UILabel     *tagnumLab;

@property (nonatomic, strong) UIImageView *upOrDownImgView;

@property (nonatomic,strong)UILabel *activityStateLable; //活动状态的标签 这里不使用按钮


/** 品牌名称 */
@property (nonatomic,strong) UILabel *brandName;
/** 公司detatl名字 */
@property (nonatomic,strong) UILabel *detailTitle;
/** 网址 */
@property (nonatomic,strong) UILabel *webAddress;

//设置背景图片
@property (nonatomic,strong)UIImageView *bgImageView;//背景图片

@end

@implementation VoteTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = [[UIColor whiteColor]colorWithAlphaComponent:0];
        [self setUpUI];
    }
    return self;
}

- (void)setUpUI{
	[self.contentView addSubview:self.bgImageView];
	[self.contentView addSubview:self.activityStateLable];//添加活动状态图片
    [self.contentView addSubview:self.iconImgView];         //logo 图标
    [self.contentView addSubview:self.voteBtn];             //投票按钮
    [self.contentView addSubview:self.titleLab];           //大标题
    [self.contentView addSubview:self.detailTitle];        //详情标题
    [self.contentView addSubview:self.webAddress];         //官网地址
    [self.contentView addSubview:self.brandName];          //品牌名
    [self.contentView addSubview:self.votenumLab];         //票数标签
    [self.contentView addSubview:self.upOrDownImgView];  //上升或者下降图片
    [self.contentView addSubview:self.tagnumLab]; //排名数字
    [self.contentView addSubview:self.tagImgView]; //排名背景图片
//处理约束
	[self.tagnumLab mas_makeConstraints:^(MASConstraintMaker *make) {
		make.left.equalTo(self.iconImgView.mas_left);
		make.top.equalTo(self.iconImgView.mas_top);
		make.width.height.mas_equalTo(px_scale(36));
	}];

	[self.tagImgView mas_makeConstraints:^(MASConstraintMaker *make) {
		make.left.equalTo(self.iconImgView.mas_left).offset(px_scale(8));
		make.top.equalTo(self.iconImgView.mas_top);
	}];
	[self.upOrDownImgView mas_makeConstraints:^(MASConstraintMaker *make) {
		make.centerY.equalTo(self.votenumLab);
		make.left.equalTo(self.votenumLab.mas_right).offset(px_scale(8));
		make.width.mas_equalTo(px_scale(20));
		make.height.mas_equalTo(px_scale(22));
	}];
}

- (void)voteBtnClick:(UIButton *)btn{
    !self.buttonClickBlock?:self.buttonClickBlock(self);
}
- (void)setModel:(VoteModel *)model{
    if (model) {
        _model = model;
		// ===============================================================================
		//设置一些基础默认值
		{
		   self.brandName.text = nil;
		   self.detailTitle.text = nil;
		   self.webAddress.text = nil;
		   self.bgImageView.clipsToBounds = NO;                       //设置背景图片是否允许剪切
		   self.bgImageView.backgroundColor = [UIColor clearColor];   //设置背景图片颜色
		   [self.iconImgView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@", model.icon]] placeholderImage:kGetImage(@"tpsq_btn_img")];
		   self.titleLab.text = [NSString stringWithFormat:@"%@", model.title];
		   self.votenumLab.text = model.votenum;
		   self.tagnumLab.text = [NSString stringWithFormat:@"%@", model.index];// 排名标签
		   self.voteBtn.backgroundColor =[[UIColor whiteColor] colorWithAlphaComponent:0];
		}
		// ===============================================================================
		//设置 排名标签 ------
		{
		   if ([model.index integerValue] > 10) {
			   self.tagnumLab.textColor = [UIColor colorWithHexString:@"#999999"];
			   self.tagnumLab.backgroundColor = [UIColor colorWithHexString:@"#E9E9E9"];
		   }else{
			   self.tagnumLab.textColor = [UIColor whiteColor];
			   self.tagnumLab.backgroundColor = [UIColor colorWithHexString:@"#D3141C"];
		   }
		}
		// ===============================================================================
        NSString *imgName = [NSString stringWithFormat:@"jxz_jp%@_icon", model.index];
        self.tagImgView.image = [UIImage imageNamed:imgName];

        if (model.updown == ArrowNomalType) {
            self.upOrDownImgView.hidden = YES; //正常状态
        }
        else if (model.updown == ArrowUpType){//上升状态
            self.upOrDownImgView.image = kGetImage(@"tpjxz_ssjt_icon");
        }
        else if (model.updown == ArrowDownType){//下降状态
            self.upOrDownImgView.image = kGetImage(@"tpjxz_xjjt_icon");
        }
		// ===============================================================================
        if (model.type == ActivityNotStartedState) {
			// 活动未开始
			self.bgImageView.image = [UIImage imageNamed:@"dtbj_hdwk_img"];
            self.voteBtn.userInteractionEnabled = NO;
			self.voteBtn.hidden = YES;
			self.activityStateLable.text = @"活动未开始~";
            [self.voteBtn setTitleColor:[UIColor colorWithHexString:@"#999999"] forState:UIControlStateNormal];
            [self.voteBtn setBackgroundImage:nil forState:UIControlStateNormal];
            self.upOrDownImgView.hidden = YES;
            [self iconImgViewBoderColor:[UIColor colorWithHexString:@"#E9E9E9"] borderWidth:px_scale(2) cornerRadius:px_scale(10)];
			self.votenumLab.text = nil;//设置活动未开始为空
        }else if (model.type == ActivityInProgressState){ // 进行中
            self.voteBtn.userInteractionEnabled = YES;
			self.voteBtn.hidden = NO;
            [self.voteBtn setTitle:@"投票" forState:UIControlStateNormal];
            [self.voteBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            [self.voteBtn setBackgroundImage:kGetImage(@"tpsq_btn_img") forState:UIControlStateNormal];
            self.upOrDownImgView.hidden = NO;
            [self setIconImgViewBoderStyle:model];
			self.activityStateLable.text = @"";
			self.bgImageView.image = [UIImage imageNamed:@"tpjxz_dw_img"]; //设置纹理背景
        }else if (model.type == ActivityEndInThreeDayState){ // 活动已结束_三天内
            self.voteBtn.userInteractionEnabled = NO;
			self.bgImageView.image = [UIImage imageNamed:@"tpjxz_dw_img"]; //设置纹理背景
			self.activityStateLable.text = @"已结束~";
			self.voteBtn.hidden = YES;
            [self.voteBtn setTitleColor:[UIColor colorWithHexString:@"#999999"] forState:UIControlStateNormal];
            [self.voteBtn setBackgroundImage:nil forState:UIControlStateNormal];
            self.upOrDownImgView.hidden = YES;
            [self setIconImgViewBoderStyle:model];
        } else if (model.type == ActivityEndOutThreeDayState){ // 活动已结束_三天后
            self.voteBtn.userInteractionEnabled = NO;
			self.activityStateLable.text = @"已结束~";
			self.bgImageView.image = [UIImage imageNamed:@"dtbj_hdwk_img"];
			self.voteBtn.hidden = YES;
			self.votenumLab.text = nil;
            [self.voteBtn setTitleColor:[UIColor colorWithHexString:@"#999999"] forState:UIControlStateNormal];
            [self.voteBtn setBackgroundImage:nil forState:UIControlStateNormal];
            self.upOrDownImgView.hidden = YES;
            [self iconImgViewBoderColor:[UIColor colorWithHexString:@"#E9E9E9"] borderWidth:px_scale(2) cornerRadius:px_scale(10)];
        } else if (model.type == ActivityUnCoverInThreeDayState ||
				 model.type == ActivityUnCoverOutThreeDayState){ // 已揭榜_三天内 已揭榜_三天后
            self.voteBtn.userInteractionEnabled = YES;
			self.voteBtn.hidden = NO;
			self.activityStateLable.text = nil;
            [self.voteBtn setTitle:@"申请奖牌" forState:UIControlStateNormal];
            [self.voteBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            [self.voteBtn setBackgroundImage:kGetImage(@"tpsq_btn_img") forState:UIControlStateNormal];
            self.upOrDownImgView.hidden = YES;
            [self setIconImgViewBoderStyle:model];
			self.bgImageView.image = [UIImage imageNamed:@"tpjxz_dw_img"]; //设置纹理背景
			if (model.type==ActivityUnCoverOutThreeDayState) {
				self.votenumLab.text = nil; //超过三天不进行显示票数
			}
			self.voteBtn.backgroundColor = [[UIColor whiteColor]colorWithAlphaComponent:0];
        } else if(model.type == ActivityListFinalState){//榜单
            self.votenumLab.text = nil;
			self.brandName.text = model.brandName;
			self.detailTitle.text = model.detailTitle;
			self.webAddress.text = model.webAddress;
            self.voteBtn.userInteractionEnabled = YES;
			self.voteBtn.hidden = NO;
            [self.voteBtn setTitle:@"申请奖牌" forState:UIControlStateNormal];
            [self.voteBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            [self.voteBtn.titleLabel setFont:[UIFont systemFontOfSize:12]];
            self.voteBtn.backgroundColor = [UIColor colorWithHexString:@"#CD1B22"];
            self.upOrDownImgView.hidden = YES;
            [self setIconImgViewBoderStyle:model];
            self.voteBtn.layer.cornerRadius =px_scale(25);
            self.voteBtn.layer.masksToBounds = YES;
			self.activityStateLable.text = nil;
			self.bgImageView.image = [UIImage imageNamed:@"bd_dws_img"];
			self.bgImageView.backgroundColor = [UIColor whiteColor];
			self.bgImageView.clipsToBounds = YES;
		}

//左侧排名设置
		if (model.type != ActivityNotStartedState &&
			model.type != ActivityEndOutThreeDayState) {
			if ([model.index integerValue] < 4) {
				self.tagnumLab.hidden = YES;
			}else{
				self.tagnumLab.hidden = NO;
			}
			if ([model.index integerValue] > 3) {
				self.tagImgView.hidden = YES;
			}else{
				self.tagImgView.hidden = NO;
			}
		} else{
			self.tagnumLab.hidden = YES;
			self.tagImgView.hidden = YES;
		}
		//重置约束 ===================================
		[self setLayoutWithActivityType:model.type];
    }
}

-(void)setLayoutWithActivityType:(ActivityState)type
{
	if (type== ActivityNotStartedState||
		type==ActivityEndOutThreeDayState)
	 {
	    //活动未开始约束
		[self.bgImageView mas_remakeConstraints:^(MASConstraintMaker *make) {
			make.width.mas_equalTo(px_scale(720));
			make.centerX.mas_equalTo(0);
			make.top.mas_equalTo(0);
			make.height.mas_equalTo(px_scale(198));
			make.bottom.equalTo(self.contentView);
		}];

		[self.iconImgView mas_remakeConstraints:^(MASConstraintMaker *make) {
			make.left.mas_equalTo(px_scale(55));
			make.top.mas_equalTo(px_scale(38));
			make.size.mas_equalTo(CGSizeMake(px_scale(203), px_scale(118)));
		}];

		[self.titleLab mas_remakeConstraints:^(MASConstraintMaker *make) {
			make.centerY.equalTo(self.iconImgView);
			make.height.mas_equalTo(px_scale(45));
			make.right.mas_equalTo(self.activityStateLable.mas_left);
			make.left.mas_equalTo(self.iconImgView.mas_right).offset(px_scale(20));
		}];

		[self.activityStateLable mas_remakeConstraints:^(MASConstraintMaker *make) {
			make.right.mas_equalTo(-px_scale(78));
			make.centerY.equalTo(self.titleLab);
			if (type==ActivityEndOutThreeDayState) {
				make.width.mas_equalTo(px_scale(100));
			}else{
				make.width.mas_equalTo(px_scale(160));
			}
			make.height.mas_equalTo(px_scale(50));
		}];
	}else if (type==ActivityInProgressState||
			  type==ActivityEndInThreeDayState||
			  type == ActivityUnCoverInThreeDayState||
			  type == ActivityUnCoverOutThreeDayState){
		//活动进行中的约束
		[self.bgImageView mas_remakeConstraints:^(MASConstraintMaker *make) {
			make.left.mas_equalTo(px_scale(15));
			make.right.mas_equalTo(-px_scale(15));
			make.top.mas_equalTo(0);
			make.height.mas_equalTo(px_scale(198));
			make.bottom.equalTo(self.contentView);
		}];

		[self.iconImgView mas_remakeConstraints:^(MASConstraintMaker *make) {
			make.left.mas_equalTo(px_scale(55));
			make.top.mas_equalTo(px_scale(40));
			make.size.mas_equalTo(CGSizeMake(px_scale(203), px_scale(118)));
		}];

		[self.votenumLab mas_remakeConstraints:^(MASConstraintMaker *make) {
			make.left.equalTo(self.titleLab);
			make.top.equalTo(self.titleLab.mas_bottom).offset(px_scale(20));
			make.height.mas_equalTo(px_scale(33));
		}];
		if (type==ActivityEndInThreeDayState) {
			[self.activityStateLable mas_remakeConstraints:^(MASConstraintMaker *make) {
				make.right.mas_equalTo(-px_scale(78));
				make.top.mas_equalTo(px_scale(80));
				make.width.mas_equalTo(px_scale(100));
				make.height.mas_equalTo(px_scale(50));
			}];
			[self.titleLab mas_remakeConstraints:^(MASConstraintMaker *make) {
				make.top.mas_equalTo(px_scale(55));
				make.height.mas_equalTo(px_scale(45));
				make.right.mas_equalTo(self.activityStateLable.mas_left);
				make.left.mas_equalTo(self.iconImgView.mas_right).offset(px_scale(20));
			}];
		}else{
			[self.voteBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
				make.top.mas_equalTo(px_scale(57));
				make.right.mas_equalTo(-px_scale(40));
				make.height.mas_equalTo(px_scale(88));
				if (type == ActivityEndOutThreeDayState) {
					make.width.mas_equalTo(px_scale(160));
				}else{
					make.width.mas_equalTo(px_scale(158));
				}
			}];
			[self.titleLab mas_remakeConstraints:^(MASConstraintMaker *make) {
				if (type==ActivityUnCoverOutThreeDayState) {
					//超过三天的
					make.centerY.equalTo(self.iconImgView);
				}else{
					make.top.mas_equalTo(px_scale(55));
				}
				make.height.mas_equalTo(px_scale(45));
				make.right.mas_equalTo(self.voteBtn.mas_left);
				make.left.mas_equalTo(self.iconImgView.mas_right).offset(px_scale(20));
			}];
		}
	}else if (type == ActivityListFinalState){
		//最终的榜单
		//bd_dws_img
		[self.bgImageView mas_remakeConstraints:^(MASConstraintMaker *make) {
			make.left.mas_equalTo(px_scale(30));
			make.right.mas_equalTo(-px_scale(30));
			make.height.mas_equalTo(px_scale(217));
			make.top.mas_equalTo(px_scale(30));
			make.bottom.equalTo(self.contentView);
		}];

		[self.iconImgView mas_remakeConstraints:^(MASConstraintMaker *make) {
			make.left.mas_equalTo(px_scale(55));
			make.top.equalTo(self.bgImageView).offset(px_scale(25));
			make.size.mas_equalTo((CGSize){px_scale(203),px_scale(118)});
		}];

		[self.brandName mas_remakeConstraints:^(MASConstraintMaker *make) {
			make.left.equalTo(self.iconImgView.mas_right).offset(px_scale(40));
			make.top.equalTo(self.bgImageView).offset(px_scale(37));
			make.height.mas_equalTo(px_scale(33));
		}];

		[self.detailTitle mas_remakeConstraints:^(MASConstraintMaker *make) {
			make.top.equalTo(self.brandName.mas_bottom).offset(px_scale(16));
			make.left.equalTo(self.brandName);
			make.height.mas_equalTo(px_scale(33));
			make.right.equalTo(self.bgImageView).offset(-px_scale(10));
		}];

		[self.webAddress mas_remakeConstraints:^(MASConstraintMaker *make) {
			make.top.equalTo(self.detailTitle.mas_bottom).offset(px_scale(16));
			make.left.equalTo(self.detailTitle);
			make.height.mas_equalTo(px_scale(33));
			make.right.equalTo(self.bgImageView).offset(-px_scale(10));
		}];

		[self.titleLab mas_remakeConstraints:^(MASConstraintMaker *make) {
			make.centerX.equalTo(self.iconImgView);
			make.width.mas_lessThanOrEqualTo(px_scale(220));
			make.bottom.equalTo(self.bgImageView).offset(px_scale(-16));
			make.height.mas_equalTo(px_scale(40));
		}];
		[self.voteBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
			make.right.mas_equalTo(-px_scale(52));
			make.width.mas_equalTo(px_scale(115));
			make.height.mas_equalTo(px_scale(50));
			make.centerY.equalTo(self.brandName);
		}];

	}

}
- (void)setIconImgViewBoderStyle:(VoteModel *)m{
    if ([m.index integerValue] == 1) {
        [self iconImgViewBoderColor:[UIColor colorWithHexString:@"#FAE04B"] borderWidth:px_scale(6) cornerRadius:px_scale(10)];
    }
    else if ([m.index integerValue] == 2){
        [self iconImgViewBoderColor:[UIColor colorWithHexString:@"#AEAEAE"] borderWidth:px_scale(6) cornerRadius:px_scale(10)];
    }
    else if ([m.index integerValue] == 3){
        [self iconImgViewBoderColor:[UIColor colorWithHexString:@"#F4AE83"] borderWidth:px_scale(6) cornerRadius:px_scale(10)];
    }
    else{
        [self iconImgViewBoderColor:[UIColor colorWithHexString:@"#E9E9E9"] borderWidth:px_scale(2) cornerRadius:px_scale(10)];
    }
}
//设置图片的边框线以及圆角
- (void)iconImgViewBoderColor:(UIColor *)color
				  borderWidth:(CGFloat)borderWidth
				 cornerRadius:(CGFloat)cornerRadius
{
    self.iconImgView.layer.cornerRadius = cornerRadius;
    self.iconImgView.layer.borderColor = color.CGColor;
    self.iconImgView.layer.borderWidth = borderWidth;
}
#pragma mark - ========= get
- (UIImageView *)iconImgView{
    if (!_iconImgView) {
        _iconImgView = [[UIImageView alloc] init];
        _iconImgView.layer.masksToBounds = YES;
        _iconImgView.layer.cornerRadius = px_scale(10);
        _iconImgView.layer.borderColor = [UIColor colorWithHexString:@"#E9E9E9"].CGColor;
        _iconImgView.layer.borderWidth = px_scale(2);
    }
    return _iconImgView;
}

- (UILabel *)titleLab{
    if (!_titleLab) {
        _titleLab = [[UILabel alloc] init];
        _titleLab.textColor = [UIColor colorWithHexString:@"#333333"];
        _titleLab.font = [UIFont boldSystemFontOfSize:16];
        _titleLab.text = @"-";
        _titleLab.numberOfLines = 1;
    }
    return _titleLab;
}

- (UILabel *)votenumLab{
    if (!_votenumLab) {
        _votenumLab = [[UILabel alloc] init];
        _votenumLab.textColor = [UIColor colorWithHexString:@"#666666"];
        _votenumLab.font = [UIFont systemFontOfSize:12];
        _votenumLab.numberOfLines = 1;
    }
    return _votenumLab;
}

- (UIButton *)voteBtn{
    if (!_voteBtn) {
        _voteBtn = [[UIButton alloc] init];
        [_voteBtn setBackgroundImage:kGetImage(@"tpsq_btn_img") forState:UIControlStateNormal];
        _voteBtn.titleLabel.font = [UIFont systemFontOfSize:13];
        [_voteBtn addTarget:self action:@selector(voteBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _voteBtn;
}

- (UILabel *)tagnumLab{
    if (!_tagnumLab) {
        _tagnumLab = [[UILabel alloc] init];
        _tagnumLab.textColor = [UIColor whiteColor];
        _tagnumLab.backgroundColor = [UIColor colorWithHexString:@"#D3141C"];
        _tagnumLab.font = [UIFont boldSystemFontOfSize:11];
        _tagnumLab.textAlignment = NSTextAlignmentCenter;
		UIView *maskView = [UIView new];
		maskView.frame = CGRectMake(0, 0, 100, 100);
		maskView.layer.cornerRadius = px_scale(10);
		maskView.backgroundColor = [UIColor whiteColor];
		_tagnumLab.maskView = maskView;
    }
    return _tagnumLab;
}


- (UIImageView *)tagImgView
{
    if (!_tagImgView) {
        _tagImgView = [[UIImageView alloc] init];
    }
    return _tagImgView;
}

- (UIImageView *)upOrDownImgView
{
    if (!_upOrDownImgView) {
        _upOrDownImgView = [[UIImageView alloc] init];
    }
    return _upOrDownImgView;
}

- (UILabel *)brandName {
    if (!_brandName) {
        _brandName = [[UILabel alloc]init];
        _brandName.textColor = [UIColor colorWithHexString:@"#333333"];
        _brandName.textAlignment = NSTextAlignmentCenter;
        _brandName.font = [UIFont boldSystemFontOfSize:15];
    }
    return _brandName;
}

- (UILabel *)detailTitle {
    if (!_detailTitle) {
        _detailTitle = [[UILabel alloc]init];
        _detailTitle.textColor = [UIColor colorWithHexString:@"#333333"];
        _detailTitle.textAlignment = NSTextAlignmentLeft;
        _detailTitle.font = [UIFont systemFontOfSize:12];
    }
    return _detailTitle;
}

- (UILabel *)webAddress {
    if (!_webAddress) {
        _webAddress = [[UILabel alloc]init];
        _webAddress.textColor = [UIColor colorWithHexString:@"#333333"];
        _webAddress.textAlignment = NSTextAlignmentLeft;
         _webAddress.font = [UIFont systemFontOfSize:12];
    }
    return _webAddress;
}

-(UIImageView *)bgImageView
{
	if (!_bgImageView) {
		_bgImageView = [[UIImageView alloc]init];
		_bgImageView.layer.cornerRadius = px_scale(20);
	 }
	return _bgImageView;
}

-(UILabel *)activityStateLable
{
	if (!_activityStateLable) {
		_activityStateLable = [[UILabel alloc]init];
		_activityStateLable.textColor = [UIColor colorWithHexString:@"#999999"];
		_activityStateLable.font = [UIFont systemFontOfSize:13];
		_activityStateLable.textAlignment = NSTextAlignmentRight;
	 }
	return _activityStateLable;
}

- (void)awakeFromNib {
    [super awakeFromNib];
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

@end
