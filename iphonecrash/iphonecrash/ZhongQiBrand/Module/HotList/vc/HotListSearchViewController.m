//
//  HotListSearchViewController.m
//  ZhongQiBrand
//
//  Created by ios2 on 2019/9/21.
//  Copyright © 2019 CY. All rights reserved.
//

#import "HotListSearchViewController.h"
#import "UICollectionViewLeftAlignedLayout.h"
#import "SearchCollectionReusableView.h"

@interface HotListSearchViewController ()
<UICollectionViewDelegateLeftAlignedLayout,
UICollectionViewDataSource>
@property (nonatomic,strong)UICollectionView *historyCollectionView;
@property (nonatomic,strong)NSMutableArray *searchArray;
@end

@implementation HotListSearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];

	[self.searchArray addObjectsFromArray:@[@"王嘉尔",@"周杰伦",@"中国70周年庆",@"喜爱的行业"]];
	self.placeHoder = @"快速找到喜爱的行业";
	//热门搜索以及历史记录
	UICollectionViewLeftAlignedLayout *leftLayout = [[UICollectionViewLeftAlignedLayout alloc]init];
	leftLayout.sectionInset = UIEdgeInsetsMake(0, 15, 0, 15);
	leftLayout.minimumLineSpacing = px_scale(20);
	leftLayout.minimumInteritemSpacing = px_scale(24);
	UICollectionView *collectionView = [[UICollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:leftLayout];
	self.historyCollectionView = collectionView;
	collectionView.backgroundColor = [UIColor whiteColor];
	[collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
	[collectionView registerNib:[UINib nibWithNibName:@"SearchCollectionReusableView" bundle:nil] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader  withReuseIdentifier:@"header"];
	[self.view addSubview:collectionView];
	[collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
		make.top.equalTo(self.navView.mas_bottom);
		make.left.right.bottom.mas_equalTo(0);
	}];
	collectionView.delegate = self;
	collectionView.dataSource = self;
}

#pragma markCollectionView

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
	return self.searchArray.count;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
	UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
	UILabel *textLable = [cell.contentView viewWithTag:100];
	if (!textLable) {
		textLable = [[UILabel alloc]init];
		[cell.contentView addSubview:textLable];
		textLable.tag = 100;
		textLable.textAlignment = NSTextAlignmentCenter;
		textLable.textColor = [UIColor colorWithHexString:@"#18181A"];
		textLable.font = [UIFont systemFontOfSize:13];
		textLable.backgroundColor = [UIColor colorWithHexString:@"#F7F7F7"];
		textLable.layer.masksToBounds = YES;
		textLable.layer.cornerRadius = px_scale(32);
		[textLable mas_makeConstraints:^(MASConstraintMaker *make) {
			make.edges.mas_equalTo(UIEdgeInsetsZero);
		}];
	}
	textLable.text = self.searchArray[indexPath.row];
	return cell;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
	return 1;
}
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
	return CGSizeMake(MAINScreenWidth, px_scale(54+33+52));
}
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
		CGFloat w = [self labelSizeFromString:self.searchArray[indexPath.row] andFont:[UIFont systemFontOfSize:14]].width + px_scale(30);
		if (w < 40) {
			w = 40;
		}
		return CGSizeMake(w, px_scale(64));
}
-(UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
	if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
		SearchCollectionReusableView * header = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"header" forIndexPath:indexPath];
		if (indexPath.section == 0) {
			header.clearBtn.hidden = ArrayIsEmpty(self.searchArray) ?YES:NO;
			header.titleLable.text = @"历史搜索";
			__weak typeof(self)ws = self;
			[header setClearHistory:^{

			}];
		}
		return  header;
	}
	return nil;
}
//计算文字宽度
- (CGSize)labelSizeFromString:(NSString *)str andFont:(UIFont *)font{
	NSDictionary *attributes = @{NSFontAttributeName: font};
	return [str sizeWithAttributes:attributes];
}


-(NSMutableArray *)searchArray
{
	if (!_searchArray) {
		_searchArray = [[NSMutableArray alloc]init];
	 }
	return _searchArray;
}




@end
