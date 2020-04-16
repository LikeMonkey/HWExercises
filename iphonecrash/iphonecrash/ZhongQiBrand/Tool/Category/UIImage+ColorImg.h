//
//  UIImage+ColorImg.h
//  FriendChat
//
//  Created by ios2 on 2018/1/10.
//  Copyright © 2018年 石家庄光耀. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (ColorImg)
//创建单色图片
+(UIImage *)creactImageWithColor:(UIColor *)color andSize:(CGSize)size;

- (UIImage *)imageWithColor:(UIColor *)color;

//图片
- (UIImage *)imageBluredWithRadius:(CGFloat)blurRadius
                         tintColor:(UIColor *)tintColor
             saturationDeltaFactor:(CGFloat)saturationDeltaFactor
                         maskImage:(UIImage *)maskImage;


@end
