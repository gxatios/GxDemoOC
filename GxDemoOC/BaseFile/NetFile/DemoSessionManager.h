//
//  DemoSessionManager.h
//  GxDemoOC
//
//  Created by zhxGx on 2018/2/6.
//  Copyright © 2018年 gx. All rights reserved.
//

#import "AFHTTPSessionManager.h"

@interface DemoSessionManager : AFHTTPSessionManager
+(DemoSessionManager *)shareInstance;
@end
