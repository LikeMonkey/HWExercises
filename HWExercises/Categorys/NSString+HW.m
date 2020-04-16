//
//  NSString+HW.m
//  HWExercises
//
//  Created by sxmaps_w on 2017/5/22.
//  Copyright © 2017年 wqb. All rights reserved.
//

#import "NSString+HW.h"
#import <CommonCrypto/CommonDigest.h>

@implementation NSString (HW)

//MD5加密
- (NSString *)MD5
{
    const char *ptr = [self UTF8String];
    
    unsigned char md5Buffer[CC_MD5_DIGEST_LENGTH];
    
    CC_MD5(ptr, (unsigned int)strlen(ptr), md5Buffer);
    
    NSMutableString *output = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH *2];
    for (int i = 0; i<CC_MD5_DIGEST_LENGTH; i++) {
        [output appendFormat:@"%02x",md5Buffer[i]];
    }
    
    return output;
}

@end
