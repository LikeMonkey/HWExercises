//
//  HomeResponse.h
//  ZhongQiBrand
//
//  Created by ios2 on 2019/11/4.
//  Copyright © 2019 CY. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseModel.h"

@interface HomebrandModel :NSObject
@property (nonatomic,strong)NSString *adddate;
@property (nonatomic,strong)NSString *brandintro;
@property (nonatomic,strong)NSString *catid;
@property (nonatomic,strong)NSString *company;
@property (nonatomic,strong)NSString *introduce;
@property (nonatomic,strong)NSString *itemid;
@property (nonatomic,strong)NSString *thumb;
@property (nonatomic,strong)NSString *title;
@end

@interface HomeNewsModel : NSObject
@property (nonatomic,strong)NSString *addtime;
@property (nonatomic,strong)NSString *itemid;
@property (nonatomic,strong)NSString *thumb;
@property (nonatomic,strong)NSString *title;
@property (nonatomic,strong)NSString *username;
@end

@interface HomeVoteModel : NSObject
@property (nonatomic,strong)NSString *addtime;
@property (nonatomic,strong)NSString *catid;
@property (nonatomic,strong)NSString *show;
@property (nonatomic,strong)NSString *sid;
@property (nonatomic,strong)NSString *title;


@property (nonatomic,strong)NSString *status;
@property (nonatomic,strong)NSString *fromdate;
@property (nonatomic,strong)NSString *todate;
@property (nonatomic,strong)NSString *bdaddtime;
@property (nonatomic,strong)NSString *Tips;
@end


@interface HomeResponse : BaseModel

@property (nonatomic,strong)NSArray<NSString *> *banner;
@property (nonatomic,strong)NSArray <HomebrandModel *>*brands; //品牌视界
@property (nonatomic,strong)NSArray <HomeVoteModel *>*hotList; //热门榜单
@property (nonatomic,strong)NSArray <HomeNewsModel *>*newslist; //品牌头条
@property (nonatomic,strong)NSArray *fastVotes; //品牌世界

@end

