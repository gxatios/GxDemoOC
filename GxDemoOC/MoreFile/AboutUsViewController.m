//
//  AboutUsViewController.m
//  GxDemoOC
//
//  Created by GaoX on 2017/9/23.
//  Copyright © 2017年 gx. All rights reserved.
//

#import "AboutUsViewController.h"

@interface AboutUsViewController ()
@property (weak, nonatomic) IBOutlet UIWebView *mainWebView;

@end

@implementation AboutUsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"关于我们";
    // Do any additional setup after loading the view.
//    NSString *urlStr = @"http://www.baidu.com";
//    [self.mainWebView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:urlStr]]];
//    self.edgesForExtendedLayout = NO;
    [self aboutRequest];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)aboutRequest
{
    NSMutableDictionary *dicOne = [[NSMutableDictionary alloc] init];
    [dicOne setValue:@"" forKey:@"opt"];
    [RequestHttp requestPOSTWithDic:dicOne requestSuccess:^(id result) {
        NSString *error = [NSString stringWithFormat:@"%@",result[@"error"]];
        if ([error isEqualToString:@"1"]) {
            // success
            NSDictionary *dataDic = result[@"aboutUs"];
            NSString *resultStr = [NSString stringWithFormat:@"%@",dataDic[@"content"]];
            [self.mainWebView loadHTMLString:resultStr baseURL:nil];
            NSLog(@"..");
        }
    } requestFailure:^{
        [MacroMethodObject showFailHudinWindow];
    }];
}
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{
    NSString *urlStr = [request.URL absoluteString];
    if ([urlStr containsString:@"http"] || [urlStr containsString:@"www"]) {
        return NO;
    }
    return YES;
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
