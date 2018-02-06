//
//  FunctionsViewController.m
//  GXOnlineDemo
//
//  Created by xin gao on 13-11-20.
//  Copyright (c) 2013年 xin gao. All rights reserved.
//

#import "FunctionsViewController.h"
#import "SellViewController.h"
#import "ScreenCatchViewController.h"
#import "AnimaTryViewController.h"
#import "GxDrawViewsViewController.h"
#import "DrawCircleViewController.h"

@interface FunctionsViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    UITableView *_mainTableView;
    NSArray *_mainDataArray;
}

@end

@implementation FunctionsViewController

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
    
    _mainDataArray = [NSArray arrayWithObjects:@"截图",@"ios7模糊效果",@"多线程",@"动画",@"画圆", nil];
    
    CGRect tableviewRect = CGRectMake(0, 0, 320, self.view.frame.size.height - 90);
    _mainTableView = [[UITableView alloc] initWithFrame:tableviewRect style:UITableViewStylePlain];
    _mainTableView.delegate = self;
    _mainTableView.dataSource = self;
    [self.view addSubview:_mainTableView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



#pragma mark -- tableview --

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _mainDataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIndef = @"cellIndef";
    UITableViewCell *cell = (UITableViewCell*)[tableView dequeueReusableCellWithIdentifier:cellIndef];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIndef];
    }else{
        for(UIView *subView in [cell.contentView subviews]){
            [subView removeFromSuperview];
        }
    }
    cell.textLabel.text = [_mainDataArray objectAtIndex:indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // @"截图",@"ios7模糊效果",@"多线程",@"动画",@"画圆"
    if (indexPath.row == 0) {
        ScreenCatchViewController *vc = [[ScreenCatchViewController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
        
    }
    if (indexPath.row == 1) {
        GxDrawViewsViewController *vc = [[GxDrawViewsViewController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
        
    }
    if (indexPath.row == 2) {
        SellViewController *vc = [[SellViewController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
        //        [self presentViewController:vc animated:YES completion:nil];
    }
    if (indexPath.row == 3) {
        AnimaTryViewController *vc = [[AnimaTryViewController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    }
    if (indexPath.row == 4) {
        DrawCircleViewController *vc = [[DrawCircleViewController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    }
}




#pragma mark --

@end
