//
//  HWToolBox.m
//  HWExercises
//
//  Created by sxmaps_w on 2017/5/22.
//  Copyright © 2017年 wqb. All rights reserved.
//

#import "HWToolBox.h"

@implementation HWToolBox

//通过view获取控制器
+ (UIViewController *)findViewController:(UIView *)view
{
    id target = view;
    while (target) {
        target = ((UIResponder *)target).nextResponder;
        if ([target isKindOfClass:[UIViewController class]]) {
            break;
        }
    }
    
    return target;
}

//删除path路径下的文件
+ (void)clearCachesWithFilePath:(NSString *)path
{
    NSFileManager *mgr = [NSFileManager defaultManager];
    [mgr removeItemAtPath:path error:nil];
}

//获取沙盒Library的文件目录
+ (NSString *)LibraryDirectory
{
    return [NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES) lastObject];
}

//获取沙盒Document的文件目录
+ (NSString *)DocumentDirectory
{
    return [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
}

//获取沙盒Preference的文件目录
+ (NSString *)PreferencePanesDirectory
{
    return [NSSearchPathForDirectoriesInDomains(NSPreferencePanesDirectory, NSUserDomainMask, YES) lastObject];
}

//获取沙盒Caches的文件目录
+ (NSString *)CachesDirectory
{
    return [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
}

//验证手机号码
+ (BOOL)isMobileNumber:(NSString *)mobileNum
{
    NSString *mobile = @"^0?(13|14|15|16|17|18|19)[0-9]{9}$";
    
    NSPredicate *regextestMobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", mobile];
    
    if ([regextestMobile evaluateWithObject:mobileNum] == YES) {
        return YES;
    }else {
        return NO;
    }
}

//验证身份证号码
+ (BOOL)isIdentityCardNumber:(NSString *)number
{
    NSString *cardNum = @"^[1-9]\\d{5}[1-9]\\d{3}((0\\d)|(1[0-2]))(([0|1|2]\\d)|3[0-1])\\d{3}([0-9]|[X|x])";
    
    NSPredicate *identityCardPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", cardNum];
    
    if ([identityCardPredicate evaluateWithObject:number] == YES) {
        return YES;
    }else {
        return NO;
    }
}

//验证香港身份证号码
+ (BOOL)isIdentityHKCardNumber:(NSString *)number
{
    NSString *cardNum = @"^[A-Z]{1,2}[0-9]{6}\\(?[0-9A]\\)?$";
    
    NSPredicate *identityCardPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", cardNum];
    
    if ([identityCardPredicate evaluateWithObject:number] == YES) {
        return YES;
    }else {
        return NO;
    }
}

//验证是否护照
+ (BOOL)isPassportNumber:(NSString *)number
{
    NSString *portNum = @"^1[45][0-9]{7}|([P|p|S|s]\\d{7})|([S|s|G|g]\\d{8})|([Gg|Tt|Ss|Ll|Qq|Dd|Aa|Ff]\\d{8})|([H|h|M|m]\\d{8，10})$";
    NSPredicate *identityCardPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", portNum];
    if ([identityCardPredicate evaluateWithObject:number] == YES) {
        return YES;
    }else {
        return NO;
    }
}

//验证密码格式（包含大写、小写、数字、6~20位）
+ (BOOL)isConformHWPassword:(NSString *)password
{
    NSString *conText = @"(?=.*[A-Z])(?=.*[a-z])(?=.*[0-9])[a-zA-Z0-9]{6,20}";
    
    NSPredicate *regextestMobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", conText];
    
    if ([regextestMobile evaluateWithObject:password] == YES) {
        return YES;
    }else {
        return NO;
    }
}

//计算文字的长度
+ (CGSize)sizeWithText:(NSString *)text font:(UIFont *)font maxSize:(CGSize)maxSize
{
    return [text boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:font} context:nil].size;
}

//去掉小数点后无效的0
+ (NSString *)deleteFailureZero:(NSString *)string
{
    if ([string rangeOfString:@"."].length == 0) return string;
    
    for (int i = 0; i < string.length; i++) {
        if (![string hasSuffix:@"0"]) {
            break;
        }else {
            string = [string substringToIndex:[string length] - 1];
        }
    }
    
    //避免像2.0000这样的被解析成2.
    if ([string hasSuffix:@"."]) {
        return [string substringToIndex:[string length] - 1];
    }else {
        return string;
    }
}

//得到中英文混合字符串长度
+ (int)lengthForText:(NSString *)text
{
    int strlength = 0;
    char *p = (char*)[text cStringUsingEncoding:NSUnicodeStringEncoding];
    for (int i=0 ; i < [text lengthOfBytesUsingEncoding:NSUnicodeStringEncoding]; i++) {
        if (*p) {
            p++;
            strlength++;
        }else {
            p++;
        }
    }
    
    return strlength;
}

//提示弹窗
+ (void)showAlertWithTitle:(NSString *)title sureMessage:(NSString *)sureMessage cancelMessage:(NSString *)cancelMessage warningMessage:(NSString *)warningMessage style:(UIAlertControllerStyle)UIAlertControllerStyle target:(id)target sureHandler:(void (^)())sureHandler cancelHandler:(void (^)())cancelHandler warningHandler:(void(^)())warningHandler
{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:nil preferredStyle:UIAlertControllerStyle];
    
    if (sureMessage) {
        UIAlertAction *sureAction = [UIAlertAction actionWithTitle:sureMessage style:UIAlertActionStyleDefault handler:sureHandler];
        [alertController addAction:sureAction];
    }
    
    if (cancelMessage) {
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:cancelMessage style:UIAlertActionStyleCancel handler:cancelHandler];
        [alertController addAction:cancelAction];
    }
    
    if (warningMessage) {
        UIAlertAction *warningBtn = [UIAlertAction actionWithTitle:warningMessage style:UIAlertActionStyleDestructive handler:warningHandler];
        [alertController addAction:warningBtn];
    }
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [target presentViewController:alertController animated:YES completion:nil];
    });
}

//获取时间字符串，date为nil时返回当前时间
+ (NSString *)timeStringWithDate:(NSDate *)date
{
    if (!date) date = [NSDate date];
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:@"YYYY-MM-dd"];
    
    return [formatter stringFromDate:date];
}

@end
