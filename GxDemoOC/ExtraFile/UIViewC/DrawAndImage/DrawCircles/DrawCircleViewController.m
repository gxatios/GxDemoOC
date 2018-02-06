//
//  DrawCircleViewController.m
//  GXOnlineDemo
//
//  Created by gaoxin on 14-4-8.
//  Copyright (c) 2014年 xin gao. All rights reserved.
//

#import "DrawCircleViewController.h"
#import "DrawCircleView.h"

@interface DrawCircleViewController ()

@end

@implementation DrawCircleViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    DrawCircleView *view = [[DrawCircleView alloc] initWithFrame:CGRectMake(0, 65, 320, self.view.frame.size.height)];
    [self.view addSubview:view];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
