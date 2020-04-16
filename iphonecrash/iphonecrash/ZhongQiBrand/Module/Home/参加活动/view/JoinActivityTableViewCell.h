//
//  JoinActivityTableViewCell.h
//  ZhongQiBrand
//
//  Created by iOS002 on 2019/10/21.
//  Copyright © 2019 CY. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JoinActivityShowModel.h"
#import "JKCountDownButton.h"
NS_ASSUME_NONNULL_BEGIN

@interface JoinActivityTableViewCell : UITableViewCell
@property (nonatomic, strong) JoinActivityShowModel *showModel;
@property (nonatomic, copy) void (^clickGetSMSCodeBlock)(JKCountDownButton *countButton);
@property (nonatomic, copy) void (^clickRefreshImageCodeBlock)(void);
@end

NS_ASSUME_NONNULL_END
