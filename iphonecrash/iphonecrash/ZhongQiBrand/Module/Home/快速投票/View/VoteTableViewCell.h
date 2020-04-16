//
//  VoteTableViewCell.h
//  ZhongQiBrand
//
//  Created by 孙程 on 2019/9/17.
//  Copyright © 2019 CY. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "VoteModel.h"

typedef void(^VoteTableViewCellButtonClickBlock)(id sender);
@interface VoteTableViewCell : UITableViewCell

@property (nonatomic, copy)   VoteTableViewCellButtonClickBlock buttonClickBlock;
@property (nonatomic, strong) VoteModel *model;

@end

