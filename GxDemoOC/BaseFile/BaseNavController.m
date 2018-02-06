//
//  BaseNavController.m
//  报销兔
//
//  Created by zhxGx on 2017/12/9.
//  Copyright © 2017年 gx. All rights reserved.
//

#import "BaseNavController.h"
#import "ViewController.h"

@interface BaseNavController ()

@end

@implementation BaseNavController

- (void)viewDidLoad {
    [super viewDidLoad];
//    CGMutablePathRef path = CGPathCreateMutable();
//    CGPathAddRect(path, NULL, self.navigationBar.bounds);
//    self.navigationBar.layer.shadowPath = path;
//    CGPathCloseSubpath(path);
//    CGPathRelease(path);
//    self.navigationBar.layer.shadowColor =  [UIColor blackColor].CGColor;
//    self.navigationBar.layer.shadowOffset = CGSizeMake(0, 10);
//    self.navigationBar.layer.shadowRadius = 16;
//    self.navigationBar.layer.shadowOpacity = 0.5;
//    // Default clipsToBounds is YES, will clip off the shadow, so we disable it.
//    self.navigationBar.clipsToBounds = NO;
    
    self.navigationBar.layer.shadowColor = [UIColor grayColor].CGColor;
    //2.设置阴影偏移范围
    self.navigationBar.layer.shadowOffset = CGSizeMake(0, 1);
    //3.设置阴影颜色的透明度
    self.navigationBar.layer.shadowOpacity = 0.2;
    //4.设置阴影半径
    self.navigationBar.layer.shadowRadius = 16;
    //5.设置阴影路径
    self.navigationBar.layer.shadowPath = [UIBezierPath bezierPathWithRect:self.navigationBar.bounds].CGPath;
     self.navigationBar.clipsToBounds = NO;
    
    [self.navigationBar setBarTintColor:[UIColor whiteColor]];
    
}



-(void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated{
    if ([viewController isKindOfClass:[viewController class]]) {
        viewController.hidesBottomBarWhenPushed = NO;
    }else{
        viewController.hidesBottomBarWhenPushed = YES;
    }
    [super pushViewController:viewController animated:animated];
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
