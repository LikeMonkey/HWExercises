//
//  SettingViewController.m
//  ZhongQiBrand
//
//  Created by iOS on 2019/10/17.
//  Copyright © 2019 CY. All rights reserved.
//

#import "SettingViewController.h"
#import "SettingFooterView.h"
#import "SettingCell.h"
#import "ChangePhoneController.h"

@interface SettingViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView *settingTableView;
@property (nonatomic, strong) SettingFooterView *footView;
@property (nonatomic, assign) CGFloat checkSize;
@end

@implementation SettingViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.checkSize = [[SDImageCache sharedImageCache] getSize];
    [self.settingTableView reloadData];
    BlackStatusBar;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self initNavView];
    self.lineView.hidden = YES;
    [self initBackNavItem];
    self.title = @"设置";
    self.view.backgroundColor = [UIColor colorWithHexString:@"#F8F8F8"];
    
    [self setupUI];
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

/** 视图初始化 */
- (void)setupUI {
    
    [self.view addSubview:self.settingTableView];
    [self.settingTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.navView.mas_bottom).offset(8 * scaleX);
        make.left.right.bottom.mas_equalTo(0);
    }];
    self.settingTableView.tableFooterView = self.footView;
    
    [self.settingTableView registerClass:[SettingCell class] forCellReuseIdentifier:NSStringFromClass([SettingCell class])];
}

#pragma mark - UITableView Delegate &Datasource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SettingCell *settingCell = [SettingCell cellWithTableView:tableView];
    
    if (indexPath.row == 0) {
        settingCell.leftLabel.text = @"微信号";
        settingCell.rightLabel.text = @"chuan19900520";
        settingCell.isHasArrow = NO;
        settingCell.isHiddenLine = NO;
    }else if (indexPath.row == 1) {
        settingCell.leftLabel.text = @"绑定手机号";
        settingCell.rightLabel.text = @"13*****8911";
        settingCell.isHasArrow = YES;
        settingCell.isHiddenLine = NO;
    }else if (indexPath.row == 2) {
        settingCell.leftLabel.text = @"版本号";
        settingCell.rightLabel.text = [NSString stringWithFormat:@"v%@",AppVersion];
        settingCell.isHasArrow = NO;
        settingCell.isHiddenLine = YES;
    }
    
    return settingCell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath.row == 1) {
        ChangePhoneController *changePhoneVC = [[ChangePhoneController alloc]init];
        [self.navigationController pushViewController:changePhoneVC animated:YES];
    }
}

#pragma mark - 懒加载
- (UITableView *)settingTableView {
    if (!_settingTableView) {
        _settingTableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
        _settingTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _settingTableView.backgroundColor = [UIColor clearColor];
        _settingTableView.delegate = self;
        _settingTableView.dataSource = self;
        _settingTableView.estimatedRowHeight = px_scale(109);
        _settingTableView.rowHeight = px_scale(109);
    }
    return _settingTableView;
}

- (SettingFooterView *)footView {
    if (!_footView) {
        _footView = [[SettingFooterView alloc] initWithFrame:CGRectMake(0, 0, MAINScreenWidth, 124 * scaleX)];
        __weak SettingViewController *weakSelf = self;
        _footView.clickDeleteCacheBlock  = ^{// 清除缓存按钮
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"清除缓存" message:nil preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *oneAction = [UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action){
                [[NSURLCache sharedURLCache] removeAllCachedResponses];
                MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:weakSelf.navigationController.view animated:YES];
                hud.mode = MBProgressHUDModeIndeterminate;
                hud.labelText = @"正在清除缓存";
                [[SDImageCache sharedImageCache] cleanDiskWithCompletionBlock:^{
                    [hud setHidden:YES];
                    [[SDImageCache sharedImageCache] clearDisk];
                    weakSelf.checkSize = [[SDImageCache sharedImageCache] getSize];
                }];
            }];
            UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
            
            [alertController addAction:cancelAction];
            [alertController addAction:oneAction];
            [weakSelf presentViewController:alertController animated:YES completion:nil];
        };
        _footView.clickLoginoutBlock  = ^{// 退出
            SHOW_MSG(@"退出登录", 1);
        };
    }
    return _footView;
}
@end

