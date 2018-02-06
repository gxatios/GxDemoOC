//
//  PaperViewController.m
//  GxDemoOC
//
//  Created by Gx on 2017/8/29.
//  Copyright © 2017年 gx. All rights reserved.
//

#import "PaperViewController.h"

@interface PaperViewController ()
@property (weak, nonatomic) IBOutlet UITableView *tableVeiw;

@property (nonatomic, copy) NSString *currPage;
@property (nonatomic, strong) NSMutableArray *dataArray;

@end

@implementation PaperViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.leftBarButtonItem = nil;
    self.title = @"资讯";
    // Do any additional setup after loading the view.
    self.dataArray = [[NSMutableArray alloc] init];
    
    self.currPage = @"1";
    self.tableVeiw.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 0.1)];
    self.tableVeiw.tableFooterView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 0.1)];
    self.tableVeiw.mj_header = [MJRefreshGifHeader headerWithRefreshingBlock:^{
        _currPage = @"1";
        [self getPaperRequest:^{
            [_tableVeiw.mj_header endRefreshing];
        }];
    }];
    self.tableVeiw.mj_footer = [MJRefreshAutoGifFooter footerWithRefreshingBlock:^{
        NSInteger currentTablePage = [_currPage intValue];
        currentTablePage += 1;
        _currPage = [NSString stringWithFormat:@"%ld",currentTablePage];
        [self getPaperRequest:^{
            [_tableVeiw.mj_footer endRefreshing];
        }];
    }];
    self.tableVeiw.mj_footer.automaticallyHidden = YES;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];

    [self getPaperRequest:^{}];
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
}
-(void)getPaperRequest:(void(^)(void))finishBlock
{
    NSMutableDictionary *dicOne = [[NSMutableDictionary alloc] init];
    [dicOne setValue:Opt_Paper forKey:@"opt"];
    //    [dicOne setValue:@"post" forKey:@"type"];
    [dicOne setValue:_currPage forKey:@"currPage"];
    [RequestHttp requestPOSTWithDic:dicOne requestSuccess:^(id result) {
        NSString *error = [NSString stringWithFormat:@"%@",result[@"error"]];
        if ([error isEqualToString:@"1"]) {
            // success
            NSDictionary *pageDic = result[@"newsPage"];
            NSArray *pageArray = [NSArray arrayWithArray:pageDic[@"page"]];
            if ([_currPage isEqualToString:@"1"]) {
                [_dataArray removeAllObjects];
            }
            [_dataArray addObjectsFromArray:pageArray];
            [_tableVeiw reloadData];
        }else{
            [MacroMethodObject showHudTextinWindow:result[@"msg"]];
        }
        if (finishBlock) {
            finishBlock();
        }
    } requestFailure:^{
        [MacroMethodObject showFailHudinWindow];
        if (finishBlock) {
            finishBlock();
        }
    }];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellID = @"PaperCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    NSDictionary *dic = _dataArray[indexPath.row];

    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 91;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSDictionary *dic = _dataArray[indexPath.row]; //entityId

}
@end
