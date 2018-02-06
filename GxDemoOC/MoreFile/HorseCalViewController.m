//
//  HorseCalViewController.m
//  GxDemoOC
//
//  Created by zhxGx on 2017/10/13.
//  Copyright © 2017年 gx. All rights reserved.
//

#import "HorseCalViewController.h"

@interface HorseCalViewController ()
@property (weak, nonatomic) IBOutlet UIWebView *mainWebView;

@end

@implementation HorseCalViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [_mainWebView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.showUrlStr]]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{

    return YES;}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
