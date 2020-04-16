//
//  NSBundle+GuideSource.m
//  VoteCloud
//
//  Created by ios2 on 2019/8/24.
//  Copyright © 2019 CY. All rights reserved.
//

#import "NSBundle+GuideSource.h"

@implementation NSBundle (GuideSource)

+ (instancetype)guideSouceBundle
{
	static NSBundle *guideSouceBundle = nil;
	if (guideSouceBundle == nil) {
		 NSString *path =  [[NSBundle mainBundle]pathForResource:@"GuideSource" ofType:@"bundle"];
		 guideSouceBundle = [NSBundle bundleWithURL:[NSURL fileURLWithPath:path]];
	}
	return guideSouceBundle;
}
+(UIImage *)guideImage:(NSString *)name
{

	 NSString *path =  [[self guideSouceBundle]pathForResource:name ofType:@"png"];
	NSData *data = [NSData dataWithContentsOfURL:[NSURL fileURLWithPath:path]];
	UIImage *image  = [UIImage imageWithData:data];
	return image;
}
@end
