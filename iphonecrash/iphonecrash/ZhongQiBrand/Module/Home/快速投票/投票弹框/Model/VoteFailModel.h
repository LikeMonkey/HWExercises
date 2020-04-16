//
//  VoteFailModel.h
//  ZhongQiBrand
//
//  Created by iOS on 2019/10/23.
//  Copyright © 2019 CY. All rights reserved.
//

#import "BaseModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface VoteFailModel : BaseModel
/** 品牌logo图片地址 */
@property (nonatomic, copy) NSString *iconUrl;
/** 品牌名称 */
@property (nonatomic, copy) NSString *brandName;
/** 失败原因*/
@property (nonatomic, copy) NSString *failError;
@end

NS_ASSUME_NONNULL_END
