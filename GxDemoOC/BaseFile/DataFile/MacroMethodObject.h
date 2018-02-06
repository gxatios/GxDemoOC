//
//  MacroMethodObject.h
//  Gx
//
//  Created by gaoxin on 16/11/1.
//  Copyright © 2016年 Gx All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <CommonCrypto/CommonCrypto.h>

#define requestFailTest @"网络请求失败"

@interface MacroMethodObject : NSObject
+ (UIColor *) colorWithHexString: (NSString *) stringToConvert;
+ (UIImage*) createImageWithColor: (UIColor*) color;
+ (UIImage *) createImageWithColor:(UIColor *) color andRect:(CGRect)rect andCornerRadius:(float)radius;
+(BOOL)isValitString:(NSString *)testStr;
+(NSString*)urlBase; // url地址
+(void)hudShowAnimateForWindow;
+(void)hudHideAnimateForWindow;
+(void)showHudText:(NSString*)str inView:(UIView *)view;
+(void)showHudinView:(UIView *)view;
+(void)hideHudinView:(UIView *)view;
+(void)showFailHudinView:(UIView *)view;
+(void)showHudIndeter:(NSString*)str inView:(UIView *)view;
+ (NSString*)noLoginSha256:(NSString*)canshu;

+(NSString*) sha256:(NSString *)inputStr;
+ (BOOL)validateUserName:(NSString *)name; //  用户名
+ (BOOL)validatePhoneNum:(NSString *)name; //  11位数字手机号
+ (BOOL)judgeIdentityStringValid:(NSString *)identityString; // 身份证号
+ (BOOL)validateBarCode:(NSString *)code; // 条形码 数字字母
+(void)showHudTextinWindow:(NSString *)str;
+(void)showFailHudinWindow;

//客户端验签
+ (BOOL)vaildateResponse:(NSDictionary *)dict  AndIsLogin:(BOOL)isLogin;

+ (NSString *)encrypt3DES:(NSString *)src key:(NSString *)key;

+(NSString *)dateToString:(NSDate*)date;
+(NSString *)dateToMinuteString:(NSDate*)date;

+(NSDate *)strToDate:(NSString*)dateStr;
+ (NSDate *)tomorrowDay:(NSDate *)aDate after:(NSInteger)num;

+ (NSString *)arrayToJSONString:(NSArray *)array;
+ (NSString *)dictionaryToJSONString:(NSDictionary *)dictionary;
+(void)callPhoneMethod:(NSString*)phoneNum;
@end
