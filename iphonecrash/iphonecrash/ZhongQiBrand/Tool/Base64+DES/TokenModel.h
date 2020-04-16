//
//  TokenModel.h
//  VoteCloud
//
//  Created by ios2 on 2019/8/14.
//  Copyright © 2019 CY. All rights reserved.
//


/**
 
 使用方法 -
 TokenModel *tokenModel = [TokenModel new];
 token.str = @"";
 token.t = @"";
 token.utoken = @""; // 登录后返回 没有 为空字符
 NSDictionaty *dic = tokenModel.dictionary;
 //将这个参数 正常状态 发送给后台
 
 */


#import <Foundation/Foundation.h>

@interface TokenModel : NSObject
@property (nonatomic,strong)NSString *method;             //动态参数 具体看接口文档
@property (nonatomic,strong)NSString *time;               //时间戳 内部获取
@property (nonatomic,strong)NSString *auth;               //登录后获取
@property (nonatomic,strong)NSString *token;              //每部生成

@property (nonatomic,readonly)NSDictionary *dictionary;   //只读参数
@end


