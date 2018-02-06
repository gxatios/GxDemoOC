//
//  BaseViewController.m
//  GxDemoOC
//
//  Created by zhxGx on 2017/8/28.
//  Copyright © 2017年 gx. All rights reserved.
//

#import "BaseViewController.h"
#import <UMMobClick/MobClick.h>

@interface BaseViewController ()

@end

@implementation BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];

    self.navigationController.interactivePopGestureRecognizer.delegate = self;
    [self buildBackItem];
    self.title = @"默认title";
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [MobClick beginLogPageView:[NSString stringWithFormat:@"%@",self.class]];
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.view endEditing:YES];
    [MobClick endLogPageView:[NSString stringWithFormat:@"%@",self.class]];
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    return YES;
}
-(void)buildBackItem{
    UIView *itemView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 70, 45)];
    //    itemView.backgroundColor = [UIColor purpleColor];
    
    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    backBtn.frame = CGRectMake(-5, 12, 22, 22);
    [backBtn setImage:[UIImage imageNamed:@"back_icon"] forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(navBackBtnDown) forControlEvents:UIControlEventTouchUpInside];
    [itemView addSubview:backBtn];
    
    UIBarButtonItem *temporaryBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:itemView];
    itemView.userInteractionEnabled = YES;
    UITapGestureRecognizer *itemTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(navBackBtnDown)];
    [itemView addGestureRecognizer:itemTap];
    [itemView setExclusiveTouch:YES];
    [backBtn setExclusiveTouch:YES];
    self.navigationItem.leftBarButtonItem = temporaryBarButtonItem;
}

-(void)navBackBtnDown
{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)didReceiveMemoryWarning{
    [super didReceiveMemoryWarning];
    NSLog(@"%@ -> 内存警告！  来自 -> %@",[self class],[self title]);
}
- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer{
    //导航的rootViewController关闭右滑返回功能
    if (self.navigationController.viewControllers.count <= 1){
        return NO;
    }
    return YES;
}
-(void)transformView:(NSNotification *)aNSNotification
{
    //获取键盘弹出前的Rect
    NSValue *keyBoardBeginBounds=[[aNSNotification userInfo]objectForKey:UIKeyboardFrameBeginUserInfoKey];
    CGRect beginRect=[keyBoardBeginBounds CGRectValue];
    //获取键盘弹出后的Rect
    NSValue *keyBoardEndBounds=[[aNSNotification userInfo]objectForKey:UIKeyboardFrameEndUserInfoKey];
    CGRect  endRect=[keyBoardEndBounds CGRectValue];
    
    //获取键盘位置变化前后纵坐标Y的变化值
    CGFloat deltaY=endRect.origin.y-beginRect.origin.y;
    NSLog(@"看看这个变化的Y值:%f",deltaY);
    
    //在0.25s内完成self.view的Frame的变化，等于是给self.view添加一个向上移动deltaY的动画
    [UIView animateWithDuration:0.25f animations:^{
        [self.view setFrame:CGRectMake(self.view.frame.origin.x, self.view.frame.origin.y+deltaY, self.view.frame.size.width, self.view.frame.size.height)];
    }];
}
-(void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
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
