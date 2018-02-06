//
//  RequestHttp.h
//  gx
//
//  Created by Gx on 15/8/13.
//  Copyright (c) 2015年 gx. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 *  请求成功后的回调
 *
 *  @param json 服务器返回的JSON数据
 */
typedef void (^RequestSuccess)(id json);
/**
 *  请求失败后的回调
 *
 *  @param error 错误信息
 */
typedef void (^RequestFailure)();


@interface RequestHttp : NSObject




//+ (void)requestGETWith:(NSString*)first and:(NSString *)second dic:(NSDictionary *)infoDic requestSuccess:(RequestSuccess)requestSuccess requestFailure:(RequestFailure)requestFailure;
+ (void)requestImageWithDic:(NSDictionary *)infoDic requestSuccess:(RequestSuccess)requestSuccess requestFailure:(RequestFailure)requestFailure;
+ (void)requestPOSTWithDic:(NSDictionary *)infoDic requestSuccess:(RequestSuccess)requestSuccess requestFailure:(RequestFailure)requestFailure;
+ (void)uploadImageWithDic:(NSDictionary *)infoDic imageData:(NSData *)data name:(NSString *)nameStr requestSuccess:(RequestSuccess)requestSuccess requestFailure:(RequestFailure)requestFailure;
+(NSString *)requestPOSTPath:(NSString*)host;
+ (void)requestPOSTNoHUD:(NSDictionary *)infoDic requestSuccess:(RequestSuccess)requestSuccess requestFailure:(RequestFailure)requestFailure;
@end
