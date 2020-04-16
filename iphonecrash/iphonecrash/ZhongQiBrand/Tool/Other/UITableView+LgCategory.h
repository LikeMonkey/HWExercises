//
//  UITableView+LgCategory.h
//  PPWBrand
//
//  Created by ios2 on 2019/6/14.
//  Copyright © 2019 ShanZhou. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITableView (LgCategory)
@property (nonatomic,assign)NSInteger lg_page;
//数据
@property (nonatomic,strong)NSMutableArray *lg_data;
@end


