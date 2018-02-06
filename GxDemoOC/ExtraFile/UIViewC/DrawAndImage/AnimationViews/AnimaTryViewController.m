//
//  AnimaTryViewController.m
//  GXOnlineDemo
//
//  Created by gaoxin on 14-4-4.
//  Copyright (c) 2014年 xin gao. All rights reserved.
//
/*
 duration为动画持续的时间。
 animations为动画效果的代码块。
 下面是可以设置动画效果的属性：
 
 frame
 bounds
 center
 transform
 alpha
 backgroundColor
 contentStretch
 */

#import "AnimaTryViewController.h"

@interface AnimaTryViewController ()
{
    UIImageView *firstImageView;
    UIImageView *secondImageView;
    UIButton *fouBtn;
    UIButton *rainbowBtn;
    BOOL isOpen;
}
@end

@implementation AnimaTryViewController

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
    firstImageView = [[UIImageView alloc] initWithFrame:CGRectZero];
    secondImageView = [[UIImageView alloc] initWithFrame:CGRectZero];
    firstImageView.image = [UIImage imageNamed:@"wk"];
    secondImageView.image = [UIImage imageNamed:@"wu"];
    [self.view addSubview:firstImageView];
    [self.view addSubview:secondImageView];
    [self thrBtnDown];
    
    UIButton *firBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    firBtn.frame = CGRectMake(20, 320, 60, 40);
    [firBtn setTitle:@"fir" forState:UIControlStateNormal];
    [firBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [firBtn addTarget:self action:@selector(firBtnDown) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:firBtn];
    
    
    UIButton *secBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    secBtn.frame = CGRectMake(80, 320, 60, 40);
    [secBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [secBtn setTitle:@"sec" forState:UIControlStateNormal];
    [secBtn addTarget:self action:@selector(secBtnDown) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:secBtn];
    
    UIButton *thrBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    thrBtn.frame = CGRectMake(140, 320, 60, 40);
    [thrBtn setTitle:@"重置" forState:UIControlStateNormal];
    [thrBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [thrBtn addTarget:self action:@selector(thrBtnDown) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:thrBtn];
    
    fouBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    fouBtn.frame = CGRectMake(200, 320, 60, 40);
    [fouBtn setTitle:@"four" forState:UIControlStateNormal];
    [fouBtn setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
    [fouBtn addTarget:self action:@selector(fouBtnDown) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:fouBtn];
    
    rainbowBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    rainbowBtn.frame = CGRectMake(20, 370, 60, 40);
    [rainbowBtn setTitle:@"five" forState:UIControlStateNormal];
    [rainbowBtn setTitleColor:[UIColor purpleColor] forState:UIControlStateNormal];
    [rainbowBtn addTarget:self action:@selector(sixBtnDown) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:rainbowBtn];
    
    UIButton *fiveBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    fiveBtn.frame = CGRectMake(60, 370, 60, 40);
    [fiveBtn setTitle:@"rote" forState:UIControlStateNormal];
    [fiveBtn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [fiveBtn addTarget:self action:@selector(fiveBtnDown) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:fiveBtn];
}

- (void)fiveBtnDown
{
    [UIView animateKeyframesWithDuration:4 delay:0 options:UIViewKeyframeAnimationOptionCalculationModeLinear animations:^{
        [UIView addKeyframeWithRelativeStartTime:0.0
                                relativeDuration:1/3.0
                                      animations:^{
                                          secondImageView.transform = CGAffineTransformMakeRotation(2.0 * M_PI / 3.0);
                                      }];
        [UIView addKeyframeWithRelativeStartTime:1/3.0
                                relativeDuration:1/3.0
                                      animations:^{
                                          secondImageView.transform = CGAffineTransformMakeRotation(4.0 * M_PI / 3.0);
                                      }];
        [UIView addKeyframeWithRelativeStartTime:2/3.0
                                relativeDuration:1/3.0
                                      animations:^{
                                          secondImageView.transform = CGAffineTransformMakeRotation(0);
                                      }];
    }completion:^(BOOL finish){
        
    }];
}

- (void)sixBtnDown
{
    if (isOpen) {
        [firstImageView setHidden:YES];
    }else {
        [firstImageView setHidden:NO];
    }
    
    [UIView animateWithDuration:.5 animations:^{
        firstImageView.alpha = 1;
        //        self.mainView.transform = CGAffineTransformScale(self.btn.transform, 4.2f, 4.2f);
        firstImageView.frame = CGRectMake(firstImageView.frame.origin.x, firstImageView.frame.origin.y, firstImageView.frame.size.width, firstImageView.frame.size.height+(isOpen ? -290 : 290));
//        self.btn.frame = CGRectMake(self.btn.frame.origin.x,self.btn.frame.origin.y+(isOpen ? -290 : 290), self.btn.frame.size.width, self.btn.frame.size.height);
//        self.view1.frame = CGRectMake(self.view1.frame.origin.x, self.view1.frame.origin.y+(isOpen ? -290 : 290), self.view1.frame.size.width, self.view.frame.size.height);
        firstImageView.alpha=0;
    }completion:^(BOOL finished) {
        //        self.btn.alpha = 1;
        //        self.btn.transform = CGAffineTransformIdentity;
        if (isOpen) {
            [UIView animateWithDuration:.5 animations:^{
                firstImageView.alpha = 1;
            }];
            
        }
    }];
    
    isOpen = !isOpen;
}

- (void)fouBtnDown
{
    fouBtn.enabled = NO;
    void (^animationBlock)() = ^{
        NSArray *rainbowColors = @[[UIColor orangeColor],
                                   [UIColor purpleColor],
                                   [UIColor yellowColor],
                                   [UIColor blueColor],
                                   [UIColor purpleColor],
                                   [UIColor redColor]];
        NSUInteger colorCount = rainbowColors.count;
        for (int i = 0; i < colorCount; i ++) {
            [UIView addKeyframeWithRelativeStartTime:i/(CGFloat)colorCount relativeDuration:1/(CGFloat)colorCount animations:^{
                fouBtn.backgroundColor = rainbowColors[i];
            }];
        }
    };
    
    [UIView animateKeyframesWithDuration:4 delay:0.5 options:UIViewKeyframeAnimationOptionCalculationModeLinear animations:animationBlock completion:^(BOOL finished){
        fouBtn.enabled = YES;
    }];
    fouBtn.backgroundColor = [UIColor clearColor];
}

- (void)thrBtnDown
{
    CGRect imageViewRect = CGRectMake(20, 20, 280, 280);
    firstImageView.frame = imageViewRect;
    secondImageView.frame = imageViewRect;
    
}
- (void)firBtnDown
{
    /*
//    一个视图淡出屏幕，另外一个视图出现的代码：
    completion为动画执行完毕以后执行的代码块
    options为动画执行的选项。可以参考这里
    delay为动画开始执行前等待的时间
    */
    [UIView animateWithDuration:3.0 animations:^{
        firstImageView.alpha = 1.0;
        secondImageView.alpha = 0; }];
    
}

- (void)secBtnDown
{
    [UIView animateWithDuration:2.0
                     animations:^{
        firstImageView.alpha = 0.0;
        secondImageView.alpha = 1.0;
//        firstImageView.center = CGPointMake(500.0, 512.0);
                     }
                     completion:^(BOOL finished){
                         [UIView animateWithDuration:4.0
                                          animations:^{
                                              secondImageView.center = CGPointMake(160, 230);                                       }];
                     }];
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
