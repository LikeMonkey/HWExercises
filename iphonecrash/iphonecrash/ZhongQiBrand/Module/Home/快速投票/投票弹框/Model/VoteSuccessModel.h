//
//  VoteSuccessModel.h
//  ZhongQiBrand
//
//  Created by iOS on 2019/10/23.
//  Copyright © 2019 CY. All rights reserved.
//

#import "BaseModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface VoteSuccessModel : BaseModel
/** 品牌logo图片地址 */
@property (nonatomic, copy) NSString *iconUrl;
/** 投票数 */
@property (nonatomic, copy) NSString *votesNum;
/** 品牌名称 */
@property (nonatomic, copy) NSString *brandName;
/** 投票日期 */
@property (nonatomic, copy) NSString *voteDtae;
/** 投票时间 */
@property (nonatomic, copy) NSString *voteTime;
@end

NS_ASSUME_NONNULL_END
