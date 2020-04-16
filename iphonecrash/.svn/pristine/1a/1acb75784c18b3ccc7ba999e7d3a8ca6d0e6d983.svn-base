//
//  HomeTableHeaderView.h
//  ZhongQiBrand
//
//  Created by ios2 on 2019/9/17.
//  Copyright © 2019 CY. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HomeTableHeaderView : UITableViewHeaderFooterView
//左边大标题
@property (nonatomic,strong)UILabel *titleLable;
//英文标题
@property (nonatomic,strong)UILabel *engLishTitle;
//线宽
@property (nonatomic,strong)UIView *lineView;
@property(nonatomic,assign)NSInteger index;
//点击了更多 的 索引值
@property (nonatomic,copy)void(^didClickedMoreBlock)(NSInteger index);



//设置中英文 以及 是否查看更多
-(void)configerTitle:(NSString *)title
		  andEnglish:(NSString *)english
	   andIsShowMore:(BOOL)isShowMore;

@end

