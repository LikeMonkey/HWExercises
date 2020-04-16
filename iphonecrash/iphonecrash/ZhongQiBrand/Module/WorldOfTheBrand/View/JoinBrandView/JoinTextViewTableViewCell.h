//
//  JoinTextViewTableViewCell.h
//  ZhongQiBrand
//
//  Created by ios2 on 2019/10/21.
//  Copyright © 2019 CY. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JoinTextViewTableViewCell : UITableViewCell<UITextViewDelegate>

@property (nonatomic,strong)UITextView *textView;
@property (nonatomic,strong)UILabel	 *titleLable;

//占位
@property (nonatomic,strong)UILabel *placeLable;

@property (nonatomic,strong)NSString *titleText;
//文字的内容
@property (nonatomic,strong)NSString *text;

@property (nonatomic,copy)void(^textViewDidChangeBlock)(UITextView *textView,id sender);



@end

