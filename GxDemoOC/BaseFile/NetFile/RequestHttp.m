
//  RequestHttp.m
//  c_app_ios
//
//  Created by Gx on 15/8/13.
//  Copyright (c) 2015年 c_app_ios. All rights reserved.
//

#import "RequestHttp.h"
#import "AFNetworking.h"
#import <CommonCrypto/CommonDigest.h>  

@implementation RequestHttp

// https://moneyhome.tunnel.qydev.com/app/services
+ (void)requestPOSTWithDic:(NSDictionary *)infoDic requestSuccess:(RequestSuccess)requestSuccess requestFailure:(RequestFailure)requestFailure
{
    [MacroMethodObject hudShowAnimateForWindow];
    NSString *urlStr = [RequestHttp requestPOSTPath:@""];
    AFHTTPSessionManager *httpManager  = [AFHTTPSessionManager manager];
//    httpManager.responseSerializer = [AFHTTPResponseSerializer serializer];
    httpManager.responseSerializer = [AFJSONResponseSerializer serializer];
    //申明请求的数据是json类型
    httpManager.requestSerializer=[AFJSONRequestSerializer serializer];
    httpManager.requestSerializer.timeoutInterval = KTimeoutInterval;
//    [httpManager.requestSerializer setValue:@"application/x-www-form-urlencoded; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
//    httpManager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript", @"text/html",@"text/plain", nil];//设置相应内容类型

    NSDictionary *passDic  = [self md5Dic:infoDic];
    [httpManager POST:urlStr parameters:passDic progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [MacroMethodObject hudHideAnimateForWindow];
        if (requestSuccess) {
            NSString *result = [NSString stringWithFormat:@"%@",responseObject[@"error"]];
            if ([result isEqualToString:@"-2"]) {
                [[NSNotificationCenter defaultCenter] postNotificationName:Notifi_Login_Out object:nil];
            }else{
                requestSuccess(responseObject);
            }
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (requestFailure) {
            requestFailure(error);
        }
    }];
}
+ (void)requestPOSTNoHUD:(NSDictionary *)infoDic requestSuccess:(RequestSuccess)requestSuccess requestFailure:(RequestFailure)requestFailure
{
    NSString *urlStr = [RequestHttp requestPOSTPath:@""];
    AFHTTPSessionManager *httpManager  = [AFHTTPSessionManager manager];
    httpManager.responseSerializer = [AFJSONResponseSerializer serializer];
    httpManager.requestSerializer=[AFJSONRequestSerializer serializer];
    httpManager.requestSerializer.timeoutInterval = KTimeoutInterval;

    NSDictionary *passDic  = [self md5Dic:infoDic];
    [httpManager POST:urlStr parameters:passDic progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [MacroMethodObject hudHideAnimateForWindow];
        if (requestSuccess) {
            NSString *result = [NSString stringWithFormat:@"%@",responseObject[@"error"]];
            if ([result isEqualToString:@"-2"]) {
                [[NSNotificationCenter defaultCenter] postNotificationName:Notifi_Login_Out object:nil];
            }else{
                requestSuccess(responseObject);
            }
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (requestFailure) {
            requestFailure(error);
        }
    }];
}
+ (void)requestImageWithDic:(NSDictionary *)infoDic requestSuccess:(RequestSuccess)requestSuccess requestFailure:(RequestFailure)requestFailure
{
    [MacroMethodObject hudShowAnimateForWindow];
    NSString *urlStr = Net_Host;
    AFHTTPSessionManager *httpManager  = [AFHTTPSessionManager manager];
    //    httpManager.responseSerializer = [AFHTTPResponseSerializer serializer];
    httpManager.responseSerializer = [AFJSONResponseSerializer serializer];
    //申明请求的数据是json类型
    httpManager.requestSerializer=[AFJSONRequestSerializer serializer];
    httpManager.requestSerializer.timeoutInterval = KTimeoutInterval;

    NSDictionary *passDic  = [self md5Dic:infoDic];
    [httpManager POST:urlStr parameters:[self md5Dic:infoDic] progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [MacroMethodObject hudHideAnimateForWindow];
        if (requestSuccess) {
            requestSuccess(responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (requestFailure) {
            requestFailure(error);
        }
    }];
}

+ (void)uploadImageWithDic:(NSDictionary *)infoDic imageData:(NSData *)data name:(NSString *)nameStr requestSuccess:(RequestSuccess)requestSuccess requestFailure:(RequestFailure)requestFailure{
    NSString *urlStr = [RequestHttp requestPOSTPath:@""];
    AFHTTPSessionManager *httpManager  = [AFHTTPSessionManager manager];
    httpManager.responseSerializer = [AFJSONResponseSerializer serializer];
    httpManager.requestSerializer=[AFJSONRequestSerializer serializer];
    httpManager.requestSerializer.timeoutInterval = KTimeoutInterval;
//    httpManager.responseSerializer.acceptableContentTypes=[NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript", @"text/html", @"text/plain", nil];
    httpManager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html", nil];
    NSDictionary *passDic  = [self md5Dic:infoDic];
    [httpManager POST:urlStr parameters:passDic constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        NSString *dataStr = [data base64EncodedStringWithOptions:0];

        NSString *fileName = [NSString stringWithFormat:@"%@.jpg", nameStr];
        [formData appendPartWithFileData:data name:nameStr fileName:fileName mimeType:@"image/jpg"];
        
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (requestSuccess) {
            requestSuccess(responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (requestFailure) {
            requestFailure(error);
        }
    }];
}

+(NSDictionary *)md5Dic:(NSDictionary *)passDic{
    NSString *signStr = [self key:passDic];
    signStr = [NSString stringWithFormat:@"%@421E266BD934B743",signStr];
    NSString *md5Str = [self MD5ForLower32Bate:signStr];
    NSMutableDictionary *resultDic = [[NSMutableDictionary alloc] initWithDictionary:passDic];
    [resultDic setValue:md5Str forKey:@"sign"];
    return resultDic;
}

+(NSString *)requestPOSTPath:(NSString*)host{
    NSString *hostStr = Net_Host;
    
    return hostStr;
}

#pragma mark - 16位 小写
+(NSString *)MD5ForLower16Bate:(NSString *)str{
    
    NSString *md5Str = [self MD5ForLower32Bate:str];
    
    NSString  *string;
    for (int i=0; i<24; i++) {
        string=[md5Str substringWithRange:NSMakeRange(8, 16)];
    }
    return string;
}

+(NSString *)MD5ForLower32Bate:(NSString *)str{ // 32 md5 小写
    
    //要进行UTF8的转码
    const char* input = [str UTF8String];
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    CC_MD5(input, (CC_LONG)strlen(input), result);
    
    NSMutableString *digest = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
    for (NSInteger i = 0; i < CC_MD5_DIGEST_LENGTH; i++) {
        [digest appendFormat:@"%02x", result[i]];
    }
    
    return digest;
}



+(NSString *)key:(NSDictionary*)dic
{
    NSMutableArray *dicArr = [dic allKeys].mutableCopy;
    
    NSSortDescriptor *descriptor = [NSSortDescriptor sortDescriptorWithKey:nil ascending:YES];
    NSArray *descriptors = [NSArray arrayWithObject:descriptor];
    NSArray *resultArray = [dicArr sortedArrayUsingDescriptors:descriptors].mutableCopy;
    
    dicArr = resultArray.mutableCopy;
    
//    for (int i = 0; i< dicArr.count-1; i++)
//    {
//        for (int j = 0; j < dicArr.count - i - 1; j++)
//        {
//            NSString* str11 = dicArr[j];
//            NSString* str22 = dicArr[j+1];
//            if (str11.length > str22.length)
//            {
//                [dicArr exchangeObjectAtIndex:j withObjectAtIndex:j+1];
//            }
//        }
//    }
    NSMutableString *shaStr = [[NSMutableString alloc] init];
    
    for (int i = 0; i < dicArr.count; i++)
    {
        NSString *value = [dic objectForKey:dicArr[i]];
        if (value && value.length>0) {
            [shaStr appendString:dicArr[i]];
            [shaStr appendString:@"="];
            [shaStr appendString:value];

            [shaStr appendString:@"&"];
            
        }
    }
//    shaStr = [shaStr substringToIndex:shaStr.length-1];
    return shaStr;
}
@end
