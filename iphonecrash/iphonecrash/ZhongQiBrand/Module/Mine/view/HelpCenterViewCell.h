//
//  HelpCenterViewCell.h
//  ZhongQiBrand
//
//  Created by iOS on 2019/10/14.
//  Copyright © 2019 CY. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HelpListModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface HelpCenterViewCell : UITableViewCell

@property (nonatomic, strong) HelpListModel *model;

+ (instancetype)cellWithTableView:(UITableView *)tableView;

@end

NS_ASSUME_NONNULL_END
