//
//  GiftPayTypeCell.h
//  ZhongQiBrand
//
//  Created by ios 001 on 2019/10/21.
//  Copyright © 2019 CY. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface GiftPayTypeCell : UITableViewCell
/** 支付图片 */
@property (nonatomic,strong) UIImageView *payType;
/** 支付名称 */
@property (nonatomic,strong) UILabel *payName;
/** 快速创建Cell */
+ (instancetype)cellWithTableView:(UITableView *)tableView withIdentifier:(NSString *)cellIdentifier indexPath:(NSIndexPath *)indexPath;

@end

NS_ASSUME_NONNULL_END
