//
//  ScreenCatchViewController.m
//  GXOnlineDemo
//
//  Created by gaoxin on 14-3-14.
//  Copyright (c) 2014年 xin gao. All rights reserved.
//

#import "ScreenCatchViewController.h"
#import "UIView+ScreenShot.h"
//#import "BlurView.h"
#define MENUSIZE 150.0f
@interface ScreenCatchViewController ()
{
  
}
@end

@implementation ScreenCatchViewController

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
    
    [self show];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)updateBlur
{
    UIImage *image = [self.view.superview convertViewToImage];
}
-(void)addToParentViewController{
    if(self.parentViewController == nil){
        UIViewController *parent = [UIApplication sharedApplication].keyWindow.rootViewController;
        
        if([[parent childViewControllers] count] > 0){
            parent = [[parent childViewControllers] lastObject];
        }
        
        [parent addChildViewController:self];
        [parent.view addSubview:self.view];
        [self didMoveToParentViewController:self];
        self.view.frame = CGRectMake(0, 0, self.parentViewController.view.frame.size.height, self.parentViewController.view.frame.size.width);
        
    }
}
- (void)show
{
    [self addToParentViewController];
    [self updateBlur];
    
    CGRect deviceSie = [UIScreen mainScreen].bounds;
    [UIView animateWithDuration:0.25f animations:^(void){
       
        
        
    }];
}

@end
