//
//  WKHybirdModel.h
//  PPWBrand
//
//  Created by ios2 on 2019/4/16.
//  Copyright © 2019 ShanZhou. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <WebKit/WKWebView.h>
#import <WebKit/WebKit.h>
@protocol WKHybirdDelegate <NSObject>

- (void)userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(WKScriptMessage *)message;
@end

//解决WKWebView 强引用不释放问题
@interface WKHybirdModel : NSObject<WKScriptMessageHandler>
//代理
@property(nonatomic,weak)id <WKHybirdDelegate> delegate;

@end

