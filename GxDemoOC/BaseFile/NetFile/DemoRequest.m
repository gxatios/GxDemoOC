//
//  DemoRequest.m
//  GxDemoOC
//
//  Created by zhxGx on 2018/2/6.
//  Copyright © 2018年 gx. All rights reserved.
//

#import "DemoRequest.h"
#import "DemoSessionManager.h"
#import "DemoDataModel.h"

@implementation DemoRequest
-(instancetype)init{
    if (self = [super init]) {
    }
    return self;
}
-(instancetype)initWithPath:(NSString *)path
                     params:(NSDictionary *)params{
    if (self = [super init]) {
        self.baseParams = [[NSMutableDictionary alloc] init];
        _path = path;
        
    }
    return self;
}

-(Request_Mothod)getRequestMethod{
    return RequestMethod_POST;
    //    return RequestMethod_GET;
}

-(Request_Type)getRequestType{
    return RequestType_Ordiany;
}
-(NSString *)getcCompleteUrl{
    NSString *url = [NSString stringWithFormat:@"%@%@",[MacroMethodObject urlBase],self.path];
    NSLog(@"****url***-===%@",url);
    return url;
}
// 请求
+(NSURLSessionDataTask *)demoRequestWith:(NSString *)path
                                  params:(NSDictionary *)params
                                 success:(void(^)(NSURLSessionDataTask *task,id responseObject))success
                                 failure:(void(^)(NSURLSessionDataTask *task,NSError *error))failure
                                  target:(id)target{
    DemoRequest *request = [[self alloc] initWithPath:path params:params];
    return [request requestParams:params success:success failure:failure];
}
-(NSURLSessionDataTask *)requestParams:(NSDictionary *)params success:(void(^)(NSURLSessionDataTask *task, id responseObject))success failure:(void(^)(NSURLSessionDataTask * task,NSError *error))failure{
    DemoSessionManager *manager = [DemoSessionManager shareInstance];
    
    NSMutableDictionary *mutableDic = [DemoDataModel fullDicOf:params];
    NSLog(@"ske Params:%@",mutableDic);
    if (!mutableDic) {
        failure(nil,nil);
        return nil;
    }
//    if ([self getRequestMethod] == RequestMethod_POST) {
        NSURLSessionDataTask *task = [manager POST:[self getcCompleteUrl]
                                       parameters:mutableDic
                                          success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                                              NSLog(@"ske result");
                                              NSMutableDictionary *response = responseObject;
                                                  if ([[response objectForKey:@"result"] isEqualToString:@"000"]) {
                                                      //  返回成功
                                                      success(task,response);
                                                  }else{
                                                      success(task,response);
                                                  }
                                          } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                                              failure(task,error);
                                          }];
        return task;
}

//  图片上传
+(NSURLSessionDataTask *)demoImageWith:path
                                params:params
                             imageData:(NSData*)imageData
                              imageKey:(NSString*)imageKey
                               success:(void(^)(NSURLSessionDataTask *task, id responseObject))success
                               failure:(void(^)(NSURLSessionDataTask *task,NSError *error))failure
                                target:(id)target{
    DemoSessionManager *manager = [DemoSessionManager shareInstance];
    
    NSMutableDictionary *mutableDic = [DemoDataModel fullDicOf:params];
    NSLog(@"ske Params:%@",mutableDic);
    if (!mutableDic) {
        failure(nil,nil);
        return nil;
    }
    NSString *urlStr = @"";
    NSURLSessionDataTask *task = [manager POST:urlStr parameters:mutableDic constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        NSString *fileName               = [NSString stringWithFormat:@"%@.jpg", imageKey];
        [formData appendPartWithFileData:imageData name:imageKey fileName:fileName mimeType:@"image/png"];
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (success){
            success(task,responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failure(task,error);
    }];
    
    return task;
    
    
    
}



@end
