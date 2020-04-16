//
//  PPVersonAleteView.h
//  PPWBrand
//
//  Created by ios2 on 2019/5/6.
//  Copyright © 2019 ShanZhou. All rights reserved.
//

#import <UIKit/UIKit.h>

@class PPVersonAleteView;

@protocol AlertDelegate <NSObject>
@optional
/**
 *  点击按钮协议
 *
 *  @param alertView
 *  @param buttonIndex 0,1,2...
 */
- (void)alertView:(PPVersonAleteView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex;

/**
 *  取消协议
 *
 *  @param alertView
 */
- (void)alertViewCancel:(PPVersonAleteView *)alertView;

@end

@interface PPVersonAleteView : UIView
/**
 *  创建alertView
 *
 *  @param title             提示标题
 *  @param message           提示详情
 *  @param delegate          协议对象
 *  @param cancelButtonTitle 取消按钮名称
 *  @param otherButtonTitles 其他按钮
 *
 *  @return PPVersonAleteView
 */
- (instancetype)initWithTitle:(NSString *)title
					  message:(NSString *)message
					 delegate:(id /*<AlertDelegate>*/)delegate
			cancelButtonTitle:(NSString *)cancelButtonTitle
			otherButtonTitles:(NSString *)otherButtonTitles, ...NS_REQUIRES_NIL_TERMINATION;
//是否可以取消
@property(nonatomic,assign)BOOL canDismiss;

@end
