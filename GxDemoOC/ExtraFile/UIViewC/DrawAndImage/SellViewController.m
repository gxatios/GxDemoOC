//
//  SellViewController.m
//  ZBarTest
//
//  Created by xin gao on 14-2-24.
//  Copyright (c) 2014年 xin gao. All rights reserved.
//

#import "SellViewController.h"
//预编译变量，设置票的总数量
#define MaxTickets 100

@interface SellViewController ()

@end

@implementation SellViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    //加载辅助的标签栏，只显示内容
    [self addLabel:nil];
    
    //设置标签栏对象的位置
    self.leftLabel = [[UILabel alloc]initWithFrame:CGRectMake(150, 90, 100, 30)];
    self.soldLabel = [[UILabel alloc]initWithFrame:CGRectMake(150, 170, 100, 30)];
    self.currentThreadLabel = [[UILabel alloc]initWithFrame:CGRectMake(150, 250, 100, 30)];
    //设置标签栏对象的背景颜色
    self.leftLabel.backgroundColor = [UIColor lightGrayColor];
    self.soldLabel.backgroundColor = [UIColor lightGrayColor];
    self.currentThreadLabel.backgroundColor = [UIColor lightGrayColor];
    //把标签栏添加到当前的视图中
    [self.view addSubview:self.leftLabel];
    [self.view addSubview:self.soldLabel];
    [self.view addSubview:self.currentThreadLabel];
    
    //初始化成员并赋值
    _leftTickets = MaxTickets;
    _soldTickets = 0;
    _ticketsCondition = [[NSCondition alloc]init];
    
    //创建按钮对象
    UIButton * pButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    //设置按钮的位置
    [pButton setFrame:CGRectMake(80, 340, 180, 40)];
    //为按钮添加标题
    [pButton setTitle:@"开始卖票" forState:UIControlStateNormal];
    //设置按钮的方法，响应方式
    [pButton addTarget:self action:@selector(threadStart:) forControlEvents:UIControlEventTouchUpInside];
    //把按钮添加到当前视图中
    [self.view addSubview:pButton];
}
#pragma mark-------增加辅助标签栏
- (void)addLabel:(id)sender
{
    //初始化标签栏对象对设置位置
    UILabel * pLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 20, 300, 40)];
    UILabel * pLabel1 = [[UILabel alloc]initWithFrame:CGRectMake(10, 80, 120, 50)];
    UILabel * pLabel2 = [[UILabel alloc]initWithFrame:CGRectMake(10, 160, 120, 50)];
    UILabel * pLabel3 = [[UILabel alloc]initWithFrame:CGRectMake(10, 240, 120, 50)];
    //设置标签栏的内容文本
    pLabel.text = @"模拟火车票销售---多线程";
    pLabel1.text = @"剩余票数";
    pLabel2.text = @"售出票数";
    pLabel3.text = @"当前进程";
    //设置标签栏的背景颜色
    pLabel.backgroundColor = [UIColor clearColor];
    pLabel1.backgroundColor = [UIColor clearColor];
    pLabel2.backgroundColor = [UIColor clearColor];
    pLabel3.backgroundColor = [UIColor clearColor];
    //设置标签栏的文本居中
    pLabel.textAlignment = NSTextAlignmentCenter;
    pLabel1.textAlignment = NSTextAlignmentCenter;
    pLabel2.textAlignment = NSTextAlignmentCenter;
    pLabel3.textAlignment = NSTextAlignmentCenter;
    //把标签栏对象添加到视图中
    [self.view addSubview:pLabel];
    [self.view addSubview:pLabel1];
    [self.view addSubview:pLabel2];
    [self.view addSubview:pLabel3];
    //释放创建的对象
}
#pragma mark-------开始卖票，线程开始运行
- (void)threadStart:(id)sender
{
    //初始化子线程，设置子线程的方法
    _firstThread = [[NSThread alloc]initWithTarget:self selector:@selector(sellTickets:) object:nil];
    //设置子线程的名字
    [_firstThread setName:@"thread-1"];
    //??手动开启子线程，必须添加，系统不能自主进行
    [_firstThread start];
    
    _secondThread = [[NSThread alloc]initWithTarget:self selector:@selector(sellTickets:) object:nil];
    [_secondThread setName:@"thread-2"];
    [_secondThread start];
    
    _thridThread = [[NSThread alloc]initWithTarget:self selector:@selector(sellTickets:) object:nil];
    [_thridThread setName:@"thread-3"];
    [_thridThread start];
}
//卖票的方法
- (void)sellTickets:(id)sender
{
    while (YES)
    {
        //??锁定线程，防止同一子线程多次运行，必须有
        [_ticketsCondition lock];
        //判断票是否卖完
        if (_leftTickets > 0)
        {
            //设置线程停止0.1秒
            [NSThread sleepForTimeInterval:0.1];
            //卖票的算法
            _leftTickets--;
            _soldTickets = MaxTickets - _leftTickets;
        }
        else if (_leftTickets == 0)
        {
            NSLog(@"票已经卖完！");
            break;
        }
        //子线程调用主线程更新视图，只有进程能更新视图
        [self performSelectorOnMainThread:@selector(updateMyView:) withObject:[[NSThread currentThread]name] waitUntilDone:YES];
        //输出剩余票数、售出票数、当前线程，可以省略
        NSLog(@"剩余票数:%i售出票数:%i当前线程%@",_leftTickets,_soldTickets,[[NSThread currentThread]name]);
        //线程解锁
        [_ticketsCondition unlock];
    }
}
#pragma mark-------更新界面，进程可以，线程不可以
- (void)updateMyView:(id)sender
{
    //设置标签栏的显示内容
    self.leftLabel.text = [NSString stringWithFormat:@"%i",_leftTickets];
    self.soldLabel.text = [NSString stringWithFormat:@"%i",_soldTickets];
    self.currentThreadLabel.text = (NSString *)sender;
    //判断是否卖完，若卖完则弹出警告框
    if (_leftTickets == 0)
    {
        UIAlertView * pAlertView = [[UIAlertView alloc]initWithTitle:@"温馨提示" message:@"票已经全部售出！" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [pAlertView show];
    }
}


@end
