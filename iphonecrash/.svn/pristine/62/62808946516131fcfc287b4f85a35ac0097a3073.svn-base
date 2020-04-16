//
//  HelpCenterController.m
//  ZhongQiBrand
//
//  Created by iOS on 2019/10/14.
//  Copyright © 2019 CY. All rights reserved.
//

#import "HelpCenterController.h"
#import "HelpCenterViewCell.h"
#import "HelpHeaderView.h"

@interface HelpCenterController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *helpTableView;
@property (nonatomic, strong) NSMutableArray *dataArray;

@end

@implementation HelpCenterController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initNavView];
    self.lineView.hidden = YES;
    [self initBackNavItem];
    self.title = @"帮助中心";
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self setupUI];
    [self loadData];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    BlackStatusBar;
}

/** 视图初始化 */
- (void)setupUI {
    [self.view addSubview:self.helpTableView];
    [self.helpTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.navView.mas_bottom);
        make.left.right.bottom.mas_equalTo(0);
    }];
    
    [self.helpTableView registerClass:[HelpCenterViewCell class] forCellReuseIdentifier:NSStringFromClass([HelpCenterViewCell class])];
    [self.helpTableView registerClass:[HelpHeaderView class] forHeaderFooterViewReuseIdentifier:NSStringFromClass([HelpHeaderView class])];
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

#pragma mark - UITableView Delegate &Datasource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    HelpCenterViewCell *helpCell = [HelpCenterViewCell cellWithTableView:tableView];
    helpCell.model = _dataArray[indexPath.row];
    return helpCell;
}

#pragma mark - Table view delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    UIViewController *vc =[[NSClassFromString(@"XFWkwebView") alloc]init];
    HelpListModel *model = self.dataArray.mutableCopy[indexPath.row];
    [vc setValue:model.url forKey:@"linkUrl"];
    [vc setValue:[UIColor colorWithHexString:@"#f6f6f6"] forKey:@"trackColor"];
    [vc setValue:[UIColor colorWithHexString:@"#FE9B0E"] forKey:@"progressColor"];
    [self.navigationController pushViewController:vc animated:YES];
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    CGFloat headerImgRate = 375.0 / 232;
    CGFloat headerHeight = MAINScreenWidth / headerImgRate;
    return headerHeight;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return CGFLOAT_MIN;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        HelpHeaderView *headerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:NSStringFromClass([HelpHeaderView class])];
        
        return headerView;
    }
    else
        return nil;
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    return nil;
}

- (void)loadData {
    
    NSDictionary *dataDic = @{@"data":@[@{
                                            @"itemid":@"500075",
                                            @"title":@"投票规则",
                                            @"imgUrl":@"sz_rule_icon",
                                            @"url":@"https://api.520wtp.com/interface/user/helpdetail.php?itemid=500075"
                                            },@{
                                            @"itemid":@"500075",
                                            @"title":@"如何报名",
                                            @"imgUrl":@"sz_sign_icon",
                                            @"url":@"https://api.520wtp.com/interface/user/helpdetail.php?itemid=500075"
                                            },@{
                                            @"itemid":@"500075",
                                            @"title":@"如何使用App投票",
                                            @"imgUrl":@"sz_use_icon",
                                            @"url":@"https://api.520wtp.com/interface/user/helpdetail.php?itemid=500075"
                                            }]};
    
    // 弱引用
    __weak typeof(self) weakSelf = self;
    
    NSMutableArray *arr = [dataDic objectForKey:@"data"];
    [weakSelf.dataArray removeAllObjects];
    
    for (int i = 0; i < arr.count; i++) {
        HelpListModel *model = [[HelpListModel alloc]initWithDictionary:arr[i]];
        [weakSelf.dataArray addObject:model];
    }
    
    [weakSelf.helpTableView reloadData];
}

#pragma mark - Private Method

- (void)headerRefresh{
    [self loadData];
}

-(void)endRefresh
{
    [self.helpTableView.mj_header endRefreshing];
}

#pragma mark - 懒加载
- (UITableView *)helpTableView {
    if (!_helpTableView) {
        _helpTableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        _helpTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _helpTableView.backgroundColor = [UIColor whiteColor];
        _helpTableView.delegate = self;
        _helpTableView.dataSource = self;
        _helpTableView.estimatedRowHeight = px_scale(109);
        _helpTableView.rowHeight = px_scale(109);
    }
    return _helpTableView;
}

- (NSMutableArray *)dataArray {
    if (!_dataArray) {
        _dataArray = [[NSMutableArray alloc]init];
    }
    return _dataArray;
}

@end
