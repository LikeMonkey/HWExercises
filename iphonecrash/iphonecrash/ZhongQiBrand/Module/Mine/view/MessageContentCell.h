//
//  MessageContentCell.h
//  ZhongQiBrand
//
//  Created by iOS on 2019/10/21.
//  Copyright © 2019 CY. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface MessageContentCell : UITableViewCell

@property (nonatomic, strong) UITextView *contentTextView;
@property (nonatomic, strong) UILabel *placeLable;
@property (nonatomic, copy) void (^clickRewriteBtnBlock)(void);

@end

NS_ASSUME_NONNULL_END
