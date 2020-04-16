//
//  VoteModel.h
//  ZhongQiBrand
//
//  Created by 孙程 on 2019/9/17.
//  Copyright © 2019 CY. All rights reserved.
//

#import "BaseModel.h"

typedef enum : NSUInteger {
	ArrowNomalType = 0,      //正常状态
	ArrowUpType,             //上升状态
	ArrowDownType,           //下降状态
} ArrowType;

//活动状态
typedef enum : NSUInteger {
	ActivityNotStartedState,                             //活动未开始
	ActivityInProgressState,                             //活动进行中
	ActivityEndInThreeDayState,                          //活动结束三天内
	ActivityEndOutThreeDayState,                         //活动结束三天后
	ActivityUnCoverInThreeDayState,                      //揭榜前三天内
	ActivityUnCoverOutThreeDayState,                     //揭榜前三天后
	ActivityListFinalState,                              //活动榜单列表
} ActivityState;


@interface VoteModel : NSObject

@property (nonatomic, copy)   NSString  *icon;
@property (nonatomic, copy)   NSString  *votenum;

@property (nonatomic, assign) ActivityState type; //活动状态
@property (nonatomic, assign) ArrowType updown;   //条目趋势

@property (nonatomic, copy)   NSString  *index;
/** 品牌名称 */
@property (nonatomic,copy) NSString *brandName;
/** 公司地址     */
@property (nonatomic,copy) NSString *detailTitle;

/** 网址 */
@property (nonatomic,copy) NSString *webAddress;
//排名
@property (nonatomic,strong)NSString *ranking;
//itemid
@property (nonatomic,strong)NSString *itemid;
//sid
@property (nonatomic,strong)NSString *sid;
//item 标题
@property (nonatomic, strong)   NSString  *title;


@end

@interface VoteRequestResponse : BaseModel

@property (nonatomic,copy)NSString *voteNotice; //公告
@property (nonatomic,copy)NSString *votePhone; //客服电话
@property (nonatomic,strong)NSString *voteStatus; //投票状态
@property (nonatomic,strong)NSString *sts;   //未知
@property (nonatomic,strong)NSString *stsjb;
@property (nonatomic,strong)NSString *title; //标题
@property (nonatomic,strong)NSString *cyfs;  // 进入中企品牌官方网站或客户端进行投票
@property (nonatomic,strong)NSString *hdtime; //活动时间
@property (nonatomic,strong)NSString *catname;  //类名
@property (nonatomic,strong)NSString *sid;
@property (nonatomic,strong)NSString *catid;
@property (nonatomic,strong)NSArray <VoteModel *>*data; //数据源

@end
