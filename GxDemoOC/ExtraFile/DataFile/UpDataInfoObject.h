//
//  UpDataInfoObject.h
//  GxDemoOC
//
//  Created by zhxGx on 2017/9/4.
//  Copyright © 2017年 gx. All rights reserved.
//
/*

 */
#import <Foundation/Foundation.h>

@interface UpDataInfoObject : NSObject
@property (nonatomic, copy) NSString *dataStr;
@property (nonatomic, strong) NSDictionary *mainData;

+ (instancetype)sharedInstanceTool;
@end
