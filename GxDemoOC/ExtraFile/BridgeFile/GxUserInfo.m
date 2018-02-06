//
//  GxUserInfo.m
//  GxDemoOC
//
//  Created by zhxGx on 2018/2/6.
//  Copyright © 2018年 gx. All rights reserved.
//

#import "GxUserInfo.h"
#import "LoginViewController.h"
#import "BaseNavController.h"

@implementation GxUserInfo

+ (instancetype)sharedInstance{
    static GxUserInfo *instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[GxUserInfo alloc] init];
    });
    return instance;
}

- (instancetype)init{
    self = [super init];
    if (self) {
        
    }
    return self;
}

- (BOOL)isLogin:(UIViewController *)target logined:(void (^)(NSString *c))logined{
    if(self.token && self.token.length && ![self.token isEqualToString:@"(null)"]){
        if (logined){
            logined(self.token);
        }
        return YES;
    }else{
        if (target){
            UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:@"Login" bundle:nil];
            LoginViewController *loginVC = [storyBoard instantiateViewControllerWithIdentifier:@"LoginViewController"];
            loginVC.title = @"登录";
            loginVC.loginSuccessBlock = ^(NSString *c){
                if (logined){
                    logined(c);
                }
            };
            BaseNavController *nav = [[BaseNavController alloc]initWithRootViewController:loginVC];
            [target presentViewController:nav animated:YES completion:nil];
        }
        return NO;
    }
}


@end
