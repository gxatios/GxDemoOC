//
//  NSPredicateViewController.m
//  GXOnlineDemo
//
//  Created by xin gao on 14-2-27.
//  Copyright (c) 2014年 xin gao. All rights reserved.
//

#import "NSPredicateViewController.h"

@interface NSPredicateViewController ()

@end

@implementation NSPredicateViewController

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
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)chooseContainsOne
{
    NSArray *arrayFilter = [NSArray arrayWithObjects:@"pict", @"blackrain", @"ip", nil];
    NSArray *arrayContents = [NSArray arrayWithObjects:@"I am a picture.", @"I am a guy", @"I am gagaga", @"ipad", @"iphone", nil];
//    我想过滤arrayContents的话只要循环 arrayFilter就好了
    int i = 0, count = [arrayFilter count];
    for(i = 0; i < count; i ++)
    {
        NSString *arrayItem = (NSString *)[arrayFilter objectAtIndex:i];
        NSPredicate *filterPredicate = [NSPredicate predicateWithFormat:[NSString stringWithFormat:@"SELF CONTAINS %@", arrayItem]];
        NSLog(@"Filtered array with filter %@, %@", arrayItem, [arrayContents filteredArrayUsingPredicate:filterPredicate]);
    }
}

- (void)chooseContainsTwo
{
    NSArray *arrayFilter = [NSArray arrayWithObjects:@"abc1", @"abc2", nil];
    NSArray *arrayContent = [NSArray arrayWithObjects:@"a1", @"abc1", @"abc4", @"abc2", nil];
    NSPredicate *thePredicate = [NSPredicate predicateWithFormat:@"NOT (SELF in %@)", arrayFilter];
//    [arrayContent filterUsingPredicate:thePredicate];
}


- (void)demoOfMatch
{
    // 获取所有文件
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSString *defaultPath = [[NSBundle mainBundle] resourcePath];
    NSError *error;
    NSArray *directoryContents = [fileManager contentsOfDirectoryAtPath:defaultPath error:&error];
    
//    1. 简单比较
    
    NSString *match1 = @"imagexyz-999.png";
    NSPredicate *predicate1 = [NSPredicate predicateWithFormat:@"SELF == %@", match1];
    NSArray *results1 = [directoryContents filteredArrayUsingPredicate:predicate1];
    
//    2. match里like的用法（类似Sql中的用法）
    NSString *match2 = @"imagexyz*.png";
    NSPredicate *predicate2 = [NSPredicate predicateWithFormat:@"SELF like %@", match2];
    NSArray *results2 = [directoryContents filteredArrayUsingPredicate:predicate2];
    
//    3. 大小写比较
//    ［c］表示忽略大小写，［d］表示忽略重音，可以在一起使用，如下：
    NSString *match3 = @"imagexyz*.png";
    NSPredicate *predicate3 = [NSPredicate predicateWithFormat:@"SELF like[cd] %@", match3];
    NSArray *results3 = [directoryContents filteredArrayUsingPredicate:predicate3];
    
//    4.使用正则
    NSString *match4 = @"imagexyz-\\d{3}\\.png";  //imagexyz－123.png
    NSPredicate *predicate4 = [NSPredicate predicateWithFormat:@"SELF matches %@", match4];
    NSArray *results4 = [directoryContents filteredArrayUsingPredicate:predicate4];
}
@end
