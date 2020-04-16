//
//  WKHybirdModel.m
//  PPWBrand
//
//  Created by ios2 on 2019/4/16.
//  Copyright © 2019 ShanZhou. All rights reserved.
//

#import "WKHybirdModel.h"

@implementation WKHybirdModel
- (void)userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(WKScriptMessage *)message
{
	if ([self.delegate respondsToSelector:@selector(userContentController:didReceiveScriptMessage:)]) {
		[self.delegate userContentController:userContentController didReceiveScriptMessage:message];
	}
}
@end
