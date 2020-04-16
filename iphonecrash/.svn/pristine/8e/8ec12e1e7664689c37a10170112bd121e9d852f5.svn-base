//
//  UIColor+Gradient.h
//  VoteCloud
//
//  Created by 孙程 on 2019/8/13.
//  Copyright © 2019 CY. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, GradientChangeDirection) {
    GradientChangeDirectionLevel,               //水平方向渐变
    GradientChangeDirectionVertical,            //垂直方向渐变
    GradientChangeDirectionUpwardDiagonalLine,  //主对角线方向渐变
    GradientChangeDirectionDownDiagonalLine     //副对角线方向渐变
};

NS_ASSUME_NONNULL_BEGIN

@interface UIColor (Gradient)

/*!
 * 渐变色
 *
 * @param size 渐变区域的尺寸
 * @param startPoint 起始点
 * @param direction 渐变方向
 * @param startcolor 开始颜色
 * @param endColor 结束颜色
 * @return 渐变色
 *
 */
+ (instancetype)colorGradientChangeWithSize:(CGSize)size startPoint:(CGPoint)startPoint direction:(GradientChangeDirection)direction startColor:(UIColor*)startcolor endColor:(UIColor*)endColor;

@end

NS_ASSUME_NONNULL_END
