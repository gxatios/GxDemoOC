//
//  MacroMethodObject.m
//  Gx
//
//  Created by gaoxin on 16/11/1.
//  Copyright © 2016年 Gx All rights reserved.
//

#import "MacroMethodObject.h"
#import "MBProgressHUD.h"
#import <AFNetworking/AFURLRequestSerialization.h>
@implementation MacroMethodObject

+ (UIColor *) colorWithHexString: (NSString *) stringToConvert
{
    NSString *cString = [[stringToConvert stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    
    // String should be 6 or 8 characters
    //if ([cString length] < 6) return DEFAULT_VOID_COLOR;
    
    // strip 0X if it appears
    if ([cString hasPrefix:@"0X"]) cString = [cString substringFromIndex:2];
    if ([cString hasPrefix:@"#"]) cString = [cString substringFromIndex:1];
    //if ([cString length] != 6) return DEFAULT_VOID_COLOR;
    // Separate into r, g, b substrings
    NSRange range;
    range.location = 0;
    range.length = 2;
    NSString *rString = [cString substringWithRange:range];
    
    range.location = 2;
    NSString *gString = [cString substringWithRange:range];
    
    range.location = 4;
    NSString *bString = [cString substringWithRange:range];
    
    // Scan values
    unsigned int r, g, b;
    [[NSScanner scannerWithString:rString] scanHexInt:&r];
    [[NSScanner scannerWithString:gString] scanHexInt:&g];
    [[NSScanner scannerWithString:bString] scanHexInt:&b];
    //NSLog(@"%f:::%f:::%f",((float) r / 255.0f),((float) g / 255.0f),((float) b / 255.0f));
    
    //	return SF_COLOR(((float) r / 255.0f),((float) g / 255.0f),((float) b / 255.0f), 1);
    return [UIColor colorWithRed:((float) r / 255.0f) green:((float) g / 255.0f) blue:((float) b / 255.0f) alpha:1];
}
+ (UIImage*) createImageWithColor: (UIColor*) color
{
    CGRect rect=CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContextWithOptions(rect.size, NO, [UIScreen mainScreen].scale);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage*theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return theImage;
}
+ (UIImage *) createImageWithColor:(UIColor *) color andRect:(CGRect)rect andCornerRadius:(float)radius
{
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextBeginPath(context);
    addRoundedRectToPath(context, rect, radius, radius);
    CGContextClosePath(context);
    CGContextClip(context);
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return theImage;
}
static void addRoundedRectToPath(CGContextRef context, CGRect rect, float ovalWidth,
                                 float ovalHeight)
{
    float fw, fh;
    if (ovalWidth == 0 || ovalHeight == 0) {
        CGContextAddRect(context, rect);
        return;
    }
    CGContextSaveGState(context);
    CGContextTranslateCTM(context, CGRectGetMinX(rect), CGRectGetMinY(rect));
    CGContextScaleCTM(context, ovalWidth, ovalHeight);
    fw = CGRectGetWidth(rect) / ovalWidth;
    fh = CGRectGetHeight(rect) / ovalHeight;
    
    CGContextMoveToPoint(context, fw, fh/2);  // Start at lower right corner
    CGContextAddArcToPoint(context, fw, fh, fw/2, fh, 1);  // Top right corner
    CGContextAddArcToPoint(context, 0, fh, 0, fh/2, 1); // Top left corner
    CGContextAddArcToPoint(context, 0, 0, fw/2, 0, 1); // Lower left corner
    CGContextAddArcToPoint(context, fw, 0, fw, fh/2, 1); // Back to lower right
    
    CGContextClosePath(context);
    CGContextRestoreGState(context);
}

+(void)hudShowAnimateForWindow{
    [MBProgressHUD hideHUDForView:[UIApplication sharedApplication].keyWindow animated:YES];
    MBProgressHUD *hud = [[MBProgressHUD alloc] initWithView:[UIApplication sharedApplication].keyWindow];
    [[UIApplication sharedApplication].keyWindow addSubview:hud];
    [[UIApplication sharedApplication].keyWindow bringSubviewToFront:hud];
    hud.mode = MBProgressHUDModeIndeterminate;
    [hud showAnimated:YES];
//    [hud hideAnimated:YES afterDelay:8];
    
//    [MBProgressHUD showHUDAddedTo:[UIApplication sharedApplication].keyWindow animated:YES];
}
+(void)hudHideAnimateForWindow{
//    [MBProgressHUD hideHUDForView:[UIApplication sharedApplication].keyWindow animated:YES];
    dispatch_async(dispatch_get_main_queue(), ^{
        [MBProgressHUD hideHUDForView:[UIApplication sharedApplication].keyWindow animated:YES];
    });
}

+(void)showHudTextinWindow:(NSString *)str{
    dispatch_async(dispatch_get_main_queue(), ^{
        [MacroMethodObject showHudText:str inView:[UIApplication sharedApplication].keyWindow];
    });
}

+(void)showFailHudinWindow{
    dispatch_async(dispatch_get_main_queue(), ^{
        [MacroMethodObject showFailHudinView:[UIApplication sharedApplication].keyWindow];
    });
}
+(void)showHudIndeter:(NSString*)str inView:(UIView *)view{
    if (view) {
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
        hud.mode = MBProgressHUDModeIndeterminate;
        hud.detailsLabel.text = str;
        dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, 1.5 * NSEC_PER_SEC);
        dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
            // Do something...
            [MBProgressHUD hideHUDForView:view animated:YES];
        });
        //        MBProgressHUD *showHud = [[MBProgressHUD alloc] initWithView:view];
        //        [view addSubview:showHud];
        //        showHud.detailsLabel.text = str;
        //        showHud.mode = MBProgressHUDModeIndeterminate;
        //        [showHud showAnimated:YES whileExecutingBlock:^{
        //            sleep(1.5);
        //        } completionBlock:^{
        //            [showHud removeFromSuperview];
        //        }];
    }
}


+(void)showHudText:(NSString*)str inView:(UIView *)view{
     [MBProgressHUD hideHUDForView:view animated:YES];
//        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
        MBProgressHUD *hud = [[MBProgressHUD alloc] initWithView:view];
        [view addSubview:hud];
        [view bringSubviewToFront:hud];
        hud.mode = MBProgressHUDModeText;
        hud.detailsLabel.text = str;
    hud.bezelView.backgroundColor = RGBCOLOR(1, 1, 1, 0.2);
    hud.detailsLabel.font = [UIFont systemFontOfSize:16];

        [hud showAnimated:YES];
        [hud hideAnimated:YES afterDelay:1.5];
//        dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, 1.5 * NSEC_PER_SEC);
//        dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
//            // Do something...
//            [MBProgressHUD hideHUDForView:view animated:YES];
//        });
//        MBProgressHUD *showHud = [[MBProgressHUD alloc] initWithView:view];
//        [view addSubview:showHud];
//        showHud.detailsLabel.text = str;
//        showHud.mode = MBProgressHUDModeIndeterminate;
//        [showHud showAnimated:YES whileExecutingBlock:^{
//            sleep(1.5);
//        } completionBlock:^{
//            [showHud removeFromSuperview];
//        }];
}

+(void)showHudinView:(UIView *)view{
    if (view) {
        [MBProgressHUD showHUDAddedTo:view animated:YES];
    }
}
+(void)hideHudinView:(UIView *)view{

        dispatch_async(dispatch_get_main_queue(), ^{
            [MBProgressHUD hideHUDForView:view animated:YES];
        });
    
//    for (UIView *hud in [UIApplication sharedApplication].keyWindow.subviews) {
//        if ([hud isKindOfClass:[MBProgressHUD class]]) {
//            [hud removeFromSuperview];
//        }
//    }
}
+(void)showFailHudinView:(UIView *)view{
        [MBProgressHUD hideHUDForView:view animated:YES];
//        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
        MBProgressHUD *hud = [[MBProgressHUD alloc] initWithView:view];
        [view addSubview:hud];
    hud.bezelView.backgroundColor = RGBCOLOR(1, 1, 1, 0.2);
    hud.detailsLabel.font = [UIFont systemFontOfSize:16];
        hud.mode = MBProgressHUDModeCustomView;
        hud.detailsLabel.text = requestFailTest;
        [hud showAnimated:YES];
        dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, 1.5 * NSEC_PER_SEC);
        dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
            // Do something...
            [MBProgressHUD hideHUDForView:view animated:YES];
        });
}
+(BOOL)isValitString:(NSString *)testStr{
    if (testStr.length>0 && ![testStr isEqualToString:@"(null)"]&& ![testStr isEqualToString:@"<null>"]) {
        return YES;
    }
    return NO;
}

+ (BOOL)validateUserName:(NSString *)name // 中英文 数字 下划线 ^[\u4e00-\u9fa5_a-zA-Z0-9]+$
{
//    NSString *userNameRegex = @"^[\u4E00-\u9FA5a-zA-Z0-9]{2,16}";
    NSString *userNameRegex = @"^[\u4E00-\u9FA5a-zA-Z0-9]+$";
    NSPredicate *userNamePredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",userNameRegex];
    BOOL B = [userNamePredicate evaluateWithObject:name];
    return B;
}
+ (BOOL)validatePhoneNum:(NSString *)name{//  11位手机号
    NSString *userNameRegex = @"^[0-9]{11}";
    NSPredicate *userNamePredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",userNameRegex];
    BOOL B = [userNamePredicate evaluateWithObject:name];
    return B;
}
+ (BOOL)judgeIdentityStringValid:(NSString *)identityString {
    
    if (identityString.length != 18) return NO;
    // 正则表达式判断基本 身份证号是否满足格式
    NSString *regex = @"^[1-9]\\d{5}[1-9]\\d{3}((0\\d)|(1[0-2]))(([0|1|2]\\d)|3[0-1])\\d{3}([0-9]|X)$";
    //  NSString *regex = @"^(^[1-9]\\d{7}((0\\d)|(1[0-2]))(([0|1|2]\\d)|3[0-1])\\d{3}$)|(^[1-9]\\d{5}[1-9]\\d{3}((0\\d)|(1[0-2]))(([0|1|2]\\d)|3[0-1])((\\d{4})|\\d{3}[Xx])$)$";
    NSPredicate *identityStringPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex];
    //如果通过该验证，说明身份证格式正确，但准确性还需计算
    if(![identityStringPredicate evaluateWithObject:identityString]) return NO;
    
    //** 开始进行校验 *//
    /*
    //将前17位加权因子保存在数组里
    NSArray *idCardWiArray = @[@"7", @"9", @"10", @"5", @"8", @"4", @"2", @"1", @"6", @"3", @"7", @"9", @"10", @"5", @"8", @"4", @"2"];
    
    //这是除以11后，可能产生的11位余数、验证码，也保存成数组
    NSArray *idCardYArray = @[@"1", @"0", @"10", @"9", @"8", @"7", @"6", @"5", @"4", @"3", @"2"];
    //用来保存前17位各自乖以加权因子后的总和
    NSInteger idCardWiSum = 0;
    for(int i = 0;i < 17;i++) {
        NSInteger subStrIndex = [[identityString substringWithRange:NSMakeRange(i, 1)] integerValue];
        NSInteger idCardWiIndex = [[idCardWiArray objectAtIndex:i] integerValue];
        idCardWiSum+= subStrIndex * idCardWiIndex;
    }
    
    //计算出校验码所在数组的位置
    NSInteger idCardMod=idCardWiSum%11;
    //得到最后一位身份证号码
    NSString *idCardLast= [identityString substringWithRange:NSMakeRange(17, 1)];
    //如果等于2，则说明校验码是10，身份证号码最后一位应该是X
    if(idCardMod==2) {
        if(![idCardLast isEqualToString:@"X"]||[idCardLast isEqualToString:@"x"]) {
            return NO;
        }
    }
    else{
        //用计算出的验证码与最后一位身份证号码匹配，如果一致，说明通过，否则是无效的身份证号码
        if(![idCardLast isEqualToString: [idCardYArray objectAtIndex:idCardMod]]) {
            return NO;
        }
    }*/
    return YES;
}

+ (BOOL)validateBarCode:(NSString *)code // 英文 数字^[a-zA-Z0-9]+$
{
    //    NSString *userNameRegex = @"^[\u4E00-\u9FA5a-zA-Z0-9]{2,16}";
    NSString *userNameRegex = @"^[a-zA-Z0-9]{16}";
    NSPredicate *userNamePredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",userNameRegex];
    BOOL B = [userNamePredicate evaluateWithObject:code];
    return B;
}

+ (NSString *)encrypt3DES:(NSString *)src key:(NSString *)key{
    const void *vplainText;
    size_t plainTextBufferSize;
    NSData* data = [src dataUsingEncoding:CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingGB_18030_2000)];
    plainTextBufferSize = [data length];
    vplainText = (const void *)[data bytes];
    CCCryptorStatus ccStatus;
    uint8_t *bufferPtr = NULL;
    size_t bufferPtrSize = 0;
    size_t movedBytes = 0;
    
    bufferPtrSize = (plainTextBufferSize + kCCBlockSizeDES) & ~(kCCBlockSizeDES - 1);
    bufferPtr = malloc( bufferPtrSize * sizeof(uint8_t));
    memset((void *)bufferPtr, 0x0, bufferPtrSize);
    const void *vkey = (const void *)[key UTF8String];
    
    ccStatus = CCCrypt(kCCEncrypt,
                       kCCAlgorithmDES,
                       kCCOptionPKCS7Padding | kCCOptionECBMode,
                       vkey,
                       kCCKeySizeDES,
                       nil,
                       vplainText,
                       plainTextBufferSize,
                       (void *)bufferPtr,
                       bufferPtrSize,
                       &movedBytes);
    
    NSData *myData = [NSData dataWithBytes:(const void *)bufferPtr length:(NSUInteger)movedBytes];
    NSString *result = [[NSString alloc] initWithData:myData  encoding:NSUTF8StringEncoding];
    //    return result;
    return [self convertDataToHexStr:myData];
}
+ (NSString *)convertDataToHexStr:(NSData *)data {
    if (!data || [data length] == 0) {
        return @"";
    }
    NSMutableString *string = [[NSMutableString alloc] initWithCapacity:[data length]];
    
    [data enumerateByteRangesUsingBlock:^(const void *bytes, NSRange byteRange, BOOL *stop) {
        unsigned char *dataBytes = (unsigned char*)bytes;
        for (NSInteger i = 0; i < byteRange.length; i++) {
            NSString *hexStr = [NSString stringWithFormat:@"%x", (dataBytes[i]) & 0xff];
            if ([hexStr length] == 2) {
                [string appendString:hexStr];
            } else {
                [string appendFormat:@"0%@", hexStr];
            }
        }
    }];
    
    return string;
}

+(NSString *)dateToString:(NSDate*)date{
    NSDateFormatter *dateFormatter=[[NSDateFormatter alloc]init];//创建一个日期格式化器
//    dateFormatter.dateFormat=@"yyyy-MM-dd hh:mm:ss";//指定转date得日期格式化形式
    dateFormatter.dateFormat=@"yyyy-MM-dd";
//    dateFormatter.dateFormat=@"yyyy-MM-dd eeee aa HH:mm:ss";
//      dateFormatter.dateFormat=@"yyyy-MM-dd hh:mm:ss z";
    
    NSString *result = [dateFormatter stringFromDate:date];
    return result;
}

+(NSString *)dateToMinuteString:(NSDate*)date{
    NSDateFormatter *dateFormatter=[[NSDateFormatter alloc]init];//创建一个日期格式化器
    //    dateFormatter.dateFormat=@"yyyy-MM-dd hh:mm:ss";//指定转date得日期格式化形式
    dateFormatter.dateFormat=@"yyyy-MM-dd HH:mm";
    //    dateFormatter.dateFormat=@"yyyy-MM-dd eeee aa HH:mm:ss";
    //      dateFormatter.dateFormat=@"yyyy-MM-dd hh:mm:ss z";
    
    NSString *result = [dateFormatter stringFromDate:date];
    return result;
}
+(NSDate *)strToDate:(NSString*)dateStr{
    NSDateFormatter *dateFormatter=[[NSDateFormatter alloc]init];//创建一个日期格式化器

    dateFormatter.dateFormat=@"yyyy-MM-dd HH:mm:ss";
//    [dateFormatter setTimeZone:[NSTimeZone timeZoneWithName:@"GMT"]];
//    [dateFormatter setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"en_US"]];
    NSDate *date = [dateFormatter dateFromString:dateStr];
    return date;
}
//传入今天的时间，返回明天的时间
+ (NSDate *)tomorrowDay:(NSDate *)aDate after:(NSInteger)num{
    NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *components = [gregorian components:NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay fromDate:aDate];
    [components setDay:([components day]+num)];
    
    NSDate *beginningOfWeek = [gregorian dateFromComponents:components];
    return beginningOfWeek;
}
+ (NSString *)dictionaryToJSONString:(NSDictionary *)dictionary
{
    NSError *error = nil;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dictionary options:NSJSONWritingPrettyPrinted error:&error];
    NSString *jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    //    NSString *jsonTemp = [jsonString stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    //    NSString *jsonResult = [jsonTemp stringByReplacingOccurrencesOfString:@" " withString:@""];
    return jsonString;
}


+ (NSString *)arrayToJSONString:(NSArray *)array
{
    NSError *error = nil;
    //    NSMutableArray *muArray = [NSMutableArray array];
    //    for (NSString *userId in array) {
    //        [muArray addObject:[NSString stringWithFormat:@"\"%@\"", userId]];
    //    }
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:array options:NSJSONWritingPrettyPrinted error:&error];
    NSString *jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    NSString *jsonTemp = [jsonString stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    NSString *jsonResult = [jsonTemp stringByReplacingOccurrencesOfString:@" " withString:@""];
    NSString *result = [jsonResult stringByReplacingOccurrencesOfString:@"\\" withString:@""];
    //    NSLog(@"json array is: %@", jsonResult);
    return result;
}

+(void)callPhoneMethod:(NSString*)phoneNum{
    NSString *mobile = [NSString stringWithFormat:@"tel:%@",phoneNum];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:mobile]];
}
@end
