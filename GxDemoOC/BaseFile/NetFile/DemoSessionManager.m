//
//  DemoSessionManager.m
//  GxDemoOC
//
//  Created by zhxGx on 2018/2/6.
//  Copyright © 2018年 gx. All rights reserved.
//

#import "DemoSessionManager.h"

static int const DemoTimeoutInterval = 7.0;

@implementation DemoSessionManager

static DemoSessionManager *selfInstance = nil;

+(DemoSessionManager *)shareInstance{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        selfInstance = [[self alloc] init];
    });
    return selfInstance;
}


+(id)allocWithZone:(struct _NSZone *)zone{
    if (selfInstance == nil) {
        selfInstance = [super allocWithZone:zone];
    }
    return selfInstance;
}

-(id)copyWithZone:(NSZone *)zone{
    return selfInstance;
}

-(instancetype)init{
    self = [super init];
    if (self) {
        self.responseSerializer = [AFJSONResponseSerializer serializer];
        self.requestSerializer = [AFHTTPRequestSerializer serializer];
        self.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html",@"text/plain", nil,nil];
        [[self requestSerializer] setTimeoutInterval:DemoTimeoutInterval];
        AFSecurityPolicy *securityPolicy = [AFSecurityPolicy defaultPolicy];
        securityPolicy.allowInvalidCertificates = YES; // 允许非法证书抓包
        securityPolicy.validatesDomainName = NO;
        self.securityPolicy = securityPolicy;
    }
    return self;
}



@end
