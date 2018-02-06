//
//  AgreeInfoViewController.m
//  GxDemoOC
//
//  Created by zhxGx on 2017/9/1.
//  Copyright © 2017年 gx. All rights reserved.
//

#import "AgreeInfoViewController.h"

@interface AgreeInfoViewController ()
@property (weak, nonatomic) IBOutlet UIWebView *agreeWebView;
@end

@implementation AgreeInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"用户注册协议";
    [self.agreeWebView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://www.qiandaojia1688.com/h5/allPact.html"]]];
    //http://www.qiandaojia1688.com/h5/allPact.html
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
