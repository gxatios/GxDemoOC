//
//  DemoRequest.h
//  GxDemoOC
//
//  Created by zhxGx on 2018/2/6.
//  Copyright © 2018年 gx. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger, Request_Mothod){
    RequestMethod_GET,
    RequestMethod_POST
};

typedef NS_ENUM(NSUInteger, Request_Type){
    RequestType_Ordiany,
    RequestType_Image
};

typedef void (^SuccessBlock)(NSDictionary *data);
typedef void (^FailureBlock)(NSError *error);
typedef void(^OrderResultBlock)(NSURLSessionDataTask *task,id responseObject);


@interface DemoRequest : NSObject

@property (nonatomic, strong) NSMutableDictionary *baseParams;

@property (nonatomic,copy) NSString *path;
-(NSString *)getcCompleteUrl;
-(instancetype)initWithPath:(NSString *)path
                     params:(NSDictionary *)params;
// 请求
+(NSURLSessionDataTask *)demoRequestWith:(NSString *)path
                                       params:(NSDictionary *)params
                                      success:(void(^)(NSURLSessionDataTask *task,id responseObject))success
                                      failure:(void(^)(NSURLSessionDataTask *task,NSError *error))failure
                                       target:(id)target;
//  图片上传
+(NSURLSessionDataTask *)demoImageWith:path
                                       params:params
                                    imageData:(NSData*)imageData
                                     imageKey:(NSString*)imageKey
                                      success:(void(^)(NSURLSessionDataTask *task, id responseObject))success
                                      failure:(void(^)(NSURLSessionDataTask *task,NSError *error))failure
                                       target:(id)target;
@end
