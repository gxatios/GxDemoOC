//
//  PopupListViewController.m
//  GxDemoOC
//
//  Created by zhxGx on 2017/10/18.
//  Copyright © 2017年 gx. All rights reserved.
//

#import "PopupListViewController.h"

@interface PopupListViewController ()

@end

@implementation PopupListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 0.1)];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _showDataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if(cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    NSDictionary *dic = self.showDataArray[indexPath.row];
    cell.textLabel.text = dic[@"name"];
    cell.textLabel.textAlignment = NSTextAlignmentCenter;
    cell.textLabel.font = [UIFont systemFontOfSize:13.0f];
    cell.textLabel.textColor = HEXCOLOR(0x333333);
    //    UILabel *showLable = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    //    showLable.textAlignment = NSTextAlignmentCenter;
    //    showLable.text = _showDataArray[indexPath.row];
    //    [cell.contentView addSubview:showLable];
    return cell;
}

-(void)requestList
{
    
}
#pragma mark - Table view delegate

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (self.popupBlock) {
        self.popupBlock(indexPath.row);
    }
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
