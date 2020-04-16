//
//  ServicePopView.m
//  ZhongQiBrand
//
//  Created by iOS on 2019/10/21.
//  Copyright © 2019 CY. All rights reserved.
//

#import "ServicePopView.h"
#import "ServiceTypeCell.h"
#import "UIWindow+FrontWindow.h"

@interface ServicePopView ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) NSArray *titleArr;
@property (nonatomic, strong) NSArray *imageArr;
@property (nonatomic, strong) UIImageView *blurImageView;
@property (nonatomic, strong) UITableView *serviceTable;

@end

@implementation ServicePopView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        _titleArr = @[@"微信客服",@"QQ客服",@"电话客服"];
        _imageArr = @[@"service_wechat_icon",@"service_qq_icon",@"service_phone_icon"];
        
        [self insertSubview:self.blurImageView atIndex:0];
        [self addSubview:self.serviceTable];
        [_serviceTable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.left.mas_equalTo(0);
            make.bottom.mas_equalTo(-53 * scaleX);
            make.height.mas_equalTo(202.5 * scaleX);
        }];
    }
    return self;
}

+ (instancetype)showInWindow {
    ServicePopView *serviceView = [[ServicePopView alloc] initWithFrame:CGRectMake(0, 0, MAINScreenWidth, MAINScreenHeight)];
    [serviceView show];
    return serviceView;
}

- (void)show{
    UIWindow *window = [UIWindow frontWindow];
    [window addSubview:self];
}

- (void)clickAction {
    [self hiden];
}

- (void)hiden{
    [self removeFromSuperview];
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch  {
    
    //点击的view的类名
    NSLog(@"%@", NSStringFromClass([touch.view class]));
    
    // UITableViewCellContentView就是点击了tableViewCell，则不截获点击事件
    if ([NSStringFromClass([touch.view class]) isEqualToString:@"UITableViewCellContentView"]){
        return NO;
    }
    return  YES;
}

#pragma mark - UITableView Delegate &Datasource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ServiceTypeCell *serviceCell = [ServiceTypeCell cellWithTableView:tableView];
    serviceCell.serviceLabel.text = self.titleArr[indexPath.row];
    serviceCell.serviceImg.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@",self.imageArr[indexPath.row]]];
    return serviceCell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
	!_customClickedBlock?:_customClickedBlock(indexPath.row);
	[self hiden];
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

#pragma mark - 懒加载
- (UITableView *)serviceTable {
    if (!_serviceTable) {
        _serviceTable = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        _serviceTable.separatorStyle = UITableViewCellSeparatorStyleNone;
        _serviceTable.backgroundColor = [UIColor clearColor];
        _serviceTable.delegate = self;
        _serviceTable.dataSource = self;
        _serviceTable.scrollEnabled = NO;
        _serviceTable.showsHorizontalScrollIndicator = NO;
        _serviceTable.showsVerticalScrollIndicator = NO;
        _serviceTable.estimatedRowHeight = 67.5 * scaleX;
        _serviceTable.rowHeight = 67.5 * scaleX;
    }
    return _serviceTable;
}

- (UIImageView *)blurImageView {
    if (!_blurImageView) {
        _blurImageView = [[UIImageView alloc]initWithFrame:self.bounds];
        _blurImageView.image = [UIImage imageNamed:@"service_bg_img"];
        _blurImageView.userInteractionEnabled = YES;
        //添加点击手势
        UITapGestureRecognizer *click = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickAction)];
        [_blurImageView addGestureRecognizer:click];
    }
    return _blurImageView;
}


@end
