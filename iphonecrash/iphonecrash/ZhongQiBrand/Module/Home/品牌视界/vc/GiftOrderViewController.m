//
//  GiftOrderViewController.m
//  ZhongQiBrand
//
//  Created by ios 001 on 2019/10/21.
//  Copyright © 2019 CY. All rights reserved.
//

#import "GiftOrderViewController.h"
#import "GiftPayTypeCell.h"//订单支付方式cellcell
#import "GiftOrderInfoCell.h"//订单第一层cell
#import "OrderProtrolAlertView.h"
#import "GiftOrderPayResultViewController.h"
@interface GiftOrderViewController ()<UITableViewDelegate, UITableViewDataSource>
/** 列表 */
@property (nonatomic,strong) UITableView *tableView;
/** 数据源 */
@property (nonatomic,strong) NSMutableArray *dataArr;
/** info */
@property (nonatomic,strong) NSMutableArray *infoDataArr;
/** 协议弹框 */
@property (nonatomic,strong) OrderProtrolAlertView *protrolAlert;
/** 是否阅读协议 */
@property (nonatomic,assign)  BOOL isReaded;

@end

@implementation GiftOrderViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"订单支付";
    [self initNavView];
    [self initBackNavItem];
    [self initData];
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.navView.mas_bottom);
        make.left.right.bottom.mas_equalTo(0);
    }];
    
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    BlackStatusBar;
}
-(void)initData{
    self.dataArr = @[@"耐克",@"10个",@"600票",@"180.00元"].mutableCopy;
    self.infoDataArr = @[@"品 牌",@"数 量",@"贡献值",@"总金额"].mutableCopy;
}
-(void)initBackNavItem {
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc]initWithImage:[[UIImage imageNamed:@"all_fahuia_btn"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:(UIBarButtonItemStylePlain) target:self action:@selector(backClicked:)];
    self.navigationItem.leftBarButtonItem = backItem;
}

#pragma mark - tableView
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return 4;
    }else{
        return 1;
    }
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        GiftOrderInfoCell *cell=[GiftOrderInfoCell cellWithTableView:tableView withIdentifier:NSStringFromClass([GiftOrderInfoCell class]) indexPath:indexPath];
        cell.infolabel.text = self.infoDataArr[indexPath.row];
        cell.numLabel.text = self.dataArr[indexPath.row];
        if (indexPath.row == 3) {
            [cell.numLabel setTextColor:[UIColor colorWithHexString:@"#C03128"]];
            [cell.numLabel setFont:[UIFont boldSystemFontOfSize:17]];
        }
        return cell;
        
    }else{
        GiftPayTypeCell *cell=[GiftPayTypeCell cellWithTableView:tableView withIdentifier:NSStringFromClass([GiftPayTypeCell class]) indexPath:indexPath];
        [cell.payType setImage:[UIImage imageNamed:@"order_ddzf_wxtb_icon"]];
        cell.payName.text  = @"微信支付";
        return cell;
    }
    
}
#pragma mark - <UITableViewDelegate>

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *view = [[UIView alloc]init];
    if (section == 0) {
        UIImageView *gift = [[UIImageView alloc]init];
        [view addSubview:gift];
        [gift setImage:[UIImage imageNamed:@"gift_slw_fdz_img"]];
        [gift mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(view);
            make.top.mas_offset(px_scale(40));
            make.width.height.mas_equalTo(px_scale(180));
        }];
        UILabel *giftName = [[UILabel alloc]init];
        [giftName setText:@"福袋"];
        [giftName setFont:[UIFont boldSystemFontOfSize:15]];
        [view addSubview:giftName];
        [giftName mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(gift);
            make.top.mas_equalTo(gift.mas_bottom);
        }];
        return view;
    }else{
        UIView *line = [[UIView alloc]init];
        line.backgroundColor = [UIColor colorWithHexString:@"#E5E5E5"];
        [view addSubview:line];
        [line mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_offset(px_scale(30));
            make.right.mas_offset(px_scale(-30));
            make.top.mas_offset(px_scale(30));
            make.height.mas_equalTo(px_scale(1));
        }];
        UILabel *orderType= [[UILabel alloc]init];
        [orderType setText:@"支付方式"];
        [orderType setFont:[UIFont boldSystemFontOfSize:17]];
        [view addSubview:orderType];
        [orderType mas_makeConstraints:^(MASConstraintMaker *make) {
            make.
            top.mas_equalTo(line.mas_bottom).mas_offset(px_scale(30));
            make.left.mas_offset(px_scale(30));
        }];
        return view;
    }
    
}
-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView *view = [[UIView alloc]init];
    if (section == 1) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setImage:[UIImage imageNamed:@"order_slw_qry_icon"] forState:UIControlStateNormal];
        [button setImage:[UIImage imageNamed:@"order_slw_qryxz_icon"] forState:UIControlStateSelected];
        [button addTarget:self action:@selector(delegateClick:) forControlEvents:UIControlEventTouchUpInside];
        [view addSubview:button];
        [button mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_offset(px_scale(30));
            make.top.mas_offset(px_scale(30));
            make.height.width.mas_equalTo(px_scale(26));
        }];
        UILabel *label1 = [[UILabel alloc]init];
        [label1 setText:@"我已查看并阅读"];
        [label1 setFont:[UIFont systemFontOfSize:14]];
        [label1 setTextColor:[UIColor colorWithHexString:@"#333333"]];
        [view addSubview:label1];
        [label1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(button);
            make.left.mas_equalTo(button.mas_right).mas_offset(px_scale(10));
        }];
        UILabel *label2 = [[UILabel alloc]init];
        [label2 setText:@"《支付协议》"];
        [label2 setFont:[UIFont systemFontOfSize:14]];
        [label2 setTextColor:[UIColor colorWithHexString:@"#C03128"]];
        [view addSubview:label2];
        [label2 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(button);
            make.left.mas_equalTo(label1.mas_right);
        }];
        label2.userInteractionEnabled = YES;
        UITapGestureRecognizer *singalTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(Readdelegate:)];
        [label2 addGestureRecognizer:singalTap];
        
        UIButton *sureBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [view addSubview:sureBtn];
        [sureBtn setBackgroundColor:[UIColor colorWithHexString:@"#D3141C"]];
        [sureBtn setTitle:@"确认" forState:UIControlStateNormal];
        [sureBtn setTintColor:[UIColor whiteColor]];
        sureBtn.titleLabel.font = [UIFont boldSystemFontOfSize:15];
        
        [sureBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_offset(px_scale(30));
            make.right.mas_offset(-px_scale(30));
            make.top.mas_equalTo(label2.mas_bottom).mas_offset(px_scale(34));
            make.height.mas_equalTo(px_scale(88));
        }];
        sureBtn.layer.cornerRadius =px_scale(44);
        sureBtn.layer.masksToBounds = YES;
        [sureBtn addTarget:self action:@selector(sureBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        UILabel *label3 = [[UILabel alloc]init];
        [label3 setText:@"如有疑问,请致电"];
        [label3 setFont:[UIFont systemFontOfSize:14]];
        [label3 setTextColor:[UIColor colorWithHexString:@"#333333"]];
        [view addSubview:label3];
        [label3 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(view.mas_centerX);
            make.top.mas_equalTo(sureBtn.mas_bottom).mas_offset(px_scale(65));
        }];
        
        UILabel *label4 = [[UILabel alloc]init];
        [label4 setText:@"400-159-0958"];
        label4.userInteractionEnabled = YES;
        [label4 setFont:[UIFont systemFontOfSize:14]];
        [label4 setTextColor:[UIColor colorWithHexString:@"#C03128"]];
        [view addSubview:label4];
        [label4 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(label3);
            make.left.mas_equalTo(label3.mas_right);
        }];
        UITapGestureRecognizer *singalTapTell = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(CallMe:)];
        [label4 addGestureRecognizer:singalTapTell];
        return view;
    }else{
        return view;
    }
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return px_scale(300);
    }else{
        return px_scale(150);
    }
    
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    if (section == 1) {
        return px_scale(300);
    }else{
        return CGFLOAT_MIN;
    }
}

#pragma mark ——— mathood
-(void)delegateClick:(UIButton *)sender{
    sender.selected=!sender.selected;
    self.isReaded = sender.selected;
}
-(void)Readdelegate:(UIGestureRecognizer *)UIGestureRecognizer{
   NSString * contentString = @"这是一个协议内容这是一个协议内容这是一个协议内容这是一个协议内容这是一个协议内容这是一个协议内容这是一个协议内容这是一个协议内容这是一个协议内容这是一个协议内容这是一个协议内容这是一个协议内容这是一个协议内容这是一个协议内容这是一个协议内容这是一个协议内容这是一个协议内容这是一个协议内容这是一个协议内容这是一个协议内容这是一个协议内容这是一个协议内容这是一个协议内容这是一个协议内容这是一个协议内容这是一个协议内容这是一个协议内容这是一个协议内容这是一个协议内容这是一个协议内容这是一个协议内容这是一个协议内容这是一个协议内容这是一个协议内容这是一个协议内容这是一个协议内容这是一个协议内容这是一个协议内容这是一个协议内容这是一个协议内容这是一个协议内容这是一个协议内容这是一个协议内容这是一个协议内容这是一个协议内容这是一个协议内容这是一个协议内容这是一个协议内容这是一个协议内容这是一个协议内容这是一个协议内容这是一个协议内容这是一个协议内容这是一个协议内容这是一个协议内容这是一个协议内容这是一个协议内容这是一个协议内容这是一个协议内容这是一个协议内容这是一个协议内容这是一个协议内容这是一个协议内容这是一个协议内容这是一个协议内容这是一个协议内容这是一个协议内容这是一个协议内容这是一个协议内容这是一个协议内容这是一个协议内容这是一个协议内容这是一个协议内容这是一个协议内容这是一个协议内容这是一个协议内容这是一个协议内容这是一个协议内容这是一个协议内容这是一个协议内容这是一个协议内容这是一个协议内容这是一个协议内容这是一个协议内容这是一个协议内容这是一个协议内容这是一个协议内容这是一个协议内容";
       
   [OrderProtrolAlertView showAlertWithContentString:contentString];
}
-(void)CallMe:(UIGestureRecognizer *)UIGestureRecognizer{
    NSString *telephoneNumber=@"4001590958";
    NSMutableString * str=[[NSMutableString alloc] initWithFormat:@"telprompt://%@",telephoneNumber];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];
}
-(void)backClicked:(UIButton *)sender{
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)sureBtnClick:(UIButton *)sender{
    if (self.isReaded) {
          GiftOrderPayResultViewController *vc = [[GiftOrderPayResultViewController alloc]init];
          [self.navigationController pushViewController:vc animated:YES];
    }else{
        [WDAlert showAlertWithMessage:@"请先阅读支付协议" time:1.5f];
    }
  
}
#pragma mark - Setter & Getter

-(UITableView *)tableView {
    
    if(!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.delegate =self;
        _tableView.dataSource =self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.backgroundColor = [UIColor whiteColor];
        [_tableView registerClass:[GiftPayTypeCell class] forCellReuseIdentifier:NSStringFromClass([GiftPayTypeCell class])];
        [_tableView registerClass:[GiftOrderInfoCell class] forCellReuseIdentifier:NSStringFromClass([GiftOrderInfoCell class])];
        _tableView.rowHeight = px_scale(58);
        _tableView.scrollEnabled = NO;
    }
    
    return _tableView;
}
@end
