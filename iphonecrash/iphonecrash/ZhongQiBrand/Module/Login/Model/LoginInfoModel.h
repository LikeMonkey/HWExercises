//
//  LoginInfoModel.h
//  ZhongQiBrand
//
//  Created by ios2 on 2019/11/5.
//  Copyright © 2019 CY. All rights reserved.
//

#import "BaseModel.h"

@interface LoginInfoModel : BaseModel
@property (nonatomic,strong)NSString *auth;
@property (nonatomic,strong)NSString *openid;
@property (nonatomic,strong)NSString *ouid;
@end

