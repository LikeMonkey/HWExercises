//
//  SearchViewController.h
//  VoteCloud
//
//  Created by ios2 on 2019/8/5.
//  Copyright © 2019 CY. All rights reserved.
//

#import "BaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface SearchViewController : BaseViewController
@property (nonatomic,strong)NSString *placeHoder;
@property (nonatomic,strong)UISearchBar *searchBar;
//开始搜索
-(void)searchWithText:(UISearchBar *)searchBar;
 //搜索词已经清空
-(void)didClearSearchText;

@end

NS_ASSUME_NONNULL_END
