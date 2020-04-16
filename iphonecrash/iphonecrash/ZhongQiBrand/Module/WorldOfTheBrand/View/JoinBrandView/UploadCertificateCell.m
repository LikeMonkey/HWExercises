//
//  UploadCertificateCell.m
//  ZhongQiBrand
//
//  Created by ios2 on 2019/10/21.
//  Copyright © 2019 CY. All rights reserved.
//

#import "UploadCertificateCell.h"
#import "CerItemView.h"
#import "JoinTopView.h"

@interface UploadCertificateCell()<UICollectionViewDelegate,UICollectionViewDataSource>
{
	NSArray *_titles;
}
@property (nonatomic,strong)UICollectionView *myCollectionView;

@end


@implementation UploadCertificateCell

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
	self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
	if (self) {
		_titles = @[@"品牌logo",@"营业执照",@"商标注册",@"其他证件",@"其他证件",@"其他证件"];
		[self setUpUI];
	}
	return self;
}

-(void)setUpUI
{
	[self.contentView addSubview:self.myCollectionView];

	[self.myCollectionView registerClass:[CerItemView class] forCellWithReuseIdentifier:@"CerItemView"];
	self.myCollectionView.delegate = self;
	self.myCollectionView.dataSource = self;

	[self.myCollectionView mas_makeConstraints:^(MASConstraintMaker *make) {
		make.left.right.mas_equalTo(0);
		make.top.mas_equalTo(px_scale(120));
		make.height.mas_equalTo(px_scale(630));
		make.bottom.equalTo(self.contentView.mas_bottom).offset(-px_scale(12));
	}];

	JoinTopView *topView = [[JoinTopView alloc]initWithFrame:CGRectZero];
	[self.contentView addSubview:topView];
	topView.titleLable.text = @"上传证件";
	topView.descLable.text = @"(上传图片大小请控制在5M以内）";
	[topView mas_makeConstraints:^(MASConstraintMaker *make) {
		make.left.right.mas_equalTo(0);
		make.top.mas_equalTo(px_scale(20));
		make.bottom.equalTo(self.myCollectionView.mas_top);
	}];

	UIView *spaceView = [UIView new];
	[self.contentView addSubview:spaceView];
	spaceView.backgroundColor = [UIColor colorWithHexString:@"#F6F6F6"];
	[spaceView mas_makeConstraints:^(MASConstraintMaker *make) {
		make.left.right.top.mas_equalTo(0);
		make.bottom.equalTo(topView.mas_top);
	}];
	
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
	return _titles.count;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
	CerItemView *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"CerItemView" forIndexPath:indexPath];
	[cell configerTitle:_titles[indexPath.row] andIsMust:(indexPath.row>2)?NO:YES];
	__weak typeof(self)ws = self;
	[cell setDeleteImageBlock:^(id sender) {
		[ws deleteImageWithCell:sender];
	}];
	if (self.thumbsDic) {
		NSString *key = [@(indexPath.row) stringValue];
		cell.cerImage = self.thumbsDic[key];
	}else{
		cell.cerImage = nil;
	}
	return cell;
}

-(void)deleteImageWithCell:(UICollectionViewCell *)cell
{
	NSIndexPath *indexPath = [self.myCollectionView indexPathForCell:cell];
	!_deleteClickedCameraItem?:_deleteClickedCameraItem(indexPath.row,cell);
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
	!_didClickedCameraItem?:_didClickedCameraItem(indexPath.row,self); //回调打开相机
}

-(UICollectionView *)myCollectionView {
	if (!_myCollectionView) {
		UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc]init];
		flowLayout.sectionInset = UIEdgeInsetsMake(px_scale(20), px_scale(30),px_scale(10), px_scale(30));
		flowLayout.itemSize = CGSizeMake(px_scale(332), px_scale(176));
		flowLayout.minimumInteritemSpacing = CGFLOAT_MIN;
		flowLayout.minimumLineSpacing = px_scale(26);
		_myCollectionView = [[UICollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:flowLayout];
		_myCollectionView.backgroundColor = [UIColor whiteColor];
		_myCollectionView.showsVerticalScrollIndicator = NO;
		_myCollectionView.showsHorizontalScrollIndicator = NO;
		_myCollectionView.scrollEnabled = NO;
	}
	return _myCollectionView;
}

-(void)setThumbsDic:(NSDictionary *)thumbsDic
{
	_thumbsDic = thumbsDic;
	[self.myCollectionView reloadData];
}
@end
