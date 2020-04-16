//
//  NSString+defailt.m
//  PPWBrand
//
//  Created by ios2 on 2019/4/19.
//  Copyright © 2019 ShanZhou. All rights reserved.
//

#import "NSString+defailt.h"
#import <CommonCrypto/CommonCrypto.h>
@implementation NSString (defailt)
	//去掉emoji字符串
+ (NSString *)disable_emoji:(NSString *)text
{
	NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@"[^\\u0020-\\u007E\\u00A0-\\u00BE\\u2E80-\\uA4CF\\uF900-\\uFAFF\\uFE30-\\uFE4F\\uFF00-\\uFFEF\\u0080-\\u009F\\u2000-\\u201f\r\n]" options:NSRegularExpressionCaseInsensitive error:nil];
	NSString *modifiedString = [regex stringByReplacingMatchesInString:text
															   options:0
																 range:NSMakeRange(0, [text length])
														  withTemplate:@""];
	return modifiedString;
}
	//是否含有表情
+ (BOOL)stringContainsEmoji:(NSString *)string
{
	__block BOOL returnValue = NO;

	[string enumerateSubstringsInRange:NSMakeRange(0, [string length])
							   options:NSStringEnumerationByComposedCharacterSequences
							usingBlock:^(NSString *substring, NSRange substringRange, NSRange enclosingRange, BOOL *stop) {
								const unichar hs = [substring characterAtIndex:0];
								if (0xd800 <= hs && hs <= 0xdbff) {
									if (substring.length > 1) {
										const unichar ls = [substring characterAtIndex:1];
										const int uc = ((hs - 0xd800) * 0x400) + (ls - 0xdc00) + 0x10000;
										if (0x1d000 <= uc && uc <= 0x1f77f) {
											returnValue = YES;
										}
									}
								} else if (substring.length > 1) {
									const unichar ls = [substring characterAtIndex:1];
									if (ls == 0x20e3) {
										returnValue = YES;
									}
								} else {
									if (0x2100 <= hs && hs <= 0x27ff) {
										returnValue = YES;
									} else if (0x2B05 <= hs && hs <= 0x2b07) {
										returnValue = YES;
									} else if (0x2934 <= hs && hs <= 0x2935) {
										returnValue = YES;
									} else if (0x3297 <= hs && hs <= 0x3299) {
										returnValue = YES;
									} else if (hs == 0xa9 || hs == 0xae || hs == 0x303d || hs == 0x3030 || hs == 0x2b55 || hs == 0x2b1c || hs == 0x2b1b || hs == 0x2b50) {
										returnValue = YES;
									}
								}
							}];

	return returnValue;
}

-(NSString *)disable_emoji
{
	BOOL isContaint = 	[NSString stringContainsEmoji:self];
	if (isContaint) {
		return  [NSString disable_emoji:self];
	}
	return [NSString disable_emoji:self];

}

#pragma mark -- 判断手机号正误
+ (BOOL)valiMobile:(NSString *)mobile
{
	if (mobile.length < 11) {
		return YES;
	 }else{
		 NSString *CM_NUM =   @"^(13[0-9]|14[579]|15[0-3,5-9]|16[6]|17[0135678]|18[0-9]|19[89])\\d{8}$";
		 NSPredicate *pred1 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CM_NUM];
		 BOOL isMatch1 = [pred1 evaluateWithObject:mobile];

		 if (isMatch1) {
			 return NO;
		 }else{
			 return YES;
		 }
	 }
}

#pragma mark -- 邮箱正则表达式
/** 邮箱正则表达式 */
+ (BOOL) validateEmail:(NSString *)email
{
	NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
	NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
	return [emailTest evaluateWithObject:email];
}

+(BOOL)isNumberAndLetter:(NSString *)letter
{
	NSString *zzStr = @"(?!^\\d+$)(?!^[a-zA-Z]+$)[0-9a-zA-Z]{8,16}";
	NSPredicate *numLetterTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",zzStr];
	return [numLetterTest evaluateWithObject:letter];

}

#pragma mark -- MD5加密
- (NSString *)md5String
{
	const char *cStr = [self UTF8String];
	unsigned char result[CC_MD5_DIGEST_LENGTH];
	CC_MD5( cStr, (int)strlen(cStr), result ); // This is the md5 call
	NSMutableString *string = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH];
	for (int i=0;i<CC_MD5_DIGEST_LENGTH;i++){
		[string appendFormat:@"%02x",result[i]];
	}
	return string;
}

+(NSDictionary *)jsonStrToDic:(NSString *)jsonString
{
	if (jsonString == nil) {
		return nil;
	}
	NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
	NSError *err;
	NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData
														options:NSJSONReadingMutableContainers
														  error:&err];
	if(err) {
		NSLog(@"json解析失败：%@",err);
		return nil;
	}
	return dic;
}

+(NSString *)convertToJsonData:(NSDictionary *)dict {
	NSError *error;
	NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dict options:NSJSONWritingPrettyPrinted error:&error];
	NSString *jsonString;
	if (!jsonData) {
		NSLog(@"%@",error);
	}else{
		jsonString = [[NSString alloc]initWithData:jsonData encoding:NSUTF8StringEncoding];
	}
	NSMutableString *mutStr = [NSMutableString stringWithString:jsonString];
	NSRange range = {0,jsonString.length};  //去掉字符串中的空格
	[mutStr replaceOccurrencesOfString:@" " withString:@"" options:NSLiteralSearch range:range];
	NSRange range2 = {0,mutStr.length

	}; //去掉字符串中的换行符
	[mutStr replaceOccurrencesOfString:@"\n" withString:@"" options:NSLiteralSearch range:range2];
	return mutStr;
}

-(NSAttributedString *)topicAttributedString
{
		// #话题#的规则
	NSString *topicPattern = @"#[0-9a-zA-Z\\u4e00-\\u9fa5]+#";
		// url链接的规则
		//    NSString *urlPattern = @"\\b(([\\w-]+://?|www[.])[^\\s()<>]+(?:\\([\\w\\d]+\\)|([^[:punct:]\\s]|/)))";
		// | 匹配多个条件,相当于or\或
	NSString *pattern = [NSString stringWithFormat:@"%@", topicPattern];
	NSRegularExpression *regex = [[NSRegularExpression alloc] initWithPattern:pattern options:0 error:nil];
	NSArray *results = [regex matchesInString:self options:0 range:NSMakeRange(0, self.length)];
	NSMutableAttributedString *abs = [[NSMutableAttributedString alloc]initWithString:self];
	for (NSTextCheckingResult *result in results) {
		[abs addAttribute:NSForegroundColorAttributeName value:[UIColor blueColor] range:result.range];
	}
	return abs;
}

/**
 *  将阿拉伯数字转换为中文数字
 */
+(NSString *)translationArabicNum:(NSInteger)arabicNum
{
	NSString *arabicNumStr = [NSString stringWithFormat:@"%ld",(long)arabicNum];
	NSArray *arabicNumeralsArray = @[@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"0"];
	NSArray *chineseNumeralsArray = @[@"壹",@"贰",@"叁",@"肆",@"伍",@"陆",@"柒",@"捌",@"玖",@"零"];
	NSArray *digits = @[@"个",@"拾",@"佰",@"千",@"万",@"拾",@"佰",@"千",@"亿",@"拾",@"佰",@"千",@"兆"];
	NSDictionary *dictionary = [NSDictionary dictionaryWithObjects:chineseNumeralsArray forKeys:arabicNumeralsArray];

	if (arabicNum < 20 && arabicNum > 9) {
		if (arabicNum == 10) {
			return @"拾";
		}else{
			NSString *subStr1 = [arabicNumStr substringWithRange:NSMakeRange(1, 1)];
			NSString *a1 = [dictionary objectForKey:subStr1];
			NSString *chinese1 = [NSString stringWithFormat:@"拾%@",a1];
			return chinese1;
		}
	}else{
		NSMutableArray *sums = [NSMutableArray array];
		for (int i = 0; i < arabicNumStr.length; i ++)
		 {
			NSString *substr = [arabicNumStr substringWithRange:NSMakeRange(i, 1)];
			NSString *a = [dictionary objectForKey:substr];
			NSString *b = digits[arabicNumStr.length -i-1];
			NSString *sum = [a stringByAppendingString:b];
			if ([a isEqualToString:chineseNumeralsArray[9]])
			 {
				if([b isEqualToString:digits[4]] || [b isEqualToString:digits[8]])
				 {
					sum = b;
					if ([[sums lastObject] isEqualToString:chineseNumeralsArray[9]])
					 {
						[sums removeLastObject];
					 }
				 }else
				  {
					 sum = chineseNumeralsArray[9];
				  }

				if ([[sums lastObject] isEqualToString:sum])
				 {
					continue;
				 }
			 }

			[sums addObject:sum];
		 }
		NSString *sumStr = [sums  componentsJoinedByString:@""];
		NSString *chinese = [sumStr substringToIndex:sumStr.length-1];
		return chinese;
	}
}

- (NSString *)urlEncodedString{
    CFStringRef encodedCFString = CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault,
                                                                          (__bridge CFStringRef) self,
                                                                          nil,
                                                                          CFSTR("?!@#$^&%*+,:;='\"`<>()[]{}/\\| "),
                                                                          kCFStringEncodingUTF8);
    
    NSString *encodedString = [[NSString alloc] initWithString:(__bridge_transfer NSString*) encodedCFString];
    
    if(!encodedString)
        encodedString = @"";
    
    return encodedString;
}

- (NSString *)urlDecodedString{
    CFStringRef decodedCFString = CFURLCreateStringByReplacingPercentEscapesUsingEncoding(kCFAllocatorDefault,
                                                                                          (__bridge CFStringRef) self,
                                                                                          CFSTR(""),
                                                                                          kCFStringEncodingUTF8);
    
    // We need to replace "+" with " " because the CF method above doesn't do it
    NSString *decodedString = [[NSString alloc] initWithString:(__bridge_transfer NSString*) decodedCFString];
    return (!decodedString) ? @"" : [decodedString stringByReplacingOccurrencesOfString:@"+" withString:@" "];
}

@end
