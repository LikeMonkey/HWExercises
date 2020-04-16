//
//  SharePopView.m
//  ZhongQiBrand
//
//  Created by iOS on 2019/10/24.
//  Copyright © 2019 CY. All rights reserved.
//

#import "SharePopView.h"
#import "UIWindow+FrontWindow.h"
#import <WXApi.h>

@interface SharePopView ()
//缓存值 ~
@property (nonatomic,strong)ShareInfoModel *info;
@end

@implementation SharePopView
+(instancetype)showShare {
    SharePopView * popView = [[SharePopView alloc]init];
    UIWindow *window = [UIWindow frontWindow];
    [window addSubview:popView];
    return popView;
}

-(instancetype)init {
    self = [super init];
    if (self) {
        self.frame = [UIScreen mainScreen].bounds;
        self.backgroundColor = [[UIColor blackColor]colorWithAlphaComponent:0.5];
        [self setUpUI];
    }
    return self;
}

- (void)setUpUI {
    
    UIView *shareV = [UIView new];
    shareV.bounds = (CGRect){0,0,355 * scaleX,150 * scaleX};
    CGRect f = shareV.frame;
    f.origin.x = 10 * scaleX;
    f.origin.y = CGRectGetHeight(self.bounds);
    shareV.frame = f;
    f.origin.y = CGRectGetHeight(self.bounds) - 160 * scaleX;
    [self addSubview:shareV];
    _shareV = shareV;
    [UIView animateWithDuration:0.2 animations:^{
        shareV.frame = f;
    }];
    
    UIView *topView = [UIView new];
    topView.backgroundColor = [UIColor colorWithHexString:@"#F1F2F4"];
    topView.layer.cornerRadius = 5 * scaleX;
    topView.layer.masksToBounds = YES;
    [shareV addSubview:topView];
    
    [topView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.top.mas_equalTo(0);
        make.height.mas_equalTo(100 * scaleX);
    }];
    
    NSString *imgNames[] = {
        @"share_wxhy_icon",
        @"share-pyq_icon",
        @"share_qqhy_icon",
        @"share-qqkj_icon"
    };
    
    NSString *titles[] = {
        @"微信好友",@"微信朋友圈",@"QQ好友",@"QQ空间"
    };
    
    for (int i = 0; i < 4; i++) {
        UIButton *shareIconBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        shareIconBtn.tag = 100 + i;
        [shareIconBtn setImage:[UIImage imageNamed:imgNames[i]] forState:UIControlStateNormal];
        [shareIconBtn addTarget:self action:@selector(shareClickAction:) forControlEvents:UIControlEventTouchUpInside];
        
        [topView addSubview:shareIconBtn];
        [shareIconBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(18 * scaleX);
            make.size.mas_equalTo(CGSizeMake(40 * scaleX, 40 * scaleX));
            
            if (i==0) {
                make.left.mas_equalTo(30 * scaleX);
            }else if (i==1){
                make.left.mas_equalTo(115 * scaleX);
            }else if (i==2){
                make.right.mas_equalTo(-115 * scaleX);
            }else{
                make.right.mas_equalTo(-30 * scaleX);
            }
            
        }];
        
        UILabel *titleLable = [UILabel new];
        titleLable.text = titles[i];
        titleLable.textColor = [UIColor colorWithHexString:@"#333333"];
        titleLable.font = [UIFont systemFontOfSize:13];
        titleLable.textAlignment = NSTextAlignmentCenter;
        [topView addSubview:titleLable];
        [titleLable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(shareIconBtn);
            make.top.equalTo(shareIconBtn.mas_bottom).offset(5 * scaleX);
        }];
        
    }
    
    UIButton *cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [cancelBtn addTarget:self action:@selector(cancelClicked:) forControlEvents:UIControlEventTouchUpInside];
    cancelBtn.backgroundColor = [UIColor colorWithHexString:@"#F1F2F4"];
    [cancelBtn setTitleColor:[UIColor colorWithHexString:@"#666666"] forState:UIControlStateNormal];
    [cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
    cancelBtn.titleLabel.font = [UIFont systemFontOfSize:16];
    cancelBtn.layer.cornerRadius = 5 * scaleX;
    cancelBtn.layer.masksToBounds = YES;
    
    [shareV addSubview:cancelBtn];
    [cancelBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(topView);
        make.bottom.mas_equalTo(0);
        make.height.mas_equalTo(40 * scaleX);
    }];
    
}

#pragma mark - Private Method
-(void)shareClickAction:(UIButton *)shareBtn
{
    
    if (self.shareAction) {
        UIImage *shareImge;
        NSInteger index = shareBtn.tag - 100;
        ShareType type = -100;
        
        if (index == 0) {
            type = WXShareType;
        }else if(index == 1) {
            type = WXCircleShareType;
        }else if (index == 2) {
            type = QQShareType;
        }else{
            type = QQZoneType;
        }
        ShareInfoModel *info = self.info;
        if (type == WXShareType||type== WXCircleShareType) {
            // 查看是否安装微信
            if (![WXApi isWXAppInstalled]) {
                SHOW_MSG(@"您未安装微信，请先安装微信", 0.5);
            }
        }else if (type == QQShareType || type == QQZoneType) {
            // 查看是否安装QQ
            
        }
        self.shareAction(type,(UIImage *)info.img);
    }
    if (!self.isNotClose) {
        [self removeFromSuperview];
    }
}

-(void)cancelClicked:(id)sender
{
    self.userInteractionEnabled = NO;
    CGRect f = _shareV.frame;
    f.origin.y = CGRectGetHeight(self.bounds);
    [UIView animateWithDuration:0.2 animations:^{
        self->_shareV.frame = f;
        self.alpha = 0.0;
        [self layoutIfNeeded];
    } completion:^(BOOL finished) {
        if (finished) {
            [self removeFromSuperview];
        }
    }];
}
@end

