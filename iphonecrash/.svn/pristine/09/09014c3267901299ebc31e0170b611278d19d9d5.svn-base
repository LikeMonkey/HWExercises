//
//  NewsViewController.m
//  ZhongQiBrand
//
//  Created by iOS on 2019/10/18.
//  Copyright © 2019 CY. All rights reserved.
//

#import "NewsViewController.h"
#import "NewsTableViewCell.h"
#import "NewsModel.h"

@interface NewsViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *newsTableView;
@property (nonatomic, strong) NSMutableArray *dataArray;

@end

@implementation NewsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initNavView];
    self.lineView.hidden = YES;
    BlackStatusBar;
    [self initBackNavItem];
    self.title = @"通知";
    self.view.backgroundColor = [UIColor colorWithHexString:@"#F8F8F8"];
    
    [self setupUI];
    [self loadData];
}

- (void)initBackNavItem
{
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc]initWithImage:[[UIImage imageNamed:@"all_fahuia_btn"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:(UIBarButtonItemStylePlain) target:self action:@selector(backClicked:)];
    self.navigationItem.leftBarButtonItem = backItem;
}

#pragma mark - Target Mehtods
- (void)backClicked:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)setupUI {
    
    [self.view addSubview:self.newsTableView];
    [self.newsTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.navView.mas_bottom).offset(8 * scaleX);
        make.left.right.bottom.mas_equalTo(0);
    }];
    
    [self.newsTableView registerClass:[NewsTableViewCell class] forCellReuseIdentifier:NSStringFromClass([NewsTableViewCell class])];
    
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
        
        NewsTableViewCell *newsCell = [NewsTableViewCell cellWithTableView:tableView];
        newsCell.newsModel = self.dataArray.mutableCopy[indexPath.row];
        return newsCell;
        
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

#pragma mark - 加载数据
- (void)loadData {
    NSDictionary *dataDic = @{@"data":@[@{
                                            @"title":@"恭喜您参加中国最佳品牌活动成功",
                                            @"timer":@"2019-09-17 15:31"
                                            },@{
                                            @"title":@"恭喜您进入榜单前十",
                                            @"timer":@"2019-09-17 15:31"
                                            },@{
                                            @"title":@"全国十大品牌榜单即将揭晓",
                                            @"timer":@"2019-09-17 15:31"
                                            },@{
                                            @"title":@"恭喜您进入榜单前十",
                                            @"timer":@"2019-09-17 15:31"
                                            },@{
                                            @"title":@"全国十大品牌榜单即将揭晓",
                                            @"timer":@"2019-09-17 15:31"
                                            },@{
                                            @"title":@"全国十大品牌榜单即将揭晓",
                                            @"timer":@"2019-09-17 15:31"
                                            },@{
                                            @"title":@"恭喜您参加中国最佳品牌活动成功",
                                            @"timer":@"2019-09-17 15:31"
                                            },@{
                                            @"title":@"恭喜您参加中国最佳品牌活动成功",
                                            @"timer":@"2019-09-17 15:31"
                                            }]};
    
    // 弱引用
    __weak typeof(self) weakSelf = self;
    
    NSMutableArray *arr = [dataDic objectForKey:@"data"];
    [weakSelf.dataArray removeAllObjects];
    
    for (int i = 0; i < arr.count; i++) {
        NewsModel *model = [[NewsModel alloc]initWithDictionary:arr[i]];
        [weakSelf.dataArray addObject:model];
    }
    
    [weakSelf.newsTableView reloadData];
}

#pragma mark - 懒加载
- (UITableView *)newsTableView {
    if (!_newsTableView) {
        _newsTableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        _newsTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _newsTableView.backgroundColor = [UIColor whiteColor];
        _newsTableView.delegate = self;
        _newsTableView.dataSource = self;
        _newsTableView.estimatedRowHeight = px_scale(152);
        _newsTableView.rowHeight = px_scale(152);
    }
    return _newsTableView;
}

- (NSMutableArray *)dataArray {
    if (!_dataArray) {
        _dataArray = [[NSMutableArray alloc]init];
    }
    return _dataArray;
}

@end
