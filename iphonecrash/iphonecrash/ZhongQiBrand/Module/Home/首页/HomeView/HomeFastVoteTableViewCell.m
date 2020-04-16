//
//  HomeFastVoteTableViewCell.m
//  ZhongQiBrand
//
//  Created by ios2 on 2019/9/17.
//  Copyright © 2019 CY. All rights reserved.
//

#import "HomeFastVoteTableViewCell.h"
#import "FastVoteItemCell.h"
#import "ApplyMedalPopView.h"
#import "IntroductionPopView.h"

@interface HomeFastVoteTableViewCell()<UICollectionViewDataSource,UICollectionViewDelegate>
@property (nonatomic,strong)NSMutableArray *dataSource;
@end

@implementation HomeFastVoteTableViewCell

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

#pragma mark - setUpUI
-(void)setUpUI
{
    [self.contentView addSubview:self.myCollectionView];
    [self.myCollectionView registerClass:[FastVoteItemCell class] forCellWithReuseIdentifier:@"FastVoteItemCell"];
    self.myCollectionView.delegate = self;
    self.myCollectionView.dataSource = self;
    [self.myCollectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.top.mas_equalTo(0);
        make.height.mas_equalTo(px_scale(264));
    }];
    
    UIView *spaceView =[UIView new];
    spaceView.backgroundColor =[UIColor colorWithHexString:@"#F8F8F8"];
    [self.contentView addSubview:spaceView];
    [spaceView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.mas_equalTo(0);
        make.height.mas_equalTo(px_scale(20));
    }];
    
    [self.contentView addSubview:self.pageControl];
    self.pageControl.numberOfPages = 10;
    [self.pageControl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.height.mas_equalTo(px_scale(16));
        make.top.equalTo(self.myCollectionView.mas_bottom).offset(px_scale(13));
    }];
}
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat page_w = px_scale(424);
    CGFloat offSetX = scrollView.contentOffset.x + page_w*0.8;
    NSInteger page = (NSInteger)offSetX/page_w;
    self.pageControl.currentPage = page;
}

-(void)setDataArray:(NSArray *)dataArray
{
	_dataArray = dataArray;
	[self.dataSource removeAllObjects];
	[self.dataSource addObjectsFromArray:dataArray];
	[self.dataSource addObjectsFromArray:@[@"",@"",@"",@"",@"",@""]];
	[self.myCollectionView reloadData];
	self.pageControl.numberOfPages = self.dataSource.count;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
	return self.dataSource.count;;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    FastVoteItemCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"FastVoteItemCell" forIndexPath:indexPath];
	cell.model = self.dataSource[indexPath.row];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {

}
//显示揭榜时间
-(void)showUncoverListTime:(NSString *)timeLine
{
	[ApplyMedalPopView showYear:@"2019" month:@"11" day:@"11"];
}
//显示详情
-(void)showIndustryDesc:(NSString *)descString
{
	if (NullString(descString)) return;
	[IntroductionPopView showContent:descString];
}
-(UICollectionView *)myCollectionView {
    if (!_myCollectionView) {
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc]init];
        flowLayout.sectionInset = UIEdgeInsetsMake(px_scale(15), px_scale(15), px_scale(15), px_scale(15));
        flowLayout.scrollDirection =  UICollectionViewScrollDirectionHorizontal;
        flowLayout.itemSize = CGSizeMake(px_scale(424), px_scale(234));
        flowLayout.minimumInteritemSpacing = CGFLOAT_MIN;
        flowLayout.minimumLineSpacing = CGFLOAT_MIN;
        _myCollectionView = [[UICollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:flowLayout];
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
}
+(CGFloat)fastVoteCellHeight
{
    return px_scale(264+68 + 20);
}
@end

