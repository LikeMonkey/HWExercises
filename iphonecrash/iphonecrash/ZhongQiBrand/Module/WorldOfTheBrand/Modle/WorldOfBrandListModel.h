//
//  WorldOfBrandListModel.h
//  ZhongQiBrand
//
//  Created by ios 001 on 2019/11/4.
//  Copyright © 2019 CY. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface worldBrandListModel : NSObject
/** <#copy属性注释#> */
@property (nonatomic,copy) NSString *itemid;
/** <#copy属性注释#> */
@property (nonatomic,copy) NSString *catid;
/** <#copy属性注释#> */
@property (nonatomic,copy) NSString *title;
/** 图片名称 */
@property (nonatomic,copy) NSString *thumb;
/** <#copy属性注释#> */
@property (nonatomic,copy) NSString *company;
/** <#copy属性注释#> */
@property (nonatomic,copy) NSString *addtime;
/** <#copy属性注释#> */
@property (nonatomic,copy) NSString *brandintro;
/** <#copy属性注释#> */
@property (nonatomic,copy) NSString *introduce;
@end


@interface WorldOfBrandListModel : BaseModel
/** list 数组 */
@property (nonatomic,strong) NSArray<worldBrandListModel *>*data;

@end
NS_ASSUME_NONNULL_END
