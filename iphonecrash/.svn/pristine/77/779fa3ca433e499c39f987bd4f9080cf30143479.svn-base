//
//  HostListDetailController.m
//  ZhongQiBrand
//
//  Created by iOS on 2019/10/18.
//  Copyright © 2019 CY. All rights reserved.
//

#import "HostListDetailController.h"
#import "HotListDetailCell.h"
#import "HotListDetailModel.h"

@interface HostListDetailController ()<UITableViewDelegate,UITableViewDataSource>
{
	UILabel *_titleLable;
}
@property (nonatomic, strong) UIImageView *backgroudImg;
@property (nonatomic, strong) UITableView *hotListDetailTable;
@property (nonatomic, strong) NSMutableArray *dataArray;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *descripLabel;

//持有黑色图片
@property (nonatomic,strong)UIImage *blackShareImage;
@property (nonatomic,strong)UIImage *blackBackImage;

@property (nonatomic,strong)UIImage *whiteShareImage;
@property (nonatomic,strong)UIImage *whiteBackImage;



@end

@implementation HostListDetailController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
	//重新设置
	[self scrollViewDidScroll:self.hotListDetailTable];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initNavView];
    self.lineView.hidden = YES;
    self.navView.backgroundColor = [UIColor clearColor];
    
    UILabel *titleLable = [UILabel new];
    titleLable.text = @"热门榜单";
    titleLable.font =[UIFont boldSystemFontOfSize:17];
    titleLable.textColor = [UIColor whiteColor];
    titleLable.textAlignment = NSTextAlignmentCenter;
	[titleLable sizeToFit];//自适应导航
	self.navigationItem.titleView = titleLable;
	_titleLable= titleLable;
	[self initNavItem:YES];
    self.view.backgroundColor = [UIColor clearColor];
    [self setupUI];
    [self loadData];
}
- (void)initNavItem:(BOOL)isWhite
{
	UIBarButtonItem *backItem = [[UIBarButtonItem alloc]initWithImage:[(isWhite?self.whiteBackImage:self.blackBackImage) imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:(UIBarButtonItemStylePlain) target:self action:@selector(backClicked:)];
    self.navigationItem.leftBarButtonItem = backItem;
    UIBarButtonItem *shareItem = [[UIBarButtonItem alloc]initWithImage:[(isWhite?self.whiteShareImage:self.blackShareImage) imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:(UIBarButtonItemStylePlain) target:self action:@selector(shareClicked:)];
    self.navigationItem.rightBarButtonItem = shareItem;
	_titleLable.textColor = isWhite?[UIColor whiteColor]:[UIColor blackColor];
	if (isWhite) {
		LightStatusBar;
	}else{
		BlackStatusBar;
	}
}

#pragma mark - Target Mehtods
- (void)backClicked:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)shareClicked:(id)sender {
   // 分享
    SharePopView *popV =[SharePopView showShare];
    [popV setShareAction:^(ShareType type, id shareImge) {
    [ShareManager shareWithType:(UMSocialPlatformType)type
                           andImage:@""
                      andShareTitle:@"测试数据"
                        andShareUrl:@""
                       andShareDesc:@"这是一条分享的测试数据"
                      andCompletion:^(BOOL isSuccess) {
                          NSLog(@"分享结果回调");
                      }];
    }];
}

- (void)setupUI {
    
    [self.view addSubview:self.hotListDetailTable];
    [self.hotListDetailTable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.bottom.mas_equalTo(0);
    }];
    
    [self.view insertSubview:self.backgroudImg atIndex:0];
    
    UIView *tableHeaderView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, MAINScreenWidth, [DeviceTool isPhoneX] ? 178 * scaleX : 154 * scaleX)];
    self.hotListDetailTable.tableHeaderView = tableHeaderView;
    tableHeaderView.backgroundColor  = [UIColor clearColor];
    
    [tableHeaderView addSubview:self.titleLabel];
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(20 * scaleX);
        make.top.mas_equalTo([DeviceTool isPhoneX] ? 95 * scaleX : 71 * scaleX);
    }];
    
    [tableHeaderView addSubview:self.descripLabel];
    [_descripLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(20 * scaleX);
        make.bottom.mas_equalTo(-26 * scaleX);
    }];
    
    UIView *footerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, MAINScreenWidth, 38 * scaleX)];
    self.hotListDetailTable.tableFooterView = footerView;
    footerView.backgroundColor = [UIColor clearColor];
    
    [self.hotListDetailTable registerClass:[HotListDetailCell class] forCellReuseIdentifier:NSStringFromClass([HotListDetailCell class])];
}

#pragma mark - UITableView Delegate &Datasource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return self.dataArray.count;
    }else {
        return 0;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        HotListDetailCell *detailCell = [HotListDetailCell cellWithTableView:tableView];
        detailCell.model = self.dataArray.mutableCopy[indexPath.row];
        [detailCell setSelectionStyle:UITableViewCellSelectionStyleNone];
        return detailCell;
    }else{
        return nil;
    }
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return CGFLOAT_MIN;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return CGFLOAT_MIN;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    return nil;
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    return nil;
}
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
	CGFloat offSetY = scrollView.contentOffset.y;
	CGFloat nav_h = self.navView.height;
	CGFloat alpha = offSetY/nav_h;
	alpha = MIN(1, alpha);
	alpha = MAX(0, alpha);
	self.navView.backgroundColor = [[UIColor whiteColor]colorWithAlphaComponent:alpha];
	BOOL isWhite = (alpha<=0.5)?YES:NO;
	[self initNavItem:isWhite];
}

#pragma mark - 加载数据
- (void)loadData {
    
    self.titleLabel.text = @"标准件行业";
    self.descripLabel.text = @"十/大/品/牌/排/行/榜";
    NSDictionary *dataDic = @{@"data":@[@{
                                            @"itemid": @"983",
                                            @"ranking": @"1",
                                            @"title": @"耐克",
                                            @"thumb": @"http://wwwzhengyang.10brandcn.com:81/201908/06/13-08-52-10581-0.png",
                                            @"company": @"上海球明标准件有限公司",
                                            @"homepage": @"http://www.sqm88.com",
                                            @"address": @"上海市嘉定区浏翔公路6798号"
                                            },@{
                                            @"itemid": @"983",
                                            @"ranking": @"2",
                                            @"title": @"阿迪达斯",
                                            @"thumb": @"http://wwwzhengyang.10brandcn.com:81/201908/06/13-08-52-10581-0.png",
                                            @"company": @"上海球明标准件有限公司",
                                            @"homepage": @"http://www.sqm88.com",
                                            @"address": @"上海市嘉定区浏翔公路6798号"
                                            },@{
                                            @"itemid": @"983",
                                            @"ranking": @"3",
                                            @"title": @"乔丹",
                                            @"thumb": @"http://wwwzhengyang.10brandcn.com:81/201908/06/13-08-52-10581-0.png",
                                            @"company": @"上海球明标准件有限公司",
                                            @"homepage": @"http://www.sqm88.com",
                                            @"address": @"上海市嘉定区浏翔公路6798号"
                                            },@{
                                            @"itemid": @"983",
                                            @"ranking": @"4",
                                            @"title": @"Boy London",
                                            @"thumb": @"http://wwwzhengyang.10brandcn.com:81/201908/06/13-08-52-10581-0.png",
                                            @"company": @"上海球明标准件有限公司",
                                            @"homepage": @"http://www.sqm88.com",
                                            @"address": @"上海市嘉定区浏翔公路6798号"
                                            },@{
                                            @"itemid": @"983",
                                            @"ranking": @"5",
                                            @"title": @"香奈儿",
                                            @"thumb": @"http://wwwzhengyang.10brandcn.com:81/201908/06/13-08-52-10581-0.png",
                                            @"company": @"上海球明标准件有限公司",
                                            @"homepage": @"http://www.sqm88.com",
                                            @"address": @"上海市嘉定区浏翔公路6798号"
                                            },@{
                                            @"itemid": @"983",
                                            @"ranking": @"6",
                                            @"title": @"迪奥",
                                            @"thumb": @"http://wwwzhengyang.10brandcn.com:81/201908/06/13-08-52-10581-0.png",
                                            @"company": @"上海球明标准件有限公司",
                                            @"homepage": @"http://www.sqm88.com",
                                            @"address": @"上海市嘉定区浏翔公路6798号"
                                            },@{
                                            @"itemid": @"983",
                                            @"ranking": @"7",
                                            @"title": @"纪梵希",
                                            @"thumb": @"http://wwwzhengyang.10brandcn.com:81/201908/06/13-08-52-10581-0.png",
                                            @"company": @"上海球明标准件有限公司",
                                            @"homepage": @"http://www.sqm88.com",
                                            @"address": @"上海市嘉定区浏翔公路6798号"
                                            },@{
                                            @"itemid": @"983",
                                            @"ranking": @"8",
                                            @"title": @"蔻驰",
                                            @"thumb": @"http://wwwzhengyang.10brandcn.com:81/201908/06/13-08-52-10581-0.png",
                                            @"company": @"上海球明标准件有限公司",
                                            @"homepage": @"http://www.sqm88.com",
                                            @"address": @"上海市嘉定区浏翔公路6798号"
                                            },@{
                                            @"itemid": @"983",
                                            @"ranking": @"9",
                                            @"title": @"纪梵希",
                                            @"thumb": @"http://wwwzhengyang.10brandcn.com:81/201908/06/13-08-52-10581-0.png",
                                            @"company": @"上海球明标准件有限公司",
                                            @"homepage": @"http://www.sqm88.com",
                                            @"address": @"上海市嘉定区浏翔公路6798号"
                                            },@{
                                            @"itemid": @"983",
                                            @"ranking": @"10",
                                            @"title": @"蔻驰",
                                            @"thumb": @"http://wwwzhengyang.10brandcn.com:81/201908/06/13-08-52-10581-0.png",
                                            @"company": @"上海球明标准件有限公司",
                                            @"homepage": @"http://www.sqm88.com",
                                            @"address": @"上海市嘉定区浏翔公路6798号"
                                            }]};
    
    // 弱引用
    __weak typeof(self) weakSelf = self;
    
    NSMutableArray *arr = [dataDic objectForKey:@"data"];
    [weakSelf.dataArray removeAllObjects];
    
    for (int i = 0; i < arr.count; i++) {
        HotListDetailModel *model = [[HotListDetailModel alloc]initWithDictionary:arr[i]];
        [weakSelf.dataArray addObject:model];
    }
    
    [weakSelf.hotListDetailTable reloadData];
}

#pragma mark - 懒加载
- (UIImageView *)backgroudImg {
    if (!_backgroudImg) {
        _backgroudImg = [[UIImageView alloc]init];
        _backgroudImg.image = [UIImage imageNamed:@"bd_background"];
        _backgroudImg.frame  = CGRectMake(0, 0, MAINScreenWidth, 2754/2 * scaleX);
    }
    return _backgroudImg;
}

- (UITableView *)hotListDetailTable {
    if (!_hotListDetailTable) {
        _hotListDetailTable = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        _hotListDetailTable.separatorStyle = UITableViewCellSeparatorStyleNone;
        _hotListDetailTable.backgroundColor = [UIColor clearColor];
        _hotListDetailTable.delegate = self;
        _hotListDetailTable.dataSource = self;
        _hotListDetailTable.estimatedRowHeight = px_scale(240);
        _hotListDetailTable.rowHeight = px_scale(240);
    }
    return _hotListDetailTable;
}

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc]init];
        _titleLabel.textColor = [UIColor whiteColor];
        _titleLabel.font = [UIFont boldSystemFontOfSize:26];
        _titleLabel.textAlignment = NSTextAlignmentLeft;
    }
    return _titleLabel;
}

- (UILabel *)descripLabel {
    if (!_descripLabel) {
        _descripLabel = [[UILabel alloc]init];
        _descripLabel.textColor = [UIColor colorWithHexString:@"#FFFFFF"];
        _descripLabel.font = [UIFont systemFontOfSize:15];
        _descripLabel.textAlignment = NSTextAlignmentLeft;
    }
    return _descripLabel;
}

- (NSMutableArray *)dataArray {
    if (!_dataArray) {
        _dataArray = [[NSMutableArray alloc]init];
    }
    return _dataArray;
}

-(UIImage *)blackBackImage
{
	if (!_blackBackImage)
	 {
		_blackBackImage = [UIImage imageNamed:@"all_fahuia_btn"];
	 }
	return _blackBackImage;
}
-(UIImage *)blackShareImage
{
	if (!_blackShareImage)
	 {
		_blackShareImage = [[UIImage imageNamed:@"bd_share_icon"]imageWithColor:[UIColor blackColor]];
	 }
	return _blackShareImage;
}
-(UIImage *)whiteShareImage
{
	if (!_whiteShareImage)
	 {
		_whiteShareImage = [[UIImage imageNamed:@"bd_share_icon"]imageWithColor:[UIColor whiteColor]];
	 }
	return _whiteShareImage;
}
-(UIImage *)whiteBackImage
{
	if (!_whiteBackImage)
	 {
		_whiteBackImage = [[UIImage imageNamed:@"all_fahuia_btn"]imageWithColor:[UIColor whiteColor]];
	 }
	return _whiteBackImage;
}









@end
