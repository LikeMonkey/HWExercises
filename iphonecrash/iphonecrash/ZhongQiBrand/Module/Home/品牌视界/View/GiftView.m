//
//  text.h
//  giftDemo
//
//  Created by ios 001 on 2019/10/11.
//  Copyright © 2019 flymanshow. All rights reserved.
//

#import "GiftView.h"
#import "CollectionViewFlowLayout.h"

#define padding px_scale(12)
#define GiftHeight px_scale(749)

@interface CollectionCell : UICollectionViewCell
/**礼物图 */
@property(nonatomic,strong) UIImageView *iconImg;
/** 礼物名称 */
@property(nonatomic,strong) UILabel *titleLabel;
/** 贡献数量 */
@property(nonatomic,strong) UILabel *disNum;
/** 左上角价钱小图 */
@property (nonatomic,strong) UIImageView * priceView;
/** 价钱 */
@property (nonatomic,strong) UILabel *price;
@end

@implementation CollectionCell
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.contentView.layer.cornerRadius = px_scale(10);
        self.contentView.layer.masksToBounds=YES;
        self.contentView.layer.borderWidth = 1.0f;
        self.contentView.layer.borderColor = [UIColor colorWithHexString:@"#CECECE"].CGColor;

        //选中部分边框变色
        UIView* selectedBGView = [[UIView alloc] initWithFrame:frame];
        selectedBGView.layer.cornerRadius = px_scale(10);
        selectedBGView.layer.masksToBounds=YES;
        selectedBGView.layer.borderWidth = 1.0f;
        selectedBGView.backgroundColor = [UIColor clearColor];
        selectedBGView.layer.borderWidth = px_scale(4);
        selectedBGView.layer.borderColor = [UIColor colorWithHexString:@"#C03128"].CGColor;
        self.selectedBackgroundView = selectedBGView;
        [self setUpUI];
    }
    return self;
}
-(void)setUpUI{
    [self.contentView addSubview:self.iconImg];
    [self.contentView addSubview:self.titleLabel];
    [self.contentView addSubview:self.disNum];
    [self.contentView addSubview:self.priceView];
    [self.contentView addSubview:self.price];
    
    [self.iconImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.contentView);
        make.top.mas_offset(px_scale(18));
        make.height.width.mas_equalTo(px_scale(110));
    }];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.iconImg.mas_bottom);
        make.centerX.mas_equalTo(self.iconImg);
    }];
    [self.disNum mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.titleLabel.mas_bottom);
        make.centerX.mas_equalTo(self.titleLabel);
    }];
    [self.priceView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.mas_offset(0);
    }];
    [self.price mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.priceView);
        make.left.mas_offset(0);
    }];
}
#pragma mark ——— lazy

- (UIImageView *)iconImg {
    if (!_iconImg) {
        _iconImg = [[UIImageView alloc]init];
    }
    return _iconImg;
}

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel =  [[UILabel alloc] init];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.textColor = [UIColor blackColor];
        _titleLabel.font = [UIFont boldSystemFontOfSize:px_scale(24)];;
    }
    return _titleLabel;
}

- (UILabel *)disNum {
    if (!_disNum) {
        _disNum = [[UILabel alloc]init];
        _disNum.textColor = [UIColor colorWithHexString:@"#C03128"];
        _disNum.font = [UIFont systemFontOfSize:px_scale(20)];
    }
    return _disNum;
}

- (UIImageView *)priceView {
    if (!_priceView) {
        _priceView = [[UIImageView alloc]init];
        [ _priceView setImage:[UIImage imageNamed:@"gift_pasj_slwy_dt_img"]];
    }
    return _priceView;
}

- (UILabel *)price {
    if (!_price) {
        _price = [[UILabel alloc]init];
        _price.textAlignment  = NSTextAlignmentLeft;
        _price.textColor = [UIColor whiteColor];
        _price.font = [UIFont systemFontOfSize:px_scale(24)];
    }
    return _price;
}
@end

@interface GiftView()<UICollectionViewDelegate,UICollectionViewDataSource>
/** 列表*/
@property(nonatomic,strong)UICollectionView *collectionView;
/** 背景图 */
@property (nonatomic,strong) UIView *bgView;
/** 可点击视图 */
@property (nonatomic,strong) UIView *gesbView;
/** 后续礼物多添加分页 */
//@property(nonatomic, assign) NSUInteger pageCount;
//@property(nonatomic,strong)UIPageControl *PageControl;
@end

@implementation GiftView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [[UIColor blackColor]colorWithAlphaComponent:0.5];
        [self setUpUI];
    }
    return self;
}
-(void)setUpUI{
    [self addSubview:self.bgView];
    [self addSubview:self.gesbView];
    [self.bgView addSubview:self.collectionView];
    [self.bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(self);
        make.bottom.mas_equalTo(self.mas_bottom);
        make.height.mas_equalTo(GiftHeight);
    }];
    [self.bgView addSubview:self.title];
    [self.title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.bgView);
        make.top.mas_offset(px_scale(30));
    }];
    [self.bgView addSubview:self.honerLabel];
    [self.honerLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(px_scale(30));
        make.top.mas_equalTo(self.collectionView.mas_bottom).mas_offset(px_scale(36));
    }];
    [self.bgView addSubview:self.DownBtn];
    [self.DownBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.honerLabel);
        make.left.mas_equalTo(self.honerLabel.mas_right).mas_offset(px_scale(10));
        make.height.width.mas_equalTo(px_scale(50));
    }];
    [self.bgView addSubview:self.giftNum];
    [self.giftNum mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.DownBtn);
        make.left.mas_equalTo(self.DownBtn.mas_right).mas_offset(px_scale(10));
    }];
    
    [self.bgView addSubview:self.UpBtn];
    [self.UpBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.giftNum);
        make.left.mas_equalTo(self.giftNum.mas_right).mas_offset(px_scale(10));
        make.height.width.mas_equalTo(px_scale(50));
    }];
    
    [self.bgView addSubview:self.totalNum];
    [self.totalNum mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_offset(px_scale(-30));
        make.top.mas_equalTo(self.collectionView.mas_bottom).mas_offset(px_scale(36));
    }];
    
    [self.bgView addSubview:self.ticketsNum];
    [self.ticketsNum mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.totalNum);
        make.right.mas_equalTo(self.totalNum.mas_left).mas_offset(px_scale(-36));
    }];
    [self.bgView addSubview:self.sendBtn];
    [self.sendBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.honerLabel.mas_bottom).mas_offset(px_scale(32));
        make.left.mas_offset(px_scale(30));
        make.right.mas_offset(px_scale(-30));
        make.height.mas_equalTo(px_scale(88));
    }];
    [self layoutIfNeeded];
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:self.bgView.bounds byRoundingCorners:UIRectCornerTopLeft|UIRectCornerTopRight cornerRadii:CGSizeMake(px_scale(30), px_scale(30))];
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc]init];
    maskLayer.frame = self.bgView.bounds;
    maskLayer.path = path.CGPath;
    self.bgView.layer.mask = maskLayer;
}
#pragma mark ——— collectionViewDelegate
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView
     numberOfItemsInSection:(NSInteger)section {
    
    return 6;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView
                  cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identifierCell = @"Cell";
    CollectionCell *cell = nil;
    cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifierCell forIndexPath:indexPath];
    cell.titleLabel.text = @"福袋";
    [cell.iconImg setImage:[UIImage imageNamed:@"gift_slw_fdz_img"]];
    cell.disNum .text= @"贡献666力量";
    cell.price.text  = @"¥66";
    return cell;
}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    self.selectedIndex = indexPath;
    
}
#pragma mark ——— method
-(void)show{
    [[[UIApplication sharedApplication].delegate window ] addSubview:self];
    self.bgView.transform = CGAffineTransformMakeTranslation(0.01,GiftHeight);
    [UIView animateWithDuration:0.5 animations:^{
        self.bgView.transform = CGAffineTransformMakeTranslation(0.01, 0.01);
    }];
}
-(void)hiddenGiftView{
    [UIView animateWithDuration:0.5 animations:^{
        self.bgView.transform = CGAffineTransformMakeTranslation(0.01,GiftHeight);
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}
-(void)giftNumChange:(UIButton *)sender{
    NSInteger num  = [self.giftNum.text integerValue];
    if (num==0&&sender.tag==0) {
        return;
    }
    //减
    if (sender.tag == 0) {
        num-= 1;
        self.giftNum.text = [NSString stringWithFormat:@"%ld",(long)num];
    }
    //加
    if (sender.tag == 1) {
        num+= 1;
        self.giftNum.text = [NSString stringWithFormat:@"%ld",(long)num];
    }
    
}
-(void)sendGift:(UIButton *)sender{
    if (!self.selectedIndex) {
        [WDAlert showAlertWithMessage:@"请选择礼物" time:0.5f];
        return;
    }
    if ([self.giftNum.text isEqualToString:@"0"]) {
        [WDAlert showAlertWithMessage:@"请选择礼物数量" time:0.5f];
        return;
    }
    [self hiddenGiftView];
    //成功后的回调
    if ([self.delegate respondsToSelector:@selector(SuccessClickSengBtnWithGiftIndex:AndGiftNum:)]) {
        [self.delegate SuccessClickSengBtnWithGiftIndex:self.selectedIndex.row AndGiftNum:[self.giftNum.text integerValue]];
    }
    
}
#pragma mark ——— lazy
- (UIView *)gesbView {
    if (!_gesbView) {
        _gesbView.backgroundColor = [UIColor clearColor];;
        _gesbView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, MAINScreenWidth,MAINScreenHeight-px_scale(749))];
        _gesbView.userInteractionEnabled = YES;
        UITapGestureRecognizer *singalTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(hiddenGiftView)];
        [_gesbView addGestureRecognizer:singalTap];;
    }
    return _gesbView;
}

- (UIView *)bgView {
    if (!_bgView) {
        _bgView =[[UIView alloc]init];
        _bgView.backgroundColor = [UIColor whiteColor];
    }
    return _bgView;
}

- (UILabel *)title {
    if (!_title) {
        
        _title = [[UILabel alloc]init];
        _title.text = @"送礼物";
        _title.textColor = [UIColor blackColor];
        _title.font = [UIFont boldSystemFontOfSize:px_scale(32)];
        _title.textAlignment = NSTextAlignmentCenter;
    }
    return _title;
}

- (UICollectionView *)collectionView {
    if (!_collectionView) {
        UICollectionViewFlowLayout *layout =[[UICollectionViewFlowLayout alloc]init];
        layout.itemSize = CGSizeMake((MAINScreenWidth-px_scale(60+24))/3, px_scale(200));
        layout.minimumInteritemSpacing = px_scale(12);
        layout.minimumLineSpacing = px_scale(12);
        layout.sectionInset = UIEdgeInsetsMake(0, px_scale(30), 0, px_scale(30));
        layout.scrollDirection = UICollectionViewScrollDirectionVertical;
        UICollectionView *collectionView =[[UICollectionView alloc] initWithFrame:CGRectMake(0,px_scale(105), MAINScreenWidth,px_scale(412)) collectionViewLayout:layout];
        collectionView.dataSource = self;
        collectionView.delegate = self;
        //collectionView.pagingEnabled = YES;
        collectionView.showsHorizontalScrollIndicator = NO;
        collectionView.backgroundColor = [UIColor whiteColor];
        [collectionView registerClass:[CollectionCell class]
           forCellWithReuseIdentifier:@"Cell"];
        _collectionView = collectionView;
    }
    return _collectionView;
}

- (UILabel *)honerLabel {
    if (!_honerLabel) {
        _honerLabel = [[UILabel  alloc]init];
        _honerLabel.text = @"荣誉勋章 x";
        _honerLabel.textAlignment = NSTextAlignmentLeft;
        _honerLabel.textColor = [UIColor blackColor];
        _honerLabel.font = [UIFont boldSystemFontOfSize:px_scale(24)];
    }
    return _honerLabel;
}

- (UIButton *)DownBtn {
    if (!_DownBtn) {
        _DownBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_DownBtn setTitleColor:[UIColor colorWithHexString:@"#666666"] forState:UIControlStateNormal];
        [_DownBtn setTitle:@"-" forState:UIControlStateNormal];
        [_DownBtn addTarget:self action:@selector(giftNumChange:) forControlEvents:UIControlEventTouchUpInside];
        _DownBtn.tag = 0;
        _DownBtn.backgroundColor = [UIColor colorWithHexString:@"#F5F5F5"];
        _DownBtn.titleLabel.font =[UIFont systemFontOfSize:px_scale(36)];
        _DownBtn.layer.cornerRadius = px_scale(10);
        _DownBtn.layer.masksToBounds =YES;
    }
    return _DownBtn;
}

- (UIButton *)UpBtn {
    if (!_UpBtn) {
        _UpBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_UpBtn setTitleColor:[UIColor colorWithHexString:@"#666666"] forState:UIControlStateNormal];
        [_UpBtn setTitle:@"+" forState:UIControlStateNormal];
        [_UpBtn addTarget:self action:@selector(giftNumChange:) forControlEvents:UIControlEventTouchUpInside];
        _UpBtn.tag = 1;
        _UpBtn.backgroundColor = [UIColor colorWithHexString:@"#F5F5F5"];
        _UpBtn.titleLabel.font = [UIFont systemFontOfSize:px_scale(36)];
        _UpBtn.layer.cornerRadius = px_scale(10);
        _UpBtn.layer.masksToBounds =YES;
    }
    return _UpBtn;
}

- (UILabel *)giftNum {
    if (!_giftNum) {
        _giftNum = [[UILabel alloc]init];
        _giftNum.backgroundColor = [UIColor colorWithHexString:@"#F5F5F5"];
        _giftNum.font = [UIFont boldSystemFontOfSize:px_scale(28)];
        _giftNum.textColor = [UIColor colorWithHexString:@"#C03128"];
        _giftNum.textAlignment = NSTextAlignmentCenter;
        _giftNum.layer.cornerRadius = px_scale(10);
        _giftNum.layer.masksToBounds = YES;
        _giftNum.text = @"0";
    }
    return _giftNum;
}

- (UILabel *)totalNum {
    if (!_totalNum) {
        _totalNum = [[UILabel  alloc]init];
        _totalNum.text = @"合计:¥198";
        _totalNum.textAlignment = NSTextAlignmentLeft;
        _totalNum.textColor = [UIColor blackColor];
        _totalNum.font = [UIFont boldSystemFontOfSize:px_scale(24)];;
    }
    return _totalNum;
}

- (UILabel *)ticketsNum {
    if (!_ticketsNum) {
        _ticketsNum = [[UILabel  alloc]init];
        _ticketsNum.text = @"-票";
        _ticketsNum.textAlignment = NSTextAlignmentLeft;
        _ticketsNum.textColor = [UIColor blackColor];
        _ticketsNum.font = [UIFont boldSystemFontOfSize:px_scale(24)];
    }
    return _ticketsNum;
}

- (UIButton *)sendBtn {
    if (!_sendBtn) {
        _sendBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_sendBtn setTitle:@"贡献品牌力量" forState:UIControlStateNormal];
        [_sendBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_sendBtn setBackgroundColor:[UIColor colorWithHexString:@"#D3141C"]];
        [_sendBtn.titleLabel setFont:[UIFont boldSystemFontOfSize:px_scale(30)]];
        _sendBtn.layer.cornerRadius = px_scale(44);
        _sendBtn.layer.masksToBounds = YES;
        [_sendBtn addTarget:self action:@selector(sendGift:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _sendBtn;
}
@end
     
     
