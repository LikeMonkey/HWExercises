//
//  HeadLinesSubViewController.h
//  ZhongQiBrand
//
//  Created by ios2 on 2019/9/21.
//  Copyright © 2019 CY. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JXCategoryListContainerView.h"
@interface HeadLinesSubViewController : UIViewController<JXCategoryListContentViewDelegate>
@property (nonatomic,strong)NSString *fenlei;//分类id
@end
