//
//  MyViewController.m
//  GxDemoOC
//
//  Created by Gx on 2017/8/29.
//  Copyright © 2017年 gx. All rights reserved.
//

#import "MyViewController.h"
#import "LoginViewController.h"


@interface MyViewController ()
@property (weak, nonatomic) IBOutlet UITableView *listTV;


@end

@implementation MyViewController
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = YES;
    self.edgesForExtendedLayout = UIRectEdgeTop;
    self.navigationController.navigationBar.translucent = YES;
    self.automaticallyAdjustsScrollViewInsets = NO;
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    self.navigationController.navigationBarHidden = NO;
}

-(void)userDataRequest{
    NSMutableDictionary *dicOne = [[NSMutableDictionary alloc] init];
    NSString *userId = [[NSUserDefaults standardUserDefaults] valueForKey:Login_User_Id];
    [dicOne setValue:@"51" forKey:@"opt"];
    [dicOne setValue:userId forKey:@"userId"];
    [RequestHttp requestPOSTNoHUD:dicOne requestSuccess:^(id result) {
        NSString *error = [NSString stringWithFormat:@"%@",result[@"error"]];
        if ([error isEqualToString:@"1"]) {
           
        }else{
        }
    } requestFailure:^{
        
    }];
}
-(void)listDataInit{
  
    BOOL islogin = [[NSUserDefaults standardUserDefaults] boolForKey:Login_User_IsLogin];
    if (islogin == YES) {
    }else{
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = RGBCOLOR(238, 238, 238, 1);
    self.navigationItem.leftBarButtonItem = nil;
    // Do any additional setup after loading the view.
}

#pragma mark -- btn --


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellID = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 50*PhoneScale_all;
}

-(BOOL)isLoginMethod{
    BOOL islogin = [[NSUserDefaults standardUserDefaults] boolForKey:Login_User_IsLogin];
    if (islogin == YES) {
        return YES;
    }else{
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Login" bundle:nil];
        LoginViewController *lvc = [storyboard instantiateViewControllerWithIdentifier:@"LoginViewController"];
        lvc.hidesBottomBarWhenPushed = YES;
        UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:lvc];
        [self.navigationController presentViewController:nav animated:YES completion:nil];
        return NO;
    }
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (![self isLoginMethod]) {
        return;
    }
}


@end
