//
//  HomeTimeManager.h
//  ZhongQiBrand
//
//  Created by ios2 on 2019/11/4.
//  Copyright © 2019 CY. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^TimeRunBlock)(void);

@interface HomeTimeManager : NSObject

@property(nonatomic,assign)NSInteger lastVoteTimeLine;

+(instancetype)manager;

+(void)startTime;
+(void)stopTime;
//添加关联的代码块
+(void)addBlock:(TimeRunBlock)block andTarget:(NSObject *)target;
//移除关联的代码块
+(void)deleteBlock:(NSObject *)target;


@end

