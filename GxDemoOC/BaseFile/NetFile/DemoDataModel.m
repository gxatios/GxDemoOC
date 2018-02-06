//
//  DemoDataModel.m
//  GxDemoOC
//
//  Created by zhxGx on 2018/2/6.
//  Copyright © 2018年 gx. All rights reserved.
//

#import "DemoDataModel.h"

@implementation DemoDataModel
+ (NSMutableDictionary *)fullDicOf:(NSDictionary *)dic{
    NSMutableDictionary *param = [[NSMutableDictionary alloc] initWithDictionary:dic];
    NSDateFormatter *objDateformat = [[NSDateFormatter alloc] init];
    [objDateformat setDateFormat:@"yyyyMMddHHmmssSSS"];
    //截取到第13位
    NSString *temp = [NSString stringWithFormat:@"%@", [objDateformat stringFromDate:[NSDate date]]];
    //生成七位的随机数
    NSInteger value = (arc4random() % 9999999) + 1000000;
    
    [param setNotValue:temp NotKey:@"timespan"];
    [param setNotValue:[NSString stringWithFormat:@"%@%@", temp, @(value)] NotKey:@"queryid"];
    return param;
}
@end
