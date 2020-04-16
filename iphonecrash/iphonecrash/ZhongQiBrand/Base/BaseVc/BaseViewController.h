//
//  BaseViewController.h
//  VoteCloud
//
//  Created by ios2 on 2019/7/31.
//  Copyright © 2019 CY. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseViewController : UIViewController
	//顶部导航view
@property (nonatomic,strong,nullable)UIView *navView;
	//导航底部的线
@property (nonatomic,strong,nullable)UIView *lineView;

-(void)initNavView;

@end

