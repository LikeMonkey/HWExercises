//
//  NSString+defailt.h
//  PPWBrand
//
//  Created by ios2 on 2019/4/19.
//  Copyright © 2019 ShanZhou. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSString (defailt)
+ (NSString *)disable_emoji:(NSString *)text;
+ (BOOL)stringContainsEmoji:(NSString *)string;
-(NSString *)disable_emoji;
+ (BOOL)valiMobile:(NSString *)mobile;
+ (BOOL) validateEmail:(NSString *)email;
+(BOOL)isNumberAndLetter:(NSString *)letter;
- (NSString *)md5String;
+(NSDictionary *)jsonStrToDic:(NSString *)jsonString;

+(NSString *)convertToJsonData:(NSDictionary *)dict;

-(NSAttributedString *)topicAttributedString;

+(NSString *)translationArabicNum:(NSInteger)arabicNum;

- (NSString *)urlEncodedString;

- (NSString *)urlDecodedString;

@end

NS_ASSUME_NONNULL_END
