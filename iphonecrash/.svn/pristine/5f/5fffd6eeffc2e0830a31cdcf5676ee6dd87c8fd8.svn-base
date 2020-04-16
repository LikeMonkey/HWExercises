//
//  HomeHotTableViewCell.m
//  ZhongQiBrand
//
//  Created by ios2 on 2019/9/17.
//  Copyright © 2019 CY. All rights reserved.
//

#import "HomeHotTableViewCell.h"
#import "HomeHotCollectionViewCell.h"
#import "HomeResponse.h"

@interface HomeHotTableViewCell ()
@property (nonatomic,strong)NSMutableArray *dataSource;
@end


@implementation HomeHotTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
}
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
	self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
	if (self) {
		[self setUpUI];
	}
	return self;
}

-(void)setBrandArray:(NSArray *)brandArray
{
	_brandArray = brandArray;
	[self.dataSource removeAllObjects];
	[self.dataSource addObjectsFromArray:brandArray];
	self.pageControl.numberOfPages = self.dataSource.count;
	[self.myCollectionView reloadData];
}
#pragma mark - setUpUI
-(void)setUpUI
{
	[self.contentView addSubview:self.myCollectionView];
	[self.myCollectionView registerClass:[HomeHotCollectionViewCell class] forCellWithReuseIdentifier:@"HomeHotCollectionViewCell"];
	self.myCollectionView.delegate = self;
	self.myCollectionView.dataSource = self;
	[self.myCollectionView mas_makeConstraints:^(MASConstraintMaker *make) {
		make.left.right.mas_equalTo(0);
		make.top.mas_equalTo(0);
		make.height.mas_equalTo(px_scale(540));
	}];

	[self.contentView addSubview:self.pageControl];
	self.pageControl.numberOfPages = 3;
	[self.pageControl mas_makeConstraints:^(MASConstraintMaker *make) {
		make.left.right.mas_equalTo(0);
		make.height.mas_equalTo(px_scale(16));
		make.top.equalTo(self.myCollectionView.mas_bottom).offset(px_scale(41));
	}];

	[self loadSpaceView]; //加载底部占位
}
-(void)loadSpaceView
{
	UIView *spaceView =[UIView new];
	spaceView.backgroundColor =[UIColor colorWithHexString:@"#F8F8F8"];
	[self.contentView addSubview:spaceView];
	[spaceView mas_makeConstraints:^(MASConstraintMaker *make) {
		make.left.right.bottom.mas_equalTo(0);
		make.height.mas_equalTo(px_scale(20));
	}];
}
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
	CGFloat offSetY = scrollView.contentOffset.x;
	NSInteger page =  (offSetY + MAINScreenWidth/2.0)/MAINScreenWidth;
	self.pageControl.currentPage =page;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
	return self.dataSource.count;
}
- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
	HomeHotCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"HomeHotCollectionViewCell" forIndexPath:indexPath];
	HomeVoteModel *model = self.dataSource[indexPath.row];
	cell.timeLable.text = model.addtime;
	cell.industryNameLable.text = model.show;

	return cell;
}
-(UICollectionView *)myCollectionView {
	if (!_myCollectionView) {
		UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc]init];
		flowLayout.sectionInset = UIEdgeInsetsZero;
		flowLayout.scrollDirection =  UICollectionViewScrollDirectionHorizontal;
		flowLayout.itemSize = CGSizeMake(MAINScreenWidth, px_scale(540));
		_myCollectionView = [[UICollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:flowLayout];
		_myCollectionView.pagingEnabled = YES;
		_myCollectionView.backgroundColor = [UIColor whiteColor];
		_myCollectionView.showsVerticalScrollIndicator = NO;
		_myCollectionView.showsHorizontalScrollIndicator = NO;
	}
	return _myCollectionView;
}
-(UIPageControl *)pageControl
{
	if (!_pageControl) {
		_pageControl = [[UIPageControl alloc]init];
		_pageControl.userInteractionEnabled = NO;
		_pageControl.currentPageIndicatorTintColor = [UIColor colorWithHexString:@"#DD131C"];
		_pageControl.pageIndicatorTintColor = [UIColor colorWithHexString:@"#E2E2E2"];
	}
	return _pageControl;
}

-(NSMutableArray *)dataSource
{
	if (!_dataSource) {
		_dataSource = [[NSMutableArray alloc]init];
	 }
	return _dataSource;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

+(CGFloat)hotListHeight
{
	return px_scale(540+97);
}



@end
