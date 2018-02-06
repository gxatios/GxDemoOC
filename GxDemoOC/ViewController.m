//
//  ViewController.m
//  GxDemoOC
//
//  Created by zhxGx on 2017/8/21.
//  Copyright © 2017年 gx. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    NSString *testStr = Login_User_Phone;
    NSLog(@"%@",testStr);
    [self getSiftFirstrequest];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)getSiftFirstrequest
{
    NSMutableDictionary *dicOne = [[NSMutableDictionary alloc] init];
    [dicOne setValue:@"8" forKey:@"opt"];
    [RequestHttp requestPOSTWithDic:dicOne requestSuccess:^(id result) {
        NSLog(@"...");
        NSLog(result);
        
    } requestFailure:^{
        
    }];
}
@end
