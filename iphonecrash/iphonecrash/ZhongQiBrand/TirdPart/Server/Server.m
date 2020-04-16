//
//  Server.m
//  WineComment
//
//  Created by 何伟东 on 13-6-24.
//  Copyright (c) 2013年 何伟东. All rights reserved.
//

#import "Server.h"

#import "Reachability.h"
@implementation Server
//判断是否有网
+(BOOL)netWorkAvailable{
    if(![[Reachability reachabilityForInternetConnection] isReachableViaWWAN] && ![[Reachability reachabilityForInternetConnection] isReachableViaWiFi])
    {
        return NO;
    }
#if DEBUG
	return YES;
#else
	if ([[Reachability reachabilityForInternetConnection] isReachableViaWiFi]) {
		if ([self fetchHttpProxy]) {
			return NO;
		}
	}
	return YES;
#endif
}
//wifi 是否设置了代理
+(BOOL)fetchHttpProxy {
	CFDictionaryRef dicRef = CFNetworkCopySystemProxySettings();
	const CFStringRef proxyCFstr = (const CFStringRef)CFDictionaryGetValue(dicRef,
																		   (const void*)kCFNetworkProxiesHTTPProxy);
	NSString* proxy = (__bridge NSString *)proxyCFstr;
	if (proxy) {
		NSLog(@"抓包ip地址:%@",proxy);
		SHOW_MSG(@"网络错误，请检查HTTP代理配置", 0.5);
		return YES;
	}
	return  NO;
}


@end
