//
//  WDAlert.m
//  WineComment
//
//  Created by 何伟东 on 13-7-5.
//  Copyright (c) 2013年 何伟东. All rights reserved.
//

#import "WDAlert.h"
#import "UIImage+GIFImage.h"
@implementation WDAlert
+ (void)alertWithMessage:(NSString *)message title:(NSString*)title{
	// open an alert with an OK button
	UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title
													message:message
												   delegate:nil
										  cancelButtonTitle:@"确定"
										  otherButtonTitles: nil];
	[alert show];
}

+ (void)alertWithMessage:(NSString *)message{
    [WDAlert alertWithMessage:message title:@"提示"];
    
}
+(void)showLodingWithTitle:(NSString*)title message:(NSString*)message
{
    NSMutableDictionary *dictionary = [[NSMutableDictionary alloc] init];
    if (title) {
        [dictionary setObject:title forKey:@"title"];
    }
    if (message) {
        [dictionary setObject:message forKey:@"message"];
    }
    [NSThread detachNewThreadSelector:@selector(threedLKLoading:) toTarget:self withObject:dictionary];
}
+(void)timerFireMethod:(NSTimer*)theTimer//弹出框
{
    UIAlertView *promptAlert = (UIAlertView*)[theTimer userInfo];
    [promptAlert dismissWithClickedButtonIndex:0 animated:NO];
    promptAlert =NULL;
}
+(void)showAlertWithMessage:(NSString*)message time:(NSTimeInterval)time{
	UILabel *messageLable = nil;
    for (UIView *view in [[UIApplication sharedApplication].delegate window].subviews) {
        if (view.tag == 10000) {
			[view removeFromSuperview];
        }
    }
	if (!messageLable) {
		messageLable = [[UILabel alloc] initWithFrame:CGRectMake(0, 120, MAINScreenWidth, 45)];
	}
    messageLable.numberOfLines = 0;
	CGSize size =  [message boundingRectWithSize:CGSizeMake(MAINScreenWidth-60, MAINScreenHeight) options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading|NSStringDrawingUsesDeviceMetrics attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15]} context:nil].size;
    if (size.height<40) {
        size.height = 40;
    }

    messageLable.frame = CGRectMake(([UIScreen mainScreen].bounds.size.width - size.width -  40) /2, ([UIScreen mainScreen].bounds.size.height - size.height) / 2, size.width + 40, size.height);
    if (MAINScreenHeight == 480) {
		CGRect f = messageLable.frame;
		f.origin.y = 180;
        messageLable.frame = f;
    }
    [messageLable setTag:10000];
    messageLable.backgroundColor = [UIColor colorWithWhite:0 alpha:0.6];
    [messageLable setTextAlignment:NSTextAlignmentCenter];
    [messageLable setTextColor:[UIColor whiteColor]];
    [messageLable setText:message];
    messageLable.layer.cornerRadius = 7;
    messageLable.clipsToBounds = YES;
    [messageLable setAdjustsFontSizeToFitWidth:YES];
	if ([NSThread isMainThread]) {
		[[[UIApplication sharedApplication].delegate window] addSubview:messageLable];
		[[[UIApplication sharedApplication].delegate window] bringSubviewToFront:messageLable];
	}else{
		dispatch_async(dispatch_get_main_queue(), ^{
			[[[UIApplication sharedApplication].delegate window] addSubview:messageLable];
			[[[UIApplication sharedApplication].delegate window] bringSubviewToFront:messageLable];
		});
	}
    if (time < 0.5) {
        time = 0.5;
    }
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)( time * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
         [UIView animateWithDuration:0.5 animations:^{
             messageLable.transform = CGAffineTransformMakeScale(0.5, 0.5);
             messageLable.alpha = 0;
         } completion:^(BOOL finished) {
             [messageLable removeFromSuperview];
         }];
    });

    
//    [UIView animateWithDuration:0.2 animations:^{
//        [alertView setFrame:CGRectMake(0,40, MAINScreenWidth, 45)];
//    } completion:^(BOOL finish) {
//        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1* NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//            [UIView animateWithDuration:0.2 animations:^{
//                [alertView setFrame:CGRectMake(0, -20, MAINScreenWidth, 45)];
//            } completion:^(BOOL finish) {
//                [alertView removeFromSuperview];
//                [alertView release];
//            }];
//        });
//
//    }];

    
}
+(void) hideTabBar:(UITabBarController *) tabbarcontroller {
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.5];
    for(UIView *view in tabbarcontroller.view.subviews)
    {
        if([view isKindOfClass:[UITabBar class]])
        {
            [view setFrame:CGRectMake(view.frame.origin.x, MAINScreenHeight, view.frame.size.width, view.frame.size.height)];
        }
        else
        {
            [view setFrame:CGRectMake(view.frame.origin.x, view.frame.origin.y, view.frame.size.width, MAINScreenHeight)];
        }
    }
    [UIView commitAnimations];
}

+(void) showTabBar:(UITabBarController *) tabbarcontroller {
    
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.5];
    for(UIView *view in tabbarcontroller.view.subviews)
    {
        if([view isKindOfClass:[UITabBar class]])  {
            [view setFrame:CGRectMake(view.frame.origin.x, MAINScreenHeight-TabBarHeight, view.frame.size.width, view.frame.size.height)];
        }
        else {
            [view setFrame:CGRectMake(view.frame.origin.x, view.frame.origin.y, view.frame.size.width,  MAINScreenHeight-49)];
        }
    }
    [UIView commitAnimations];
}

#pragma mark Singleton
+ (WDAlert *)shareAlert
{
    static WDAlert *defaultAlert = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        defaultAlert = [[WDAlert alloc] init];
    });
    return defaultAlert;
}
#pragma mark MBProgressHUD
- (void)showLodingWithTitle:(NSString*)title delay:(NSTimeInterval)time
{
	if (HUD) {
		[HUD hide:YES];
	}
    UIWindow *window = [[[UIApplication sharedApplication] delegate] window];
    HUD = [[MBProgressHUD alloc] initWithView:window];
    [window addSubview:HUD];
    HUD.delegate = self;
    HUD.labelText = title;
	HUD.square = YES;
	[HUD show:YES];
    [HUD hide:YES afterDelay:time];
}
- (void)showLodingWithTitle:(NSString*)title
{
    [[WDAlert shareAlert] showLodingWithTitle:title message:nil withView:nil];
}
- (void)showLodingWithTitle:(NSString*)title message:(NSString*)message
{
    [[WDAlert shareAlert] showLodingWithTitle:title message:message withView:nil];
}
- (void)showLodingWithTitle:(NSString*)title withView:(UIView *)view{
    [[WDAlert shareAlert] showLodingWithTitle:title message:nil withView:view];
}
- (void)showLodingWithTitle:(NSString*)title message:(NSString*)message withView:(UIView *)view{
    UIView *bgView = [[UIView alloc] initWithFrame:view.bounds];
    bgView.backgroundColor = [[UIColor colorWithHexString:@"#f1f1f1"]colorWithAlphaComponent:0];
    [view addSubview:bgView];
	UIImage  *image=[UIImage GIFName:@"loading" scale:0.5];
    UIImageView *_activeView=[[UIImageView alloc]init];
    _activeView.image=image;
	_activeView.bounds = CGRectMake(0, 0, px_scale(65.0f), px_scale(65.0f));
    _activeView.frame = CGRectMake((view.width - px_scale(80.0f)) /2, (view.height - px_scale(80.0f)) / 2 - 40, px_scale(65.0f), px_scale(65.0f));
    [_activeView startAnimating];
    [bgView addSubview:_activeView];
    if (!view) {
		if (HUD) {
			[HUD hide:YES];
		}
        UIWindow *window = [[[UIApplication sharedApplication] delegate] window];
        HUD = [[MBProgressHUD alloc] initWithWindow:window];
        HUD.customView = bgView;
		HUD.removeFromSuperViewOnHide = YES;
		HUD.userInteractionEnabled = YES;
        HUD.mode = MBProgressHUDModeCustomView;
        [window addSubview:HUD];
    }else{
        if (HUD) {
            [HUD hide:YES];
        }
        HUD = [[MBProgressHUD alloc] initWithView:view];
        HUD.customView = bgView;
        HUD.mode = MBProgressHUDModeCustomView;
        [view addSubview:HUD];
    }
    HUD.delegate = self;
    HUD.labelText = @"";
    HUD.detailsLabelText = message;
	HUD.square = YES;
	[HUD show:YES];
}

-(void)showProgressInWindow
{
	if (HUD) {
		[HUD hide:NO];
	}
	UIWindow *window = [[[UIApplication sharedApplication] delegate] window];
	HUD = [[MBProgressHUD alloc] initWithWindow:window];
	HUD.removeFromSuperViewOnHide = YES;
	HUD.userInteractionEnabled = YES;
	HUD.mode = MBProgressHUDModeDeterminate;
	HUD.delegate = self;
	HUD.square = NO;
	HUD.dimBackground = NO;
	HUD.opacity = 1.0;
	HUD.progress = 0;
	UIView *progressView =  [HUD valueForKeyPath:@"indicator"];
	progressView.backgroundColor = [[UIColor blackColor]colorWithAlphaComponent:0.5];
	[HUD show:YES];
	[window addSubview:HUD];
}

-(void)updateProgress:(CGFloat)progress
{
	if (HUD) {
		HUD.progress = progress;
	}
}
- (void)hiddenHUD
{
    if (HUD) {
        [HUD hide:YES];
    }
	if (HUD.mode == MBProgressHUDModeDeterminate) {
		[HUD removeFromSuperview];
		HUD = nil;
	}
}
#pragma mark MBProgressHUDDelegate methods
- (void)hudWasHidden:(MBProgressHUD *)hud {
    // Remove HUD from screen when the HUD was hidded
    [HUD removeFromSuperview];
	HUD = nil;
}
@end
