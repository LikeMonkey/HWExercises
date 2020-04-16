//
//  FeedBackController.m
//  ZhongQiBrand
//
//  Created by iOS on 2019/10/21.
//  Copyright © 2019 CY. All rights reserved.
//

#import "FeedBackController.h"
#import "MessageContentCell.h"
#import "FeedBackPictureCell.h"
#import "TZImagePickerController.h"
#import "JoinInputCache.h"
#import "CustomLabel.h"

@interface FeedBackController ()<UITableViewDelegate,UITableViewDataSource,TZImagePickerControllerDelegate>
/** headerView */
@property (nonatomic, strong) CustomLabel *headerLabel;
/** tableView */
@property (nonatomic, strong) UITableView *feedBackTable;
/** footerView */
@property (nonatomic, strong) UIButton *submitBtn;
/** 上传的图片 */
@property (nonatomic,strong)NSMutableDictionary *cerThumbsDic;
/** 当前点击的是第几个 */
@property(nonatomic,assign)NSInteger currentThumbIndex;

@end

@implementation FeedBackController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initNavView];
    self.lineView.hidden = YES;
    [self initBackNavItem];
    self.title = @"意见反馈";
    self.view.backgroundColor = [UIColor colorWithHexString:@"#F8F8F8"];
    
    [self setupUI];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    BlackStatusBar;
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [JoinInputCache share].imagesCache = [self.cerThumbsDic copy];    
}

/** 视图初始化 */
- (void)setupUI {
    [self.view addSubview:self.feedBackTable];
    [_feedBackTable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.navView.mas_bottom);
        make.left.right.bottom.mas_equalTo(0);
    }];
    
    [self.feedBackTable registerClass:[MessageContentCell class] forCellReuseIdentifier:NSStringFromClass([MessageContentCell class])];
    [self.feedBackTable registerClass:[FeedBackPictureCell class] forCellReuseIdentifier:NSStringFromClass([FeedBackPictureCell class])];
    
    self.feedBackTable.tableHeaderView = self.headerLabel;
    self.feedBackTable.tableFooterView = self.submitBtn;
    
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
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = nil;
    
    if (indexPath.section == 0) {
        //文本输入
        MessageContentCell *contentCell = [tableView dequeueReusableCellWithIdentifier:@"MessageContentCell" forIndexPath:indexPath];
        contentCell.clickRewriteBtnBlock = ^{
           
        };
        cell = contentCell;
    
    }else if (indexPath.section == 1) {
        
        FeedBackPictureCell *picCell = [tableView dequeueReusableCellWithIdentifier:@"FeedBackPictureCell" forIndexPath:indexPath];
        //赋值图片
        picCell.thumbsDic = self.cerThumbsDic;
        __weak typeof(self)ws = self;
        //添加图片
        [picCell setDidClickedCameraItem:^(NSInteger index, id  _Nonnull sender) {
            ws.currentThumbIndex = index;
            [ws openCamaraLibrary];
        }];
        //删除图片
        [picCell setDeleteClickedCameraItem:^(NSInteger index, id  _Nonnull sender) {
            NSString *thumKey = [@(index) stringValue];
            ws.cerThumbsDic[thumKey] = nil;
            [ws.feedBackTable reloadData];
        }];
        
        cell = picCell;
    }
    
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    return cell;
}

#pragma mark - Table view delegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat height;
    if (indexPath.section == 0) {
        
        height = 175 * scaleX;
        
    }else if (indexPath.section == 1){
        
        height = 216.5 * scaleX;
        
    }else{
        
        height = 0;
    }
    
    return height;
}

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
    imagePickerVc.modalPresentationStyle = UIModalPresentationOverFullScreen;
    [self presentViewController:imagePickerVc animated:YES completion:nil];
}
- (void)imagePickerController:(TZImagePickerController *)picker didFinishPickingPhotos:(NSArray<UIImage *> *)photos sourceAssets:(NSArray *)assets isSelectOriginalPhoto:(BOOL)isSelectOriginalPhoto
{
    NSString *key = [@(self.currentThumbIndex) stringValue];
    self.cerThumbsDic[key] = photos.firstObject;
    [self.feedBackTable reloadData];
}

#pragma mark ------- Private Method
- (void)submitBtnClicked {
    NSLog(@"点击了提交反馈按钮");
}

#pragma mark - 懒加载
- (CustomLabel *)headerLabel {
    if (!_headerLabel) {
        _headerLabel = [[CustomLabel alloc]initWithFrame:CGRectMake(0, 0, MAINScreenWidth, 45 * scaleX)];
        _headerLabel.text = @"留言时要把咨询或投诉举报的事情描述清楚，投诉举报某品牌刷票必 须有证据，留言内容可以上传图片。";
        _headerLabel.backgroundColor = [UIColor colorWithHexString:@"#FCEDB4"];
        _headerLabel.numberOfLines = 2;
        _headerLabel.font = [UIFont systemFontOfSize:12];
        _headerLabel.textAlignment = NSTextAlignmentLeft;
        _headerLabel.textColor = [UIColor colorWithHexString:@"#B09755"];
        
        _headerLabel.edgeInsets = UIEdgeInsetsMake(5.5 * scaleX, 15 * scaleX, 6.5 * scaleX, 15 * scaleX);//设置内边距
        [_headerLabel sizeToFit];//重新计算尺寸，会执行Label内重写的方法
    }
    return _headerLabel;
}

- (UITableView *)feedBackTable {
    if (!_feedBackTable) {
        _feedBackTable = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        _feedBackTable.separatorStyle = UITableViewCellSeparatorStyleNone;
        _feedBackTable.backgroundColor = [UIColor clearColor];
        _feedBackTable.delegate = self;
        _feedBackTable.dataSource = self;
        _feedBackTable.estimatedRowHeight = 156 * scaleX;
    }
    return _feedBackTable;
}

- (UIButton *)submitBtn {
    if (!_submitBtn) {
        _submitBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _submitBtn.frame = CGRectMake(0, 0, MAINScreenWidth, 54 * scaleX);
        [_submitBtn setTitle:@"提交反馈" forState:UIControlStateNormal];
        [_submitBtn setTitleColor:[UIColor colorWithHexString:@"#FE534D"] forState:UIControlStateNormal];
        _submitBtn.titleLabel.font = [UIFont systemFontOfSize:16];
        _submitBtn.backgroundColor = [UIColor whiteColor];
        [_submitBtn addTarget:self action:@selector(submitBtnClicked) forControlEvents:UIControlEventTouchUpInside];
    }
    return _submitBtn;
}

-(NSMutableDictionary *)cerThumbsDic
{
    if (!_cerThumbsDic) {
        NSDictionary *thumCache = [JoinInputCache share].imagesCache;
        if (thumCache) {
            _cerThumbsDic = [thumCache mutableCopy];
        }else{
            _cerThumbsDic = [[NSMutableDictionary alloc]init];
        }
    }
    return _cerThumbsDic;
}

@end

