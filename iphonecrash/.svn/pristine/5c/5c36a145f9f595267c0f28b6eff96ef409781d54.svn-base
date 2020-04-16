//
//  CommonTools.h
//  AppVersionUpdate
//
//  Created by andson-zhw on 16/7/29.
//  Copyright © 2016年 andson. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CommonTools : NSObject
///初始化一个工具类型的单例
+ (id)shareInstance;

#pragma mark - 版本更新信息
/**
 *  获取是否有最新版本
 */
//是否有新版本、新版本更新下地址

- (void)versionForAppid:(NSString *)appid
			  andIsMast:(BOOL)isMast
			   andBlock:(void(^)(BOOL isHaveVersion,NSString *updateUrl,NSString *updateContent))version;
@end
