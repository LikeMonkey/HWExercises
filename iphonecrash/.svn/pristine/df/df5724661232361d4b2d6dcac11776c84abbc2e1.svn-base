//
//  PPWNavigationController.m
//  PPWBrand
//
//  Created by ios2 on 2019/4/12.
//  Copyright © 2019 ShanZhou. All rights reserved.
//

#import "VoteNavigationController.h"

@interface VoteNavigationController ()<UINavigationControllerDelegate,UIGestureRecognizerDelegate>

@end

@implementation VoteNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
	Class barClass = NSClassFromString(@"NavBar");
	if (barClass) {
		UINavigationBar *bar = (UINavigationBar *)[[barClass alloc]init];
		[self setValue:bar forKey:@"navigationBar"];
	}
	__weak typeof(self)ws = self;
	if ([self respondsToSelector:@selector(interactivePopGestureRecognizer)])
	 {
		self.interactivePopGestureRecognizer.delegate = ws;
		self.delegate = ws;
	 }
	[[UINavigationBar appearance] setTitleTextAttributes: [NSDictionary dictionaryWithObjectsAndKeys: [UIColor blackColor], NSForegroundColorAttributeName, [UIFont boldSystemFontOfSize:18], NSFontAttributeName, nil]];
}
-(void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
	if ([self.parentViewController isKindOfClass:[UITabBarController class]]) {
		if (self.viewControllers.count==1) {
			viewController.hidesBottomBarWhenPushed = YES;
		}
	}
	[super pushViewController:viewController animated:animated];
}
#pragma mark UINavigationControllerDelegate
- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer {
	if ([self.childViewControllers count] == 1) {
		return NO;
	}
	return YES;
}
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer
{
	return YES;
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldBeRequiredToFailByGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer
{
	return [gestureRecognizer isKindOfClass:UIScreenEdgePanGestureRecognizer.class];
}


@end
