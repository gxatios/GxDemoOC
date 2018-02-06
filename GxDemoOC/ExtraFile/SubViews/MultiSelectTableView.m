//
//  MultiSelectTableView.m
//  GxDemoOC
//
//  Created by Gx on 2017/9/3.
//  Copyright © 2017年 gx. All rights reserved.
//

#import "MultiSelectTableView.h"

@implementation MultiSelectTableView

- (id)initWithFrame:(CGRect)frame dataArray:(NSArray *)data
{
    CGRect mainRect = CGRectMake(0, 0, AppWidth, AppHeight);
    self = [super initWithFrame:mainRect];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        self.listDataArray = [[NSMutableArray alloc] initWithArray:data];
        // 基本属性
        self.autoresizingMask = UIViewAutoresizingFlexibleWidth;
        [self buildMainView:frame];
    }
    return self;
}
-(void)buildMainView:(CGRect)frame{
    for (UIView *subView in self.subviews) {
        [subView removeFromSuperview];
    }
    UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
//    bgView.backgroundColor = RGBCOLOR(1, 1, 1, 0.1);
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(bgTap)];
    bgView.userInteractionEnabled = YES;
    [bgView addGestureRecognizer:tap];
    [self addSubview:bgView];
    
    CGFloat tableWidth = 200;
    
    CGRect tvFrame = CGRectMake(frame.origin.x+frame.size.width-tableWidth, frame.origin.y, tableWidth, 200);
    self.listTableView = [[UITableView alloc] initWithFrame:tvFrame style:UITableViewStylePlain];
    self.listTableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 0.1)];
    self.listTableView.delegate = self;
    self.listTableView.dataSource = self;
    self.listTableView.layer.borderWidth = 0.5;
    self.listTableView.layer.borderColor = [UIColor lightGrayColor].CGColor;
    self.listTableView.layer.cornerRadius = 5;
    [self addSubview:_listTableView];
}
-(void)bgTap{
    [self removeFromSuperview];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.listDataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *cellID = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    NSDictionary *dic = self.listDataArray[indexPath.row];
    cell.textLabel.text = dic[@"name"];
    cell.textLabel.textAlignment = NSTextAlignmentCenter;
    cell.textLabel.font = [UIFont systemFontOfSize:13.0f];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 25;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (self.blockSelect) {
        self.blockSelect(indexPath.row);
    }
    [self removeFromSuperview];
}



@end
