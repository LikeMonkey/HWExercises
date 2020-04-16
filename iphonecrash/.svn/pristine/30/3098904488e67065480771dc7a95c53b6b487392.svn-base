//
//  MessageManager.h
//  VoteCloud
//
//  Created by ios2 on 2019/8/14.
//  Copyright © 2019 CY. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MessageManager : NSObject

+(instancetype)manager;

//消息数量
@property(nonatomic,assign)NSInteger messageCount;  //控制是否有参数

//更新消息数量
+(void)updateCount:(NSInteger)msgCount;

+(void)addKey:(NSObject *)key andBlock:(void(^)(void))block;

+(void)removeKey:(NSObject *)key;

@end

