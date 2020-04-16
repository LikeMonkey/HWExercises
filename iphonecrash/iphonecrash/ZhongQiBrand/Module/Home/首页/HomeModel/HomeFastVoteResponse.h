//
//  HomeFastVoteResponse.h
//  ZhongQiBrand
//
//  Created by ios2 on 2019/11/5.
//  Copyright © 2019 CY. All rights reserved.
//

#import "BaseModel.h"
#import "HomeResponse.h"

@interface HomeFastVoteResponse : BaseModel

@property (nonatomic,strong)NSArray <HomeVoteModel *>*data;


@end

