//
//  HeadLinesSubViewController.m
//  ZhongQiBrand
//
//  Created by ios2 on 2019/9/21.
//  Copyright © 2019 CY. All rights reserved.
//

#import "HeadLinesSubViewController.h"
#import "MJHeader.h"
#import "HeadeLinesBigImgeCell.h"
#import "HeadeLinesSmallImgeCell.h"
#import "HeadLineResponse.h"

@interface HeadLinesSubViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong) UITableView    *listTableView;
@property (nonatomic,strong)NSMutableArray *dataSource;
@end

@implementation HeadLinesSubViewController

- (void)viewDidLoad {
    [super viewDidLoad];
	self.view.backgroundColor =[UIColor whiteColor];
	[self setUpUI];
	self.view.lgPlaceholder.state = LgPlaceLoadingState;
	WS(ws);
	[self.view.lgPlaceholder setActionBlock:^(LgPlaceholderState state) {
		if (state != LgPlaceLoadingState) {
			ws.view.lgPlaceholder.state = LgPlaceLoadingState;
			[ws.listTableView.mj_header beginRefreshing];
		}
	}];
}

-(void)setUpUI
{
	[self.view addSubview:self.listTableView];
	[self.listTableView registerClass:[HeadeLinesBigImgeCell class] forCellReuseIdentifier:@"HeadeLinesBigImgeCell"];
	[self.listTableView registerClass:[HeadeLinesSmallImgeCell class] forCellReuseIdentifier:@"HeadeLinesSmallImgeCell"];
	self.listTableView.estimatedRowHeight = 44;
	self.listTableView.delegate = self;
	self.listTableView.dataSource = self;

	[self.listTableView mas_makeConstraints:^(MASConstraintMaker *make) {
		make.edges.equalTo(self.view);
	}];
	MJHeader *mjHeader = [MJHeader headerWithRefreshingTarget:self refreshingAction:@selector(pullRefresh)];
	self.listTableView.mj_header = mjHeader;
	[mjHeader beginRefreshing];
}

-(void)pullRefresh
{
	[self requestDataSource];
}
-(void)requestDataSource
{
	TokenModel *token = [TokenModel new];
	token.method = @"home";
	NSMutableDictionary *parma = [token.dictionary mutableCopy];
	parma[@"action"] = @"newslist";
	parma[@"fenlei"] = self.fenlei;
	__weak typeof(self)ws = self;
	[RequestBaseTool postUrlStr:AppendAPI(APPURL_prefix, Brand_headLine_prefix)
					   andParms:parma
				  andCompletion:^(id obj) {
		NSLog(@"输出结果：|%@",obj);
					  HeadLineResponse *response = [[HeadLineResponse alloc]initWithDictionary:obj];
					  [ws requestResponse:response];
	} Error:^(NSError *errror) {
		NSLog(@"输出错误结果: |%@",errror);
	}];
}

-(void)requestResponse:(HeadLineResponse *)response
{
	if ([response.status isEqualToString:@"1"]) {
		[self.dataSource removeAllObjects];//临时测试使用。。。
		[self.dataSource addObjectsFromArray:response.data];
	}
	if (ArrayIsEmpty(self.dataSource)) {
		self.view.lgPlaceholder.state =LgPlaceNoDataState;
	}else{
		self.view.lgPlaceholder.state = LgPlaceNormalState;
	}
	[self.listTableView reloadData];
	[self.listTableView.mj_header endRefreshing];
}

#pragma mark - 协议方法
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
	return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	return self.dataSource.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	if (indexPath.row<self.dataSource.count) {

		BrandHeadModel *model = self.dataSource[indexPath.row];
		NSString *identifier = (model.title.length >22)?@"HeadeLinesSmallImgeCell":@"HeadeLinesBigImgeCell";
		HeadLinesBaseCell *cell =  [tableView dequeueReusableCellWithIdentifier:identifier forIndexPath:indexPath];
		cell.model = model;
		[cell setSelectionStyle:UITableViewCellSelectionStyleNone];
		return cell;
	}
	return [UITableViewCell new];
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    UIViewController *vc =[[NSClassFromString(@"XFWkwebView") alloc]init];
//    HelpListModel *model = self.dataArray.mutableCopy[indexPath.row];
    [vc setValue:@"www.baidu.com" forKey:@"linkUrl"];
    [vc setValue:[UIColor colorWithHexString:@"#f6f6f6"] forKey:@"trackColor"];
    [vc setValue:[UIColor colorWithHexString:@"#FE9B0E"] forKey:@"progressColor"];
    [self.navigationController pushViewController:vc animated:YES];
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
	return UITableViewAutomaticDimension;
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

#pragma mark - Other Delegate
#pragma mark - JXCategoryListCollectionContentViewDelegate
- (UIView *)listView {
	return self.view;
}

-(UITableView *)listTableView
{
	if (!_listTableView) {
		_listTableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStyleGrouped];
		_listTableView.backgroundColor = [UIColor whiteColor];
		_listTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
		_listTableView.platformView.title = @"————  我们是有底线的  ————";
		_listTableView.platformView.textColor = [UIColor colorWithHexString:@"#999999"];
		_listTableView.platformView.textFont = [UIFont systemFontOfSize:12];
		_listTableView.platformView.isNotBottom = YES; //关闭在最底部
	 }
	return _listTableView;
}
-(NSMutableArray *)dataSource
{
	if (!_dataSource) {
		_dataSource = [[NSMutableArray alloc]init];
	 }
	return _dataSource;
}


@end
