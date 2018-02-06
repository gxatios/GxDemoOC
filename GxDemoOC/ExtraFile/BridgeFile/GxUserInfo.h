//
//  GxUserInfo.h
//  GxDemoOC
//
//  Created by zhxGx on 2018/2/6.
//  Copyright © 2018年 gx. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GxUserInfo : NSObject
@property (nonatomic, copy) NSString *token;

+ (instancetype)sharedInstance;
//判断是否登录
- (BOOL)isLogin:(UIViewController *)targe logined:(void (^)(NSString *c))logined;


@end
