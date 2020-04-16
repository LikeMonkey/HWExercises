//
//  HWToolBox.h
//  HWExercises
//
//  Created by sxmaps_w on 2017/5/22.
//  Copyright © 2017年 wqb. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HWToolBox : NSObject

//通过view获取控制器
+ (UIViewController *)findViewController:(UIView *)view;

//删除path路径下的文件
+ (void)clearCachesWithFilePath:(NSString *)path;

//获取沙盒Library的文件目录
+ (NSString *)LibraryDirectory;

//获取沙盒Document的文件目录
+ (NSString *)DocumentDirectory;

//获取沙盒Preference的文件目录
+ (NSString *)PreferencePanesDirectory;

// 获取沙盒Caches的文件目录
+ (NSString *)CachesDirectory;

//验证手机号码
+ (BOOL)isMobileNumber:(NSString *)mobileNum;

//验证身份证号码
+ (BOOL)isIdentityCardNumber:(NSString *)number;

//验证香港身份证号码
+ (BOOL)isIdentityHKCardNumber:(NSString *)number;

//验证密码格式（包含大写、小写、数字、6~20位）
+ (BOOL)isConformHWPassword:(NSString *)password;

//验证护照
+ (BOOL)isPassportNumber:(NSString *)number;

//计算文字的长度
+ (CGSize)sizeWithText:(NSString *)text font:(UIFont *)font maxSize:(CGSize)maxSize;

//去掉小数点后无效的零
+ (NSString *)deleteFailureZero:(NSString *)string;

//得到中英文混合字符串长度
+ (int)lengthForText:(NSString *)text;

//提示弹窗
+ (void)showAlertWithTitle:(NSString *)title sureMessage:(NSString *)sureMessage cancelMessage:(NSString *)cancelMessage warningMessage:(NSString *)warningMessage style:(UIAlertControllerStyle)UIAlertControllerStyle target:(id)target sureHandler:(void (^)())sureHandler cancelHandler:(void (^)())cancelHandler warningHandler:(void(^)())warningHandler;

//获取时间字符串，date为nil时返回当前时间
+ (NSString *)timeStringWithDate:(NSData *)date;

@end
