//
//  UIButton+LSSmsVerification.m
//  短信验证码
//
//  Created by yepiaoyang on 16/6/30.
//  Copyright © 2016年 yepiaoyang. All rights reserved.
//

#import "UIButton+LSSmsVerification.h"
#define RGBA(r, g, b, a) [UIColor colorWithRed:r/255.0f green:g/255.0f blue:b/255.0f alpha:a]

@implementation UIButton (LSSmsVerification)

/**
 *  获取短信验证码倒计时
 *
 *  @param duration 倒计时时间
 */

- (void)startTimeWithDuration:(NSInteger)duration
{
    __block NSInteger timeout = duration;
    UIColor *bacgroundColor = self.backgroundColor;
    
	NSString *originalTitle = [self titleForState:UIControlStateNormal];
    UIColor *originalTitleColor = [self titleColorForState:UIControlStateNormal];
    UIFont *originalFont = self.titleLabel.font;
    
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_source_t timer_t = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
    dispatch_source_set_timer(timer_t,dispatch_walltime(NULL, 0),1.0*NSEC_PER_SEC, 0); //每秒执行
    dispatch_source_set_event_handler(timer_t, ^{
        if(timeout <= 0){ //倒计时结束，关闭
            dispatch_source_cancel(timer_t);
            dispatch_async(dispatch_get_main_queue(), ^{
               self.backgroundColor =bacgroundColor;
                //设置按钮为最初的状态
//                [self timeEnd];
                [self setTitle:originalTitle forState:UIControlStateNormal];
                [self setTitleColor:originalTitleColor forState:UIControlStateNormal];
                self.titleLabel.font = originalFont;
                self.userInteractionEnabled = YES;
            });
        }else{
            NSInteger seconds = timeout % duration;
            if(seconds == 0){
                seconds = duration;
            }
            NSString *strTime = [NSString stringWithFormat:@"%.2ld", (long)seconds];
            dispatch_async(dispatch_get_main_queue(), ^{
				//根据自己需求设置倒计时显示
                [self setTitle:[NSString stringWithFormat:@"%@s",strTime] forState:UIControlStateNormal];
                [self setTitleColor: [UIColor whiteColor] forState:UIControlStateNormal];
                self.backgroundColor = [UIColor lightGrayColor];
                self.layer.borderColor = [UIColor lightGrayColor].CGColor;
                self.titleLabel.font = originalFont;
                self.userInteractionEnabled = NO;
            });
            timeout--;
        }
    });
    dispatch_resume(timer_t);
}

@end
