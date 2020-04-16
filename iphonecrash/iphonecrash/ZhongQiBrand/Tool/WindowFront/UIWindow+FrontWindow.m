//
//  UIWindow+FrontWindow.m
//  VoteCloud
//
//  Created by ios2 on 2019/8/17.
//  Copyright © 2019 CY. All rights reserved.
//

#import "UIWindow+FrontWindow.h"

@implementation UIWindow (FrontWindow)
//查找最高层Window
+ (UIWindow *)frontWindow {
	NSInteger maxSupportedWindowLevel =  UIWindowLevelAlert - 1;
	NSEnumerator *frontToBackWindows = [UIApplication.sharedApplication.windows reverseObjectEnumerator];
	for (UIWindow *window in frontToBackWindows) {
		BOOL windowOnMainScreen = window.screen == UIScreen.mainScreen;
		BOOL windowIsVisible = !window.hidden && window.alpha > 0;
		BOOL windowLevelSupported = (window.windowLevel >= UIWindowLevelNormal && window.windowLevel <= maxSupportedWindowLevel);
		BOOL windowKeyWindow = window.isKeyWindow;

		if(windowOnMainScreen && windowIsVisible && windowLevelSupported && windowKeyWindow) {
			return window;
		}
	}
	return nil;
}

@end
