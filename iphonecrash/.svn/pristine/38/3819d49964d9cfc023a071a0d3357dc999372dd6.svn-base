//
//  UIColor+Gradient.m
//  VoteCloud
//
//  Created by 孙程 on 2019/8/13.
//  Copyright © 2019 CY. All rights reserved.
//

#import "UIColor+Gradient.h"

@implementation UIColor (Gradient)

+ (instancetype)colorGradientChangeWithSize:(CGSize)size startPoint:(CGPoint)startPoint direction:(GradientChangeDirection)direction startColor:(UIColor*)startcolor endColor:(UIColor*)endColor{
    if(CGSizeEqualToSize(size,CGSizeZero) || !startcolor || !endColor) {
        return nil;
    }
    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
    gradientLayer.frame = CGRectMake(0,0, size.width, size.height);
    
//    startPoint = CGPointZero;
//    if (direction == GradientChangeDirectionDownDiagonalLine) {
//        startPoint = CGPointMake(0.0,1.0);
//    }
    gradientLayer.startPoint = startPoint;
    CGPoint endPoint = CGPointZero;
    switch(direction) {
            
        case GradientChangeDirectionLevel:
            endPoint = CGPointMake(1.0,0.0);
            break;
        case GradientChangeDirectionVertical:
            endPoint =CGPointMake(0.0,1.0);
            break;
        case GradientChangeDirectionUpwardDiagonalLine:
            endPoint =CGPointMake(1.0,1.0);
            break;
        case GradientChangeDirectionDownDiagonalLine:
            endPoint =CGPointMake(1.0,0.0);
            break;
        default:
            break;
    }
    gradientLayer.endPoint = endPoint;
    gradientLayer.colors = @[(__bridge id)startcolor.CGColor, (__bridge id)endColor.CGColor];
    UIGraphicsBeginImageContext(size);
    [gradientLayer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return [UIColor colorWithPatternImage:image];
}

@end
