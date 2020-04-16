//
//  JoinInputCache.h
//  ZhongQiBrand
//
//  Created by ios2 on 2019/10/22.
//  Copyright © 2019 CY. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JoinInputCache : NSObject

@property (nonatomic,copy)NSDictionary *brandMsgCache;
@property (nonatomic,copy)NSDictionary *imagesCache;

+(instancetype)share;


@end

