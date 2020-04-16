//
//  HomeJoinActivityViewController.m
//  ZhongQiBrand
//
//  Created by iOS002 on 2019/10/21.
//  Copyright © 2019 CY. All rights reserved.
//

#import "HomeJoinActivityViewController.h"
#import "JoinActivityTableViewCell.h"
#import "JoinWaitFootView.h"
#import "JoinBrandFootView.h"
#import "JoinAuthFootView.h"
#import <YYModel.h>
#import "TZImagePickerController.h"
@interface HomeJoinActivityViewController ()<UITableViewDelegate,UITableViewDataSource,TZImagePickerControllerDelegate>
@property (nonatomic, strong) JoinActivityHeaderView *joinHeaderView;
@property (nonatomic, strong) UITableView *contentTableView;
@property (nonatomic, strong) JoinAuthFootView *authFootView;
@property (nonatomic, strong) JoinBrandFootView *brandFootView;
@property (nonatomic, strong) JoinWaitFootView *waitFootView;
@property (nonatomic, strong) NSArray *tableShowContentArray;

@end

@implementation HomeJoinActivityViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initNavView];
     [self initBackNavItem];
    self.navigationItem.title = @"参加活动";
    [self layoutHomeJoinActivityViewController];
    
}


- (void)layoutHomeJoinActivityViewController
{
    self.view.backgroundColor = [UIColor colorWithHexString:@"#F8F8F8"];
    [self.view addSubview:self.contentTableView];
    [self.contentTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.navView.mas_bottom);
        make.left.right.equalTo(self.view);
        make.bottom.mas_equalTo(self.view.mas_bottom).offset(-TabbarSafeBottomMargin);
    }];
}



#pragma mark - UITableViewDelegate and UITableViewDataSource


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.tableShowContentArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 1 && self.processType == JoinActivityProcessTypeAuthentication) {
        return px_scale(148);
    }
    return px_scale(102);
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *indifier = @"UITableViewCell";
    JoinActivityTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:indifier];
    if (!cell) {
        cell = [[JoinActivityTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:indifier];
    }
    cell.showModel = self.tableShowContentArray[indexPath.row];
    cell.clickRefreshImageCodeBlock = ^{
        
    };
    cell.clickGetSMSCodeBlock = ^(JKCountDownButton * _Nonnull countButton) {
        
    };
    return cell;
}

#pragma mark 相册 ~
-(void)openCamaraLibrary {
    TZImagePickerController *imagePickerVc = [[TZImagePickerController alloc] initWithMaxImagesCount:1  delegate:self];
    imagePickerVc.allowTakePicture = YES;
    imagePickerVc.naviBgColor = [UIColor whiteColor];
    imagePickerVc.naviTitleColor = [UIColor blackColor];
    imagePickerVc.needShowStatusBar = YES;
    imagePickerVc.barItemTextColor = [UIColor blackColor];
    imagePickerVc.allowPickingOriginalPhoto = NO;
    imagePickerVc.allowPickingVideo = NO;
    imagePickerVc.maxImagesCount = 1;
    [self presentViewController:imagePickerVc animated:YES completion:nil];
}
- (void)imagePickerController:(TZImagePickerController *)picker didFinishPickingPhotos:(NSArray<UIImage *> *)photos sourceAssets:(NSArray *)assets isSelectOriginalPhoto:(BOOL)isSelectOriginalPhoto
{
    
}

#pragma mark - 返回按钮的创建和点击事件
-(void)initBackNavItem {
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc]initWithImage:[[UIImage imageNamed:@"all_fahuia_btn"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:(UIBarButtonItemStylePlain) target:self action:@selector(backClicked:)];
    self.navigationItem.leftBarButtonItem = backItem;
}
-(void)backClicked:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}


- (void)setProcessType:(JoinActivityProcessType)processType
{
    _processType = processType;
    switch (processType) {
        case JoinActivityProcessTypeAuthentication:
            self.contentTableView.tableFooterView = self.authFootView;
            self.tableShowContentArray = [self returnAuthShowModel];
            break;
        case JoinActivityProcessTypeBrandInfo:
            self.contentTableView.tableFooterView = self.brandFootView;
            self.tableShowContentArray = [self returnBrandShowModel];
            break;
        case JoinActivityProcessTypeWaitExamine:
                 self.contentTableView.tableFooterView = self.waitFootView;
            self.tableShowContentArray = [NSArray array];
                 break;
            
        default:
            self.contentTableView.tableFooterView = self.authFootView;
            break;
    }
    [self.contentTableView reloadData];
}

- (JoinActivityHeaderView *)joinHeaderView
{
    if (!_joinHeaderView) {
        _joinHeaderView = [[JoinActivityHeaderView alloc] init];
        _joinHeaderView.processType = self.processType;
        _joinHeaderView.frame = CGRectMake(0, 0, MAINScreenWidth, px_scale(300));
    }
    return _joinHeaderView;
}

- (UITableView *)contentTableView
{
    if (!_contentTableView) {
        _contentTableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _contentTableView.delegate = self;
        _contentTableView.dataSource = self;
        _contentTableView.tableHeaderView = self.joinHeaderView;
        _contentTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return _contentTableView;
}
- (JoinAuthFootView *)authFootView
{
    if (!_authFootView) {
        _authFootView = [[JoinAuthFootView alloc] initWithFrame:CGRectMake(0, 0, MAINScreenWidth, 400)];
        __weak HomeJoinActivityViewController *weakSelf = self;
        _authFootView.clickServeBlock = ^{// 客服按钮
            
        };
        _authFootView.clickNextBlock = ^{// 下一步
            HomeJoinActivityViewController *joinVC = [[HomeJoinActivityViewController alloc] init];
            joinVC.processType = JoinActivityProcessTypeBrandInfo;
            [weakSelf.navigationController pushViewController:joinVC animated:YES];
        };
    }
    return _authFootView;
}

- (JoinBrandFootView *)brandFootView
{
    if (!_brandFootView) {
        _brandFootView = [[JoinBrandFootView alloc] initWithFrame:CGRectMake(0, 0, MAINScreenWidth, 400)];
        __weak HomeJoinActivityViewController *weakSelf = self;
        _brandFootView.clickServeBlock = ^{// 客服
            
        };
        _brandFootView.clickNextBlock = ^{// 提交
            HomeJoinActivityViewController *joinVC = [[HomeJoinActivityViewController alloc] init];
            joinVC.processType = JoinActivityProcessTypeWaitExamine;
            [weakSelf.navigationController pushViewController:joinVC animated:YES];
        };
        _brandFootView.clickAddImageBlock = ^(JoinFootSelectItemView * _Nonnull selectView) {
            [weakSelf openCamaraLibrary];
        };
    }
    return _brandFootView;
}

- (JoinWaitFootView *)waitFootView
{
    if (!_waitFootView) {
        _waitFootView = [[JoinWaitFootView alloc] initWithFrame:CGRectMake(0, 0, MAINScreenWidth, 400)];
    }
    return _waitFootView;
}

-(NSArray *)returnAuthShowModel
{
    
    NSArray *array = @[
           @{@"title":@"手机号",@"placeholder":@"请填写手机号",@"textFieldStr":@""},
           @{@"title":@"验证码",@"placeholder":@"请输入验证码",@"textFieldStr":@""},
           @{@"title":@"短信验证码",@"placeholder":@"请输入短信验证码",@"textFieldStr":@""},
       ];
   return  [NSArray yy_modelArrayWithClass:[JoinActivityShowModel class] json:array];
    
}

-(NSArray *)returnBrandShowModel
{
    
    NSArray *array = @[
           @{@"title":@"官方网站",@"placeholder":@"请输入官方网站",@"textFieldStr":@""},
           @{@"title":@"所属行业",@"placeholder":@"请输入所属行业",@"textFieldStr":@""},
       ];
   return  [NSArray yy_modelArrayWithClass:[JoinActivityShowModel class] json:array];
    
}


@end
