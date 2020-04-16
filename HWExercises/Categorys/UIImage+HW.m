//
//  UIImage+HW.m
//  HWExercises
//
//  Created by sxmaps_w on 2017/5/22.
//  Copyright © 2017年 wqb. All rights reserved.
//

#import "UIImage+HW.h"

@implementation UIImage (HW)

//根据颜色返回图片
+ (UIImage *)imageWithColor:(UIColor *)color
{
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return theImage;
}

//获取网络图片
+ (UIImage *)imageWithUrlString:(NSString *)urlString
{
    NSURL *url = [NSURL URLWithString:urlString];
    
    NSData *date = [NSData dataWithContentsOfURL:url];
    
    UIImage *image = [UIImage imageWithData:date];
    
    return image;
}

@end
