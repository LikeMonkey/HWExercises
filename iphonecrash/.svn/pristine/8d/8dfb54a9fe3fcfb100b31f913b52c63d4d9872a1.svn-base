//
//  NSURL+Params.m
//  PPWBrand
//
//  Created by ios2 on 2019/6/10.
//  Copyright © 2019 ShanZhou. All rights reserved.
//

#import "NSURL+Params.h"
@implementation NSURL (Params)
-(NSDictionary *) parameter {
	NSMutableDictionary *parm = [[NSMutableDictionary alloc]init];
		//传入url创建url组件类
	NSURLComponents *urlComponents = [[NSURLComponents alloc] initWithString:self.absoluteString];
		//回调遍历所有参数，添加入字典
	[urlComponents.queryItems enumerateObjectsUsingBlock:^(NSURLQueryItem * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
		[parm setObject:obj.value forKey:obj.name];
	}];
	return parm;
}
@end
