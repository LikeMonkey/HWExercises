//
//  HomeViewController.m
//  ZhongQiBrand
//
//  Created by 孙程 on 2019/9/16.
//  Copyright © 2019 CY. All rights reserved.
//

#import "HomeViewController.h"
#import "VoteViewController.h"
#import "HelpCenterController.h"
#import "HomeJoinActivityViewController.h"
#import "SDCycleScrollView.h"
#import "HomeActionTableViewCell.h"
#import "HomeFastVoteTableViewCell.h"
#import "HomeHotTableViewCell.h"
#import "BrandVisionTableViewCell.h"
#import "HomeHeadlinesCell.h"
#import "ServicePopView.h"

#import "HomeTableHeaderView.h"
#import "VoteBrandDetailViewController.h"


#import <WXApi.h>
#import <UMShare/UMShare.h>
#import "UMSocialManager+UMLogin.h"

#import "HomeTimeManager.h"

#import "HomeResponse.h"
#import "HomeFastVoteResponse.h"

@interface HomeViewController ()<UITableViewDataSource,UITableViewDelegate,SDCycleScrollViewDelegate>
{
	SDCycleScrollView *_cycleScrollView;
}
@property (nonatomic,strong)UITableView *myTableView;

@property (nonatomic,strong)HomeResponse *homeResponse;
@property (nonatomic,strong)NSMutableArray *fastVoteArray; //快速投票数组
@end

@implementation HomeViewController
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    BlackStatusBar;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initNavView];
    self.lineView.hidden = YES;
    self.navigationItem.title = @"中企品牌网";
    [self setUpUI];

	//启动定时
	if (Nex_vote_timeLine) {
		[HomeTimeManager startTime];
	}
}
#pragma mark - setUpUI
-(void)setUpUI {
    [self.view addSubview:self.myTableView];
    [self.myTableView registerClass:[HomeActionTableViewCell class] forCellReuseIdentifier:@"HomeActionTableViewCell"];
    [self.myTableView registerClass:[HomeFastVoteTableViewCell class] forCellReuseIdentifier:@"HomeFastVoteTableViewCell"];
    [self.myTableView registerClass:[HomeHotTableViewCell class] forCellReuseIdentifier:@"HomeHotTableViewCell"];
    [self.myTableView registerClass:[BrandVisionTableViewCell class] forCellReuseIdentifier:@"BrandVisionTableViewCell"];
    [self.myTableView registerClass:[HomeTableHeaderView class] forHeaderFooterViewReuseIdentifier:@"HomeTableHeaderView"];
    [self.myTableView registerClass:[HomeHeadlinesCell class] forCellReuseIdentifier:@"HomeHeadlinesCell"];
    [self.myTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.mas_equalTo(0);
        make.top.equalTo(self.navView.mas_bottom);
    }];
    UIView *tableHeaderView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, MAINScreenWidth, px_scale(350))];
    tableHeaderView.backgroundColor  = [UIColor whiteColor];
    self.myTableView.tableHeaderView = tableHeaderView;
    SDCycleScrollView *cycleScrollView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(px_scale(30), px_scale(30), MAINScreenWidth-px_scale(60), px_scale(320)) delegate:self placeholderImage:[UIImage imageNamed:@"home_banner_img"]];
	_cycleScrollView = cycleScrollView;
    _cycleScrollView.currentPageDotColor = ThemeColor;
    cycleScrollView.localizationImageNamesGroup = @[@"home_banner_img"];
    [tableHeaderView addSubview:cycleScrollView];
    
    MJHeader *refreshHeader = [MJHeader headerWithRefreshingTarget:self refreshingAction:@selector(pullDownRefresh)];
    self.myTableView.mj_header = refreshHeader;
    [self loadCustomServer];
	[refreshHeader beginRefreshing];
}

#pragma mark - request dataSource
-(void)requestFromServer
{
	TokenModel *token = [TokenModel new];
	token.method = @"home";//特殊参数
	token.auth = @"home";
	NSMutableDictionary *parm = [token.dictionary mutableCopy];
	WS(ws);
	[RequestBaseTool postUrlStr:AppendAPI(APPURL_prefix, Home_prefix)
					   andParms:parm
				  andCompletion:^(id obj) {
					  HomeResponse *response = [[HomeResponse alloc]initWithDictionary:obj];
					  if ([response.status isEqualToString:@"1"]) {
						  ws.homeResponse = response;
						  self->_cycleScrollView.imageURLStringsGroup = response.banner;
						  self->_cycleScrollView.autoScroll = YES;
						  [ws.myTableView reloadData];
					  }
					  [ws endRefresh];
	} Error:^(NSError *errror) {
		NSLog(@"%@",errror);
	}];
	//获取另一个数据 测试先这样写 以后让后台改结构 。。。。。
	[self requstFastVoteData];
	
}
-(void)requstFastVoteData
{
	TokenModel *token = [TokenModel new];
	token.method = @"home";
	token.auth = @"home";
	NSMutableDictionary *parma = [token.dictionary mutableCopy];
	parma[@"ouid"] = USER_ID?USER_ID:@"0";
	[RequestBaseTool postUrlStr:AppendAPI(APPURL_prefix, Home_vote_prefix)
					   andParms:parma
				  andCompletion:^(id obj) {
					  HomeFastVoteResponse *response = [[HomeFastVoteResponse alloc]initWithDictionary:obj];
					  if ([response.status isEqualToString:@"1"]) {
						  [self.fastVoteArray removeAllObjects];
						  [self.fastVoteArray addObjectsFromArray:response.data];
					  }
					  [self.myTableView reloadData];
				  } Error:^(NSError *errror) {
					  NSLog(@"%@",errror);  //后台 有问题 -------------
				  }];
}
#pragma mark - MJRefresh Target Method
-(void)pullDownRefresh {
	[self requestFromServer];
}

-(void)endRefresh {
    [self.myTableView.mj_header endRefreshing];
}

#pragma mark - cell public method
-(void)homeActionCellClicked:(NSInteger)index {
    if (index == 0) {
        // 品牌宗旨
        UIViewController *brandPurposeVc = [[NSClassFromString(@"XFWkwebView") alloc]init];
        [brandPurposeVc setValue:@"https://baike.baidu.com/item/计算器/780232?fr=aladdin" forKey:@"linkUrl"];
        [brandPurposeVc setValue:[UIColor colorWithHexString:@"#f6f6f6"] forKey:@"trackColor"];
        [brandPurposeVc setValue:[UIColor colorWithHexString:@"#FE9B0E"] forKey:@"progressColor"];
        !brandPurposeVc?:[self.navigationController pushViewController:brandPurposeVc animated:YES];
    }
    if (index == 1) {
        // 参加活动
        HomeJoinActivityViewController *joinVC = [[HomeJoinActivityViewController alloc] init];
        joinVC.processType = JoinActivityProcessTypeAuthentication;
        [self.navigationController pushViewController:joinVC animated:YES];
    }
    if (index == 2) {
        // 帮助中心
        UIViewController *helpCenterVc = [[NSClassFromString(@"HelpCenterController") alloc]init];
        !helpCenterVc?:[self.navigationController pushViewController:helpCenterVc animated:YES];
    }
    if (index == 3) {
        // 中企头条详情
        UIViewController *headLinesVc = [[NSClassFromString(@"HeadLinesViewController") alloc]init];
        !headLinesVc?:[self.navigationController pushViewController:headLinesVc animated:YES];
    }
}

#pragma mark - UITableViewDelegate And DataSource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
	if (!_homeResponse) {
		return 1;
	}
    return 5;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section < 3) {
		if (section == 1) {
			return 1;
			if (self.fastVoteArray.count<=0) return 0;
		}
        return 1;
    }
    if (section == 3) {
		if (_homeResponse.brands) {
			return _homeResponse.brands.count;
		}
        return 0;
    }
    if (section == 4) {
        return _homeResponse.newslist.count;
    }
    return 0;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = nil;
    if (indexPath.section == 0) {
        WS(ws);
        // 品牌宗旨/参加活动/帮助中心/中企头条
        HomeActionTableViewCell *actionCell = [tableView dequeueReusableCellWithIdentifier:@"HomeActionTableViewCell" forIndexPath:indexPath];
        [actionCell setHomeActionClicked:^(NSInteger index) {
            [ws homeActionCellClicked:index];
        }];
        cell = actionCell;
    }else if(indexPath.section == 1) {
        // 快速投票
        HomeFastVoteTableViewCell *fastVoteCell = [tableView dequeueReusableCellWithIdentifier:@"HomeFastVoteTableViewCell" forIndexPath:indexPath];
		fastVoteCell.dataArray = self.fastVoteArray;
        cell = fastVoteCell;
    }else if (indexPath.section == 2) {
        // 热门榜单
        HomeHotTableViewCell *hotCell = [tableView dequeueReusableCellWithIdentifier:@"HomeHotTableViewCell" forIndexPath:indexPath];
		hotCell.brandArray = _homeResponse.hotList;
		cell = hotCell;
    }else if (indexPath.section == 3) {
        // 品牌视界
        BrandVisionTableViewCell *visionCell = [tableView dequeueReusableCellWithIdentifier:@"BrandVisionTableViewCell" forIndexPath:indexPath];
		visionCell.isBottom = (indexPath.row == (_homeResponse.brands.count -1));
		visionCell.model = _homeResponse.brands[indexPath.row];
        cell = visionCell;
    }else if (indexPath.section == 4) {
        // 中企头条
        HomeHeadlinesCell *headLinesCell = [tableView dequeueReusableCellWithIdentifier:@"HomeHeadlinesCell" forIndexPath:indexPath];
		headLinesCell.model = _homeResponse.newslist[indexPath.row];
        cell = headLinesCell;
    }
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

	if (indexPath.section == 4) {
		UIViewController *vc =[[NSClassFromString(@"XFWkwebView") alloc]init];
		[vc setValue:@"http://www.baidu.com" forKey:@"linkUrl"];
		[vc setValue:[UIColor colorWithHexString:@"#f6f6f6"] forKey:@"trackColor"];
		[vc setValue:[UIColor colorWithHexString:@"#FE9B0E"] forKey:@"progressColor"];
		[self.navigationController pushViewController:vc animated:YES];

	}else if(indexPath.section == 3){
        VoteBrandDetailViewController *vc = [[VoteBrandDetailViewController alloc]init];
        vc.brandModel = _homeResponse.brands[indexPath.row];
        [self.navigationController pushViewController:vc animated:YES];

	}else{
		[self vote:nil];

	}
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section==0) {
        return [HomeActionTableViewCell cellHeight];
    }else if(indexPath.section == 1) {
        return [HomeFastVoteTableViewCell fastVoteCellHeight];
    }else if (indexPath.section == 2) {
        return [HomeHotTableViewCell hotListHeight];
    }else if (indexPath.section == 3) {
        CGFloat cellHeight = px_scale(118+50);
		if (indexPath.row == (_homeResponse.brands.count -1)) {
            cellHeight = cellHeight + px_scale(60);
        }
        return cellHeight;
    }else if (indexPath.section == 4){
        return [HomeHeadlinesCell cellheight];
    }
    return 44.0f;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    CGFloat headerHeight = CGFLOAT_MIN;
    if (section == 1) {
		if (self.fastVoteArray.count<=0) return CGFLOAT_MIN;
        headerHeight = px_scale(106);
    }else if (section == 2){
		if (ArrayIsEmpty(_homeResponse.hotList))return CGFLOAT_MIN;
        headerHeight = px_scale(133);
    }else if (section == 3){
		if (ArrayIsEmpty(_homeResponse.brands))return CGFLOAT_MIN;
        headerHeight = px_scale(108);
    }else if (section == 4){
		if (ArrayIsEmpty(_homeResponse.newslist))return CGFLOAT_MIN;
        headerHeight = px_scale(132);
    }
    return headerHeight;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return CGFLOAT_MIN;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if (section !=0) {
        NSString * title, *english;
        if (section == 1) {
            title = @"快速投票";
            english = @"Quick poll";
			if (self.fastVoteArray.count<=0) return nil;
        }else if (section == 2){
            title = @"热门榜单";
            english = @"Hot list";
			if (!_homeResponse.hotList)return nil;
        }else if (section==3){
			if (!_homeResponse.brands)return nil;
            title = @"品牌视界";
            english = @"Brand vision";
        }else if (section == 4){
			if (!_homeResponse.newslist)return nil;
            title = @"品牌头条";
            english = @"Related";
        }
        HomeTableHeaderView *header = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"HomeTableHeaderView"];
		header.index = section;
        [header configerTitle:title  andEnglish:english andIsShowMore:(section == 1)?NO:YES];
		__weak typeof(self)ws = self;
		[header setDidClickedMoreBlock:^(NSInteger index) {
			if (index==2) {
				ws.tabBarController.selectedIndex = 1;
			}else if (index==3){
				ws.tabBarController.selectedIndex = 2;
			}else if (index==4){
				UIViewController *headLinesVc = [[NSClassFromString(@"HeadLinesViewController") alloc]init]; //中企头条
				!headLinesVc?:[ws.navigationController pushViewController:headLinesVc animated:YES];
			}
		}];
        return header;
    }
    return nil;
}
-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    return nil;
}
#pragma mark - getter
-(UITableView *)myTableView
{
    if (!_myTableView) {
        _myTableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        _myTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _myTableView.backgroundColor = [UIColor colorWithHexString:@"#F8F8F8"];
		_myTableView.platformView.title = @"————  我们是有底线的  ————";
		_myTableView.platformView.textColor = [UIColor colorWithHexString:@"#999999"];
		_myTableView.platformView.textFont = [UIFont systemFontOfSize:12];
		_myTableView.platformView.isNotBottom = NO; //是否一直停留在底部
        _myTableView.delegate = self;
        _myTableView.dataSource = self;
    }
    return _myTableView;
}

-(NSMutableArray *)fastVoteArray
{
	if (!_fastVoteArray)
	 {
		_fastVoteArray = [[NSMutableArray alloc]init];
	 }
	return _fastVoteArray;
}


#pragma mark - Target method
- (void)vote:(id)sender{
    VoteViewController *voteVC = [[VoteViewController alloc] init];
    [self.navigationController pushViewController:voteVC animated:YES];
}
-(void)debugLogin
{
    [[UMSocialManager defaultManager]getUserInfoWithPlatform:(UMSocialPlatformType_WechatSession) currentViewController:self completion:^(id result, NSError *error) {
        
    }];
    __weak typeof(self)ws = self;
    [[UMSocialManager defaultManager] setWxLoginResponse:^(id responde) {
        if ([responde isKindOfClass:[SendAuthResp class]]) {
            SendAuthResp *auth = (SendAuthResp *)responde;
            [ws login:auth.code andIsReview:NO];
        }
    }];
}

- (void)login:(NSString *)code andIsReview:(BOOL)isReview {
    TokenModel *token =[TokenModel new];
    token.method = @"login";
    NSMutableDictionary *mDic = [token.dictionary mutableCopy];
    mDic[@"code"] = code;
    [RequestBaseTool postUrlStr:AppendAPI(APPURL_prefix, @"/member/login.php")
                       andParms:mDic
                  andCompletion:^(id obj) {
                      NSLog(@"输出结果：|%@",obj);
                      BaseModel *model = [[BaseModel alloc]initWithDictionary:obj];
                      NSLog(@"输出返回msg：|%@",model.msg);
                  } Error:^(NSError *errror) {
                      NSLog(@"输出结果：|%@",errror);
                  }];
}
#pragma mark - 加载客服
-(void)loadCustomServer
{
    UIButton *customServer = [UIButton buttonWithType:UIButtonTypeCustom];
    [customServer setImage:[UIImage imageNamed:@"app_kfdh_icon"] forState:UIControlStateNormal];
    [customServer addTarget:self action:@selector(customServerClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:customServer];
    [customServer mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(px_scale(480));
        make.right.mas_equalTo(-px_scale(15));
        make.size.mas_equalTo((CGSize){px_scale(110),px_scale(110)});
    }];
}

- (void)customServerClicked:(UIButton *)sender {
    [ServicePopView showInWindow];
}

@end





