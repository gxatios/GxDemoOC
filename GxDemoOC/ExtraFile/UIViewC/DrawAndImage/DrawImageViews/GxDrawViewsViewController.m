//
//  GxDrawViewsViewController.m
//  GXOnlineDemo
//
//  Created by gaoxin on 14-4-5.
//  Copyright (c) 2014年 xin gao. All rights reserved.
//

#import "GxDrawViewsViewController.h"
#import "transluView.h"
#import "UIView+ImageShot.h"

#define MENUSIZE 150.0f

@interface GxDrawViewsViewController ()
{
    UIView *_backgroundView;
    
}
@end

@implementation GxDrawViewsViewController

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
    UIButton *firBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    firBtn.frame = CGRectMake(20, 370, 60, 40);
    [firBtn setTitle:@"fir" forState:UIControlStateNormal];
    [firBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [firBtn addTarget:self action:@selector(firBtnDown) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:firBtn];
    
    UIButton *secBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    secBtn.frame = CGRectMake(80, 370, 60, 40);
    [secBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [secBtn setTitle:@"sec" forState:UIControlStateNormal];
    [secBtn addTarget:self action:@selector(secBtnDown) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:secBtn];
    
    UIButton *thrBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    thrBtn.frame = CGRectMake(140, 370, 60, 40);
    [thrBtn setTitle:@"thr" forState:UIControlStateNormal];
    [thrBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [thrBtn addTarget:self action:@selector(thrBtnDown) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:thrBtn];
    
    UIButton *fiveBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    fiveBtn.frame = CGRectMake(60, 420, 60, 40);
    [fiveBtn setTitle:@"rote" forState:UIControlStateNormal];
    [fiveBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [fiveBtn addTarget:self action:@selector(fiveBtnDown) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:fiveBtn];
    
    
    // *********** GPU Image ***********
    CGRect deviceSize = [UIScreen mainScreen].bounds;
    

    
    _backgroundView = [[UIView alloc] initWithFrame:CGRectMake(0, -MENUSIZE, deviceSize.size.height, MENUSIZE)];
    [self.view addSubview:_backgroundView];
    
    
}

- (void)firBtnDown
{
    transluView *trView = [[transluView alloc] initWithFrame:CGRectMake(10, 80, 300, 300)];
//    [trView drawRect:CGRectMake(20, 20, 40, 40)];
    [self.view addSubview:trView];
}

- (void)secBtnDown
{
    [self show];
}

- (void)thrBtnDown
{
    
}

- (void)fiveBtnDown
{
    
}


#pragma mark --  --
-(void)show {
//    [self addToParentViewController];
    
    [self updateBlur];
    
    CGRect deviceSize = [UIScreen mainScreen].bounds;
    
    [UIView animateWithDuration:0.25f animations:^(void){

    }];
}

-(void)updateBlur{
    
    
}
#pragma mark -

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
