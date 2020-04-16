//
//  UIImage+GIFImage.h
//  VoteCloud
//
//  Created by ios2 on 2019/7/31.
//  Copyright © 2019 CY. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^GIFimageBlock)(UIImage *GIFImage);

@interface UIImage (GIFImage)
/** 根据本地GIF图片名 获得GIF image对象 */

+ (UIImage *)imageWithGIFNamed:(NSString *)name;

+ (UIImage *)GIFName:(NSString *)name scale:(NSUInteger)scale;

/** 根据一个GIF图片的data数据 获得GIF image对象 */

+ (UIImage *)imageWithGIFData:(NSData *)data;

/** 根据一个GIF图片的URL 获得GIF image对象 */

+ (void)imageWithGIFUrl:(NSString *)url and:(GIFimageBlock)gifImageBlock;


@end

