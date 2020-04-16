//
//  HomeTimeManager.h
//  ZhongQiBrand
//
//  Created by ios2 on 2019/11/4.
//  Copyright © 2019 CY. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol TimeRunProtocol <NSObject>
@optional
//时间调用协议
-(void)time_did_runprotocol;

@end

typedef void(^TimeRunBlock)(void);

@interface HomeTimeManager : NSObject

@property(nonatomic,assign)NSInteger lastVoteTimeLine;

+(instancetype)manager;

+(void)startTime;
+(void)stopTime;

//添加关联的代码块
+(void)addBlock:(TimeRunBlock)block andTarget:(NSObject *)target;

//使用协议操作 弱引用调用
+(void)addTimeRunObject:(id<TimeRunProtocol>)target;


//移除关联的代码块 需要协议
+(void)deleteBlock:(NSObject *)target;


@end

