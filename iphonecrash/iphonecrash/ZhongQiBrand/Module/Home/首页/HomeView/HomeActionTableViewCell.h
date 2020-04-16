//
//  HomeActionTableViewCell.h
//  ZhongQiBrand
//
//  Created by ios2 on 2019/9/17.
//  Copyright © 2019 CY. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface HomeActionTableViewCell : UITableViewCell

//点击的第几个
@property (nonatomic,copy)void(^homeActionClicked)(NSInteger index);
+(CGFloat)cellHeight;

@end

NS_ASSUME_NONNULL_END
