//
//  HelpCenterViewController.m
//  GxDemoOC
//
//  Created by GaoX on 2017/9/23.
//  Copyright © 2017年 gx. All rights reserved.
//

#import "HelpCenterViewController.h"
#import "HelpCenterCell.h"

@interface HelpCenterViewController ()
@property (weak, nonatomic) IBOutlet UITableView *listTV;
@property (weak, nonatomic) IBOutlet UIWebView *mainWebView;

@property (nonatomic, strong) NSMutableArray *titleArray;
@property (nonatomic, strong) NSMutableArray *infoArray;
@property (nonatomic, strong) NSMutableArray *sctArray;
@end

@implementation HelpCenterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"帮助中心";
    // Do any additional setup after loading the view.
    self.sctArray = [[NSMutableArray alloc] initWithObjects:@"0",@"0",@"0",@"0",@"0",@"0", nil];
    NSString *t1 = @"忘记密码怎么办？";
    NSString *t2 = @"如何修改登录密码？";
    NSString *t3 = @"如何获得积分？";
    NSString *t4 = @"如何申请？";
    NSString *t5 = @"如何预约？";
    NSString *t6 = @"如何查看订单进度？";
    NSString *a1 = @"        点击‘登录’页面中‘忘记密码’，可以通过手机重新进行密码设置。";
    NSString *a2 = @"        APP请点击‘我的’右上角的头像或者下面的‘个人资料’，通过输入原密码进行校验，重新进行登录密码设置。";
    NSString *a3 = @"    APP请点击‘我的’进入个人中心页面，点击‘我的积分’进入积分页面，能查看现在账户总积分以及积分记录；点击‘积分说明’查看获取积分的方法。";
    NSString *a4 = @"    首先，客户必须符合首页的‘房产要求’和‘个人要求’，然后从下面产品选择符合自己条件的产品进行申请，申请后后台会进行审核，可在‘我的’页面中‘我的申请’里查看申请信息和申请进度，当后台审核没通过时，请检查自己填写的信息是否有误，如果正确请联系客服。";
    NSString *a5 = @"    申请通过后在‘申请详情’页面点击我要预约，填写预约时间和地点会出现符合条件的员工，选择员工点击‘预约他’就预约成功，预约成功后可电话确认。如遇特殊情况不能在指点时间赴约可点击取消预约按钮。";
    NSString *a6 = @"    预约时签订合同后，员工会生成订单，客户可在‘我的’页面中点击‘我的订单’查看订单进度，同时当员工发送通知单时需要客户确认通知单。";
    self.titleArray = [[NSMutableArray alloc] initWithObjects:t1,t2,t3,t4,t5,t6, nil];
    self.infoArray = [[NSMutableArray alloc] initWithObjects:a1,a2,a3,a4,a5,a6, nil];
    [self.listTV registerNib:[UINib nibWithNibName:@"HelpCenterCell" bundle:nil] forCellReuseIdentifier:@"HelpCenterCell"];

//    NSString *htmlPath = [[NSBundle mainBundle] pathForResource:@"help" ofType:@"html"];
//    NSURL *url = [NSURL fileURLWithPath:htmlPath];
//    [self.mainWebView loadRequest:[NSURLRequest requestWithURL:url]];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.titleArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellID = @"HelpCenterCell";
    HelpCenterCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID forIndexPath:indexPath];
    if (cell == nil) {
        cell = [[HelpCenterCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    cell.titleLabel.text = self.titleArray[indexPath.row];
    cell.infoLabel.text = self.infoArray[indexPath.row];
    NSString *str = self.sctArray[indexPath.row];
    if ([str isEqualToString:@"0"]) {
        cell.quesImgV.image = [UIImage imageNamed:@"question_off"];
    }else{
        cell.quesImgV.image = [UIImage imageNamed:@"question_on"];
    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *str = self.sctArray[indexPath.row];
    if ([str isEqualToString:@"0"]) {
        return 60;
    }else if ([str isEqualToString:@"1"]) {
        NSString *infoStr = self.infoArray[indexPath.row];
        CGFloat txtWidth = AppWidth - 30;
        UIFont *txtFont = [UIFont systemFontOfSize:14.0f];
        CGSize txtSize = [infoStr boundingRectWithSize:CGSizeMake(txtWidth, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:txtFont} context:nil].size;
        return 60 + txtSize.height+20;
    }
    return 60;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    for (int i = 0; i<_sctArray.count; i++) {
        [_sctArray replaceObjectAtIndex:i withObject:@"0"];
    }
    [_sctArray replaceObjectAtIndex:indexPath.row withObject:@"1"];
    [_listTV reloadData];
}

@end
