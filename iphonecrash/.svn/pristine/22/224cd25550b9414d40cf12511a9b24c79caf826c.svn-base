//
//  UIFont+LgScale.m
//  VoteCloud
//
//  Created by ios2 on 2019/7/30.
//  Copyright © 2019 CY. All rights reserved.
//

#import "UIFont+LgScale.h"
#import <objc/runtime.h>

@implementation UIFont (LgScale)
+(void)load
{
	static dispatch_once_t onceToken;
	dispatch_once(&onceToken, ^{
		SEL aSel = @selector(systemFontOfSize:);
		SEL newSel = @selector(changeSystemSize:);

		SEL customFontSel = @selector(changeFontName:andSize:);

		Class metaClass = object_getClass(self);
		//粗体
		SEL bSel = @selector(boldSystemFontOfSize:);
		SEL bnewSel = @selector(boldChangeSystemSize:);
		SEL nameSel = @selector(fontWithName:size:);


		Method lastMethod=class_getInstanceMethod (metaClass, aSel);
		Method blastMethod=class_getInstanceMethod (metaClass, bSel);
		//Method  是返回的方法的地址
		Method newMethod= class_getInstanceMethod (metaClass,newSel);
		Method bnewMethod= class_getInstanceMethod (metaClass,bnewSel);
		//名称
		Method nameNewMethod= class_getInstanceMethod (metaClass,customFontSel);
		Method nameLastMethod=class_getInstanceMethod (metaClass, nameSel);

		method_exchangeImplementations(nameLastMethod, nameNewMethod);
		method_exchangeImplementations(lastMethod, newMethod);
		method_exchangeImplementations(blastMethod, bnewMethod);
	});
}
+(UIFont *)changeFontName:(NSString *)name andSize:(CGFloat)size
{
	CGFloat fontScale = MIN(CGRectGetWidth([UIScreen mainScreen].bounds), CGRectGetHeight([UIScreen mainScreen].bounds))/375.0;
	CGFloat aSize = size * fontScale;
	return [self changeFontName:name andSize:aSize];
}
//统一适配字体比例  支持系统以及 第三方内部文字适配
+(UIFont *)changeSystemSize:(CGFloat)size
{
	CGFloat fontScale = MIN(CGRectGetWidth([UIScreen mainScreen].bounds), CGRectGetHeight([UIScreen mainScreen].bounds))/375.0;
	CGFloat aSize = size * fontScale;
	return  [self changeSystemSize:aSize];
}

+(UIFont *)boldChangeSystemSize:(CGFloat)size
{
	CGFloat fontScale = MIN(CGRectGetWidth([UIScreen mainScreen].bounds), CGRectGetHeight([UIScreen mainScreen].bounds))/375.0;
	CGFloat aSize = size * fontScale;
	return  [self boldChangeSystemSize:aSize];
}

@end
