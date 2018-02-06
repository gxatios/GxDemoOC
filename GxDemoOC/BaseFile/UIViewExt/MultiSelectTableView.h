//
//  MultiSelectTableView.h
//  GxDemoOC
//
//  Created by Gx on 2017/9/3.
//  Copyright © 2017年 gx. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^BlockMultiSelectTV)(NSInteger row);


@interface MultiSelectTableView : UIView <UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, copy) BlockMultiSelectTV blockSelect;
@property (nonatomic, strong) UITableView *listTableView;
@property (nonatomic, strong) NSArray *listDataArray; //dic： nameStr,codeStr

- (id)initWithFrame:(CGRect)frame dataArray:(NSArray *)data;
@end
