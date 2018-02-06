//
//  MoreViewController.m
//  GxDemoOC
//
//  Created by Gx on 2017/8/29.
//  Copyright © 2017年 gx. All rights reserved.
//

#import "MoreViewController.h"
#import "MoreListCell.h"
#import "LoginViewController.h"
#import "HelpCenterViewController.h"
#import "AboutUsViewController.h"
#import "ContactUsViewController.h"
#import "HorseCalViewController.h"

@interface MoreViewController ()
@property (weak, nonatomic) IBOutlet UITableView *listTV;
@property (weak, nonatomic) IBOutlet UIButton *loginBtn;
@property (nonatomic,strong) NSMutableArray *dataArray;
@property (nonatomic,strong) NSMutableArray *imageArray;
@property (nonatomic,copy) NSString *getVerStr;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *constr_h_tv;

@property (nonatomic,copy) NSString *isNeedUpdate;
@end

@implementation MoreViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"更多";
    self.navigationItem.leftBarButtonItem = nil;
    // Do any additional setup after loading the view.
    _loginBtn.layer.cornerRadius = 5;
    _listTV.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 0.1)];
    _listTV.tableFooterView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 0.1)];
    self.dataArray = [[NSMutableArray alloc] initWithObjects:@"帮助中心",@"关于我们",@"联系我们",@"房贷计算器",@"当前版本", nil];
    self.imageArray = [[NSMutableArray alloc] initWithObjects:@"more_help",@"about",@"contact",@"calculator",@"version", nil];
    BOOL isLogin = [[NSUserDefaults standardUserDefaults] boolForKey:Login_User_IsLogin];
    _constr_h_tv.constant = 50*PhoneScale_all*5;
    if (isLogin) {
        // 登录去退出
        [_loginBtn setTitle:@"退出" forState:UIControlStateNormal];
    }else{
         [_loginBtn setTitle:@"登录" forState:UIControlStateNormal];
    }
    [self moreRequest];
}
-(void)moreRequest
{
    NSMutableDictionary *dicOne = [[NSMutableDictionary alloc] init];
    [dicOne setValue:@"6" forKey:@"opt"];
    [dicOne setValue:@"2" forKey:@"deviceType"];
    [RequestHttp requestPOSTNoHUD:dicOne requestSuccess:^(id result) {
        NSString *error = [NSString stringWithFormat:@"%@",result[@"error"]];
        if ([error isEqualToString:@"1"]) {
            // success
            NSString *appVersion = [NSString stringWithFormat:@"%@",result[@"appVersion"]];
            self.getVerStr = appVersion;
            NSDictionary *infoDic = [[NSBundle mainBundle] infoDictionary];
            NSString *appCurVer = [infoDic objectForKey:@"CFBundleShortVersionString"];
            if (![appVersion isEqualToString:appCurVer]) {
                self.isNeedUpdate = @"1";
            }else{
                self.isNeedUpdate = @"0";
            }
            NSString *basicVersion = [NSString stringWithFormat:@"%@",result[@"basicVersion"]];
            NSString *companyVersion = [NSString stringWithFormat:@"%@",result[@"companyVersion"]];
            [self.listTV reloadData];
        }else{
        }
    } requestFailure:^{
  
    }];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    if ([[NSUserDefaults standardUserDefaults] boolForKey:Login_User_IsLogin]) {
        [_loginBtn setTitle:@"退出" forState:0];
    }else{
        [_loginBtn setTitle:@"登录" forState:0];
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)loginBtnDown:(id)sender {
    BOOL isLogin = [[NSUserDefaults standardUserDefaults] boolForKey:Login_User_IsLogin];
    if (isLogin) {
        [[NSUserDefaults standardUserDefaults] setValue:@"" forKey:Login_User_IsSign];
        [[NSUserDefaults standardUserDefaults] setValue:@"" forKey:Login_User_QrCode];
        [[NSUserDefaults standardUserDefaults] setValue:@"" forKey:Login_User_Score];
        [[NSUserDefaults standardUserDefaults] setValue:@"" forKey:Login_User_CountMsgUnread];
        [[NSUserDefaults standardUserDefaults] setValue:@"" forKey:Login_User_Role]; // 0客户 1 员工
        //            [[NSUserDefaults standardUserDefaults] setValue:sex forKey:Login_User_Sex];
        [[NSUserDefaults standardUserDefaults] setValue:@"" forKey:Login_User_HeadImg];
        [[NSUserDefaults standardUserDefaults] setValue:@"" forKey:Login_User_Id];
        [[NSUserDefaults standardUserDefaults] setValue:@"" forKey:Login_User_Phone];
        [[NSUserDefaults standardUserDefaults] setValue:@"" forKey:Login_User_RealName];
        [[NSUserDefaults standardUserDefaults] setValue:@"" forKey:Login_User_NickName];
        [[NSUserDefaults standardUserDefaults] setValue:@"" forKey:Login_User_Role_Emp];
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:Login_User_IsLogin];
        [[NSUserDefaults standardUserDefaults] synchronize];
        // 退出登录
        [MacroMethodObject showHudTextinWindow:@"退出成功"];
        dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, 1.5 * NSEC_PER_SEC);
        dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
            // Do something...
            [[NSUserDefaults standardUserDefaults] setBool:NO forKey:Login_User_IsLogin];
            [_loginBtn setTitle:@"登录" forState:UIControlStateNormal];        });
        
    }else{
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Login" bundle:nil];
        LoginViewController *lvc = [storyboard instantiateViewControllerWithIdentifier:@"LoginViewController"];
        lvc.hidesBottomBarWhenPushed = YES;
        lvc.loginBlock = ^(){
            [self.tabBarController setSelectedIndex:2];
        };
        UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:lvc];
        [self.navigationController presentViewController:nav animated:YES completion:nil];
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *cellID = @"cell";
    MoreListCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"MoreListCell" owner:nil options:nil] lastObject];
    }
    cell.leftImgV.image = [UIImage imageNamed:self.imageArray[indexPath.row]];
    cell.txtLabel.text = self.dataArray[indexPath.row];
    if (indexPath.row == 4) {
        NSDictionary *infoDic = [[NSBundle mainBundle] infoDictionary];
        NSString *appCurVer = [infoDic objectForKey:@"CFBundleShortVersionString"];
        cell.infoLabel.text = appCurVer;
        
        if ([self.isNeedUpdate isEqualToString:@"1"]) {
            cell.redView.hidden = NO;
        }else{
            cell.redView.hidden = YES;
        }
    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 50*PhoneScale_all;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    switch (indexPath.row) {
        case 0: { // 帮助中心
            UIStoryboard *sB = [UIStoryboard storyboardWithName:@"Home" bundle:nil];
            HelpCenterViewController *vc = [sB instantiateViewControllerWithIdentifier:@"HelpCenterViewController"];
            vc.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:vc animated:YES];
            
        } break;
        case 1: { // 关于我们
            UIStoryboard *sB = [UIStoryboard storyboardWithName:@"Home" bundle:nil];
            AboutUsViewController *vc = [sB instantiateViewControllerWithIdentifier:@"AboutUsViewController"];
            vc.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:vc animated:YES];
            
            
        } break;
        case 2: { // 联系我们
  
            UIStoryboard *sB = [UIStoryboard storyboardWithName:@"Home" bundle:nil];
            ContactUsViewController *vc = [sB instantiateViewControllerWithIdentifier:@"ContactUsViewController"];
            vc.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:vc animated:YES];
            
        } break;
        case 3:{
            UIStoryboard *sB = [UIStoryboard storyboardWithName:@"Home" bundle:nil];
            HorseCalViewController *vc = [sB instantiateViewControllerWithIdentifier:@"HorseCalViewController"];
            vc.hidesBottomBarWhenPushed = YES;
            vc.title = @"房贷计算器";
            vc.showUrlStr = @"http://www.xueyicm.com/";
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        case 4:{ // 当前版本
            if ([self.isNeedUpdate isEqualToString:@"1"]) {
                NSString *showStr = [NSString stringWithFormat:@"当前版本为%@,请到app store下载新版本.",self.getVerStr];
                [MacroMethodObject showHudTextinWindow:showStr];
            }else{
                 [MacroMethodObject showHudTextinWindow:@"已是最新版本."];
            }
        }
            break;
        default:
            break;
    }
}

@end
