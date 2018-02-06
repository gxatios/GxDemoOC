//
//  UpDataInfoObject.m
//  GxDemoOC
//
//  Created by zhxGx on 2017/9/4.
//  Copyright © 2017年 gx. All rights reserved.
//


#import "UpDataInfoObject.h"

@implementation UpDataInfoObject

static UpDataInfoObject *shareSingleton = nil;

+ (instancetype)allocWithZone:(struct _NSZone *)zone{
    @synchronized(self) {
        if (shareSingleton == nil) {
            shareSingleton = [super allocWithZone:zone];
        }
    }
    return shareSingleton;
}
+ (instancetype)sharedInstanceTool{
    @synchronized(self){
        if(shareSingleton == nil){
            shareSingleton = [[self alloc] init];
        }
    }
    return shareSingleton;
}
-(id)copyWithZone:(struct _NSZone *)zone{
    return shareSingleton;
}
-(void)setMainData:(NSDictionary *)mainData{
    _mainData = mainData;
    self.dataStr = @"1";

}

@end
