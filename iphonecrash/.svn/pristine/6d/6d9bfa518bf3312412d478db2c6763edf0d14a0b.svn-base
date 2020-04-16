//
//  WorldOfTheBrandDetailController.m
//  ZhongQiBrand
//
//  Created by ios 001 on 2019/10/17.
//  Copyright © 2019 CY. All rights reserved.
//

#import "WorldOfTheBrandDetailController.h"
#import "WorldOfTheBrandDetailCecll.h"

@interface WorldOfTheBrandDetailController ()<UITableViewDelegate, UITableViewDataSource>
/** tableView */
@property (nonatomic,strong) UITableView *tableView;
/** 品牌图片 */
@property (nonatomic,strong) UIImageView *brandImageView;
/** 品牌名称 */
@property (nonatomic,strong) UILabel *brandName;
/** 更新时间 */
@property (nonatomic,strong) UILabel *updateTime;
/** 排名图片 */
@property (nonatomic,strong) UIImageView *RankImageView;
/** 数据源 */
@property (nonatomic,strong) NSMutableArray *dataArr;
/** 数据源名称 */
@property (nonatomic,strong) NSMutableArray *infoArr;
/** 分享页面 */
@property (nonatomic,strong) SharePopView *popView;

@end

@implementation WorldOfTheBrandDetailController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"品牌详情";
    [self initNavView];
    [self initBackNavItem];
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.navView.mas_bottom);
        make.left.right.bottom.mas_equalTo(0);
    }];
    MJHeader *refreshHeader = [MJHeader headerWithRefreshingTarget:self refreshingAction:@selector(pullDownRefresh)];
    self.tableView.mj_header = refreshHeader;
    [self.tableView.mj_header beginRefreshing];
    WS(ws);
    self.view.lgPlaceholder.state =  LgPlaceLoadingState ;
    [self.view.lgPlaceholder setActionBlock:^(LgPlaceholderState state) {
        if (!(state == LgPlaceLoadingState)) {
            ws.view.lgPlaceholder.state = LgPlaceLoadingState;
            [ws.tableView.mj_header beginRefreshing];
        }
    }];
    
}

#pragma mark - MJRefresh Target Method
-(void)pullDownRefresh {
    if ([Server netWorkAvailable]) {
        NSLog(@"网络连接成功");
        [self requestFromServer];
    }else{
        [self.tableView.mj_header endRefreshing];
        if (ArrayIsEmpty(self.dataArr)) {
            self.view.lgPlaceholder.state = LgPlaceNonetState;
        }else{
            SHOW_MSG(@"网络连接失败，请检查网络设置",1);
        }
    }
    
}
#pragma mark - request dataSource
-(void)requestFromServer
{
    TokenModel *token = [TokenModel new];
    token.method = @"home";//特殊参数
    token.auth = @"home";
    //  self.nextPage
    NSMutableDictionary *parm = [token.dictionary mutableCopy];
    [parm setObject:self.listModel.itemid forKey:@"itemid"];
    WS(ws);
  
    [RequestBaseTool postUrlStr:AppendAPI(APPURL_prefix, Brand_world_detail_prefix)
                       andParms:parm
                  andCompletion:^(id obj) {
     
        [ws requestResponse:obj];
        NSLog(@"%@",obj);
        [self.tableView.mj_header endRefreshing];
    } Error:^(NSError *errror) {
    
        SHOW_MSG(@"请重新尝试", 1)
        [self.tableView.mj_header endRefreshing];
        NSLog(@"%@",errror);
    }];
}
-(void)requestResponse:(id )obj{
    NSNumber *status =[obj objectForKey:@"status"];
    if ([status integerValue] == 1) {
        [self.dataArr removeAllObjects];
        [self.infoArr removeAllObjects];
    }else{
        NSString *msg =[obj objectForKey:@"msg"];
        SHOW_MSG(msg, 1)
    }
    NSDictionary *dic = [obj objectForKey:@"data"];
    if (DicIsEmpty(dic)) {
        self.view.lgPlaceholder.state =LgPlaceNoDataState;
    }else{
        self.view.lgPlaceholder.state = LgPlaceNormalState;
        if (!NullString([dic objectForKey:@"title"])) {
            self.brandName.text = [dic objectForKey:@"title"];
        }
        if (!NullString([dic objectForKey:@"addtime"])) {
            self.updateTime.text = [NSString stringWithFormat:@"更新于%@",[dic objectForKey:@"addtime"]];
        }
        
        if (!NullString([dic objectForKey:@"thumb"])) {
            [self.brandImageView sd_setImageWithURL:[NSURL URLWithString:[dic objectForKey:@"thumb"]] placeholderImage:kGetImage(@"tpsq_btn_img")];
        }
        
        if (!NullString([dic objectForKey:@"company"])) {
            [self.dataArr addObject:[dic objectForKey:@"company"]];
            [self.infoArr addObject:@"公司名称:"];
        }
        if (!NullString([dic objectForKey:@"foundtime"])) {
            [self.dataArr addObject:[dic objectForKey:@"foundtime"]];
            [self.infoArr addObject:@"成立时间:"];
        }
        //后台没参数
        if (!NullString([dic objectForKey:@"business"])) {
            [self.dataArr addObject:[dic objectForKey:@"business"]];
            [self.infoArr addObject:@"所属行业:"];
        }
        if (!NullString([dic objectForKey:@"address"])) {
            [self.dataArr addObject:[dic objectForKey:@"address"]];
            [self.infoArr addObject:@"公司地址:"];
        }
        if (!NullString([dic objectForKey:@"homepage"])) {
            [self.dataArr addObject:[dic objectForKey:@"homepage"]];
            [self.infoArr addObject:@"官方网址:"];
        }
        if (!NullString([dic objectForKey:@"business"])) {
            [self.dataArr addObject:[dic objectForKey:@"business"]];
            [self.infoArr addObject:@"经营范围:"];
        }
    }
    //后台没参数
    [self.RankImageView setImage:[UIImage imageNamed:@"ppsj_zsp_icon"]];
    [self.tableView reloadData];
}
#pragma mark - Private Method

-(void)initBackNavItem {
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc]initWithImage:[[UIImage imageNamed:@"all_fahuia_btn"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:(UIBarButtonItemStylePlain) target:self action:@selector(backClicked:)];
    self.navigationItem.leftBarButtonItem = backItem;
    
    UIBarButtonItem *shareItem = [[UIBarButtonItem alloc]initWithImage:[[UIImage imageNamed:@"ppsj_ppmp_fxtb_icon"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:(UIBarButtonItemStylePlain) target:self action:@selector(shareBtnClick)];
    self.navigationItem.rightBarButtonItem = shareItem;
    
}
#pragma mark - tableView
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return self.dataArr.count;
    }else{
        return 0;
    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    WorldOfTheBrandDetailCecll *cell=[WorldOfTheBrandDetailCecll cellWithTableView:tableView withIdentifier:NSStringFromClass([WorldOfTheBrandDetailCecll class]) indexPath:indexPath];
    cell.infoLabel.text =self.infoArr[indexPath.row];
    [cell confingContentLableWithString:self.dataArr[indexPath.row]];
    return cell;
}
#pragma mark - <UITableViewDelegate>
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}
-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView *view = [[UIView alloc]init];
    view.backgroundColor = [UIColor clearColor];
    
    return view;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *view = [[UIView alloc]init];
    view.backgroundColor = [UIColor whiteColor];
    UITapGestureRecognizer *singalTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(headerViewClick:)];
    [view addGestureRecognizer:singalTap];
    //  品牌头部试图
    if (section == 0) {
        
        [view addSubview:self.brandImageView];
        [self.brandImageView addSubview:self.RankImageView];
        
        [view addSubview:self.brandName];
        
        [view addSubview:self.updateTime];
        
        UIImageView *timeUpdataImage = [[UIImageView alloc]init];
        [timeUpdataImage setImage:[UIImage imageNamed:@"ppsj_time_show_icon"]];
        [view addSubview:timeUpdataImage];
        
        UIView *line = [[UIView alloc]init];
        line.backgroundColor = [UIColor colorWithHexString:@"#EDEDED"];
        
        [view addSubview:line];
        
        [self.brandName mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_offset(px_scale(50));
            make.top.mas_equalTo(px_scale(50));
            make.right.mas_equalTo(self.brandImageView.mas_left).mas_offset(-px_scale(15));
        }];
        [self.brandImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_offset(px_scale(50));
            make.right.mas_offset(px_scale(-50));
            make.width.mas_equalTo(px_scale(204));
            make.height.mas_equalTo(px_scale(118));
            
        }];
        [self.RankImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.mas_equalTo(self.RankImageView);
        }];
        [timeUpdataImage mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.brandName);
            make.top.mas_equalTo(self.brandName.mas_bottom).mas_offset(px_scale(30));
        }];
        [self.updateTime mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(timeUpdataImage);
            make.left.mas_equalTo(timeUpdataImage.mas_right).mas_offset(px_scale(8));
        }];
        [line mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_offset(px_scale(50));
            make.right.mas_offset(px_scale(-50));
            make.bottom.mas_offset(px_scale(-40));
            make.height.mas_equalTo(px_scale(2));
        }];
    [self iconImgViewBoderColor:[UIColor colorWithHexString:@"#E9E9E9"] borderWidth:px_scale(2) cornerRadius:px_scale(10)];
    }else if(section== 1){
        //品牌介绍
        view.tag = 1;
        UIView *redView = [[UIView alloc]init];
        redView.backgroundColor = [UIColor colorWithHexString:@"#D3141C"];
        redView.layer.cornerRadius = px_scale(4);
        redView.layer.masksToBounds = YES;
        
        UILabel *titlelabel = [[UILabel alloc]init];
        [titlelabel setFont:[UIFont boldSystemFontOfSize:16]];
        titlelabel.textColor = [UIColor colorWithHexString:@"#333333"];
        titlelabel.text = @"品牌介绍";
        UIImageView *rightArrow = [[UIImageView alloc]init];
        [rightArrow setImage:[UIImage imageNamed:@"ppsj__pre_btn_icon"]];
        
        [view addSubview:redView];
        [view addSubview:titlelabel];
        [view addSubview:rightArrow];
        [redView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(view);
            make.left.mas_offset(px_scale(50));
            make.height.mas_equalTo(px_scale(30));
            make.width.mas_equalTo(px_scale(8));
        }];
        [titlelabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(view);
            make.left.mas_equalTo(redView.mas_right).mas_offset(px_scale(20));
        }];
        [rightArrow mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_offset(px_scale(-50));
            make.centerY.mas_equalTo(view);
        }];
        
        
    }else{
        view.tag = 2;
        //更多介绍
        UIView *redView = [[UIView alloc]init];
        redView.backgroundColor = [UIColor colorWithHexString:@"#D3141C"];
        redView.layer.cornerRadius = px_scale(4);
        redView.layer.masksToBounds = YES;
        
        UILabel *titlelabel = [[UILabel alloc]init];
        [titlelabel setFont:[UIFont boldSystemFontOfSize:16]];
        titlelabel.textColor = [UIColor colorWithHexString:@"#333333"];
        titlelabel.text = @"更多介绍";
        UIImageView *rightArrow = [[UIImageView alloc]init];
        [rightArrow setImage:[UIImage imageNamed:@"ppsj__pre_btn_icon"]];
        
        [view addSubview:redView];
        [view addSubview:titlelabel];
        [view addSubview:rightArrow];
        [redView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(view);
            make.left.mas_offset(px_scale(50));
            make.height.mas_equalTo(px_scale(30));
            make.width.mas_equalTo(px_scale(8));
        }];
        [titlelabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(view);
            make.left.mas_equalTo(redView.mas_right).mas_offset(px_scale(20));
        }];
        [rightArrow mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_offset(px_scale(-50));
            make.centerY.mas_equalTo(view);
        }];
        
    }
    return view;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return px_scale(20);
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return px_scale(280);
    }else{
        return px_scale(100);
    }
}
#pragma mark - Setter & Getter

-(UITableView *)tableView {
    
    if(!_tableView) {
        
        _tableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        
        _tableView.delegate =self;
        
        _tableView.dataSource =self;
        //        _tableView.scrollEnabled = YE;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [_tableView registerClass:[WorldOfTheBrandDetailCecll class] forCellReuseIdentifier:NSStringFromClass([WorldOfTheBrandDetailCecll class])];
        _tableView.estimatedRowHeight = px_scale(80);
    }
    
    return _tableView;
    
}

- (UIImageView *)brandImageView {
    if (!_brandImageView) {
        _brandImageView = [[UIImageView alloc]init];
      
    }
    return _brandImageView;
}

- (UILabel *)brandName {
    if (!_brandName) {
        _brandName = [[UILabel alloc]init];
        _brandName.font = [UIFont boldSystemFontOfSize:20];
        _brandName.textAlignment = NSTextAlignmentLeft;
        _brandName.textColor = [UIColor colorWithHexString:@"#333333"];
        
        
    }
    return _brandName;
}

- (UILabel *)updateTime {
    if (!_updateTime) {
        _updateTime = [[UILabel alloc]init];
        _updateTime.font = [UIFont systemFontOfSize:12];
        _updateTime.textAlignment = NSTextAlignmentLeft;
        _updateTime.textColor = [UIColor colorWithHexString:@"#333333"];
    }
    return _updateTime;
}

- (UIImageView *)RankImageView {
    if (!_RankImageView) {
        _RankImageView = [[UIImageView alloc]init];
    }
    return _RankImageView;
}

- (NSMutableArray *)dataArr {
    if (!_dataArr) {
        _dataArr = [NSMutableArray array];
    }
    return _dataArr;
}

- (NSMutableArray  *)infoArr {
    if (!_infoArr) {
        _infoArr = [NSMutableArray array];
        
    }
    return _infoArr;
}
#pragma mark - Target Mehtods

-(void)backClicked:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)shareBtnClick{
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
-(void)headerViewClick:(UITapGestureRecognizer *)gestureRecognizer{
    if (gestureRecognizer.view.tag == 1) {
        NSLog(@"点击了品牌介绍");
        return;
    }
    if (gestureRecognizer.view.tag == 2) {
        NSLog(@"点击了更多介绍");
        return;
    }
}
- (void)iconImgViewBoderColor:(UIColor *)color borderWidth:(CGFloat)borderWidth cornerRadius:(CGFloat)cornerRadius{
    self.brandImageView.layer.cornerRadius = cornerRadius;
    self.brandImageView.layer.borderColor = color.CGColor;
    self.brandImageView.layer.borderWidth = borderWidth;
    self.brandImageView.clipsToBounds = YES;
}
@end
