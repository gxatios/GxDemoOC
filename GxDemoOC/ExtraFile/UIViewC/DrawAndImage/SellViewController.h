//
//  SellViewController.h
//  ZBarTest
//
//  Created by xin gao on 14-2-24.
//  Copyright (c) 2014年 xin gao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SellViewController : UIViewController
{

    //声明剩余票数、卖出票数成员名
    int _leftTickets;
    int _soldTickets;
    //声明线程成员名
    NSThread * _firstThread;
    NSThread * _secondThread;
    NSThread * _thridThread;
    //声明线程锁
    NSCondition * _ticketsCondition;
}

//创建标签栏的对象，用来显示剩余票数、卖出票数、当前线程名
@property (retain, nonatomic) UILabel * leftLabel;
@property (retain, nonatomic) UILabel * soldLabel;
@property (retain, nonatomic) UILabel * currentThreadLabel;

@end