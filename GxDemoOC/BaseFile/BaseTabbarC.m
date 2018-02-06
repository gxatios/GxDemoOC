//
//  self.tabBarC.m
//  报销兔
//
//  Created by zhxGx on 2017/12/9.
//  Copyright © 2017年 gx. All rights reserved.
//

#import "BaseTabbarC.h"
#import "BaseNavController.h"
#import "FirstViewC.h"
#import "SecondViewC.h"
#import "ThirdViewC.h"
#import "LoginViewController.h"

@interface BaseTabbarC () <UITabBarDelegate,UITabBarControllerDelegate>

@property (nonatomic, assign)NSInteger oldSelectIndex;


@end

@implementation BaseTabbarC

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (id)init
{
    self = [super init];
    if (self)
    {
       self.tabBar.hidden = YES;

    }
    return self;
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self.view setNeedsLayout];
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.view setNeedsLayout];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tabBar.backgroundColor = [UIColor orangeColor];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(tabIndexAction:) name:Notifi_Tabbar_Index object:nil];
    
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathAddRect(path, NULL, self.tabBar.bounds);
    self.tabBar.layer.shadowPath = path;
    CGPathCloseSubpath(path);
    CGPathRelease(path);
    self.tabBar.layer.shadowColor = [UIColor grayColor].CGColor;
    self.tabBar.layer.shadowOffset = CGSizeMake(0, -1);
    self.tabBar.layer.shadowRadius = 10;
    self.tabBar.layer.shadowOpacity = 0.2;
    
    NSTimer *timer = [NSTimer timerWithTimeInterval:60 target:self selector:@selector(timerAction) userInfo:nil repeats:YES];
    [[NSRunLoop mainRunLoop] addTimer:timer forMode:NSDefaultRunLoopMode];
    
    // Default clipsToBounds is YES, will clip off the shadow, so we disable it.
    self.tabBar.clipsToBounds = NO;
    
    
    // Do any additional setup after loading the view.
    //    ZHXNewHomeViewController *homeVC = [[ZHXNewHomeViewController alloc] init];
    UIStoryboard *firstStoryBoard = [UIStoryboard storyboardWithName:@"first" bundle:nil];
    FirstViewC *first =  [firstStoryBoard instantiateViewControllerWithIdentifier:@"FirstViewC"];
    BaseNavController *oneNav = [[BaseNavController alloc] initWithRootViewController:first];
    UIStoryboard *twoSB = [UIStoryboard storyboardWithName:@"second" bundle:nil];
    SecondViewC *cardVC = [twoSB instantiateViewControllerWithIdentifier:@"SecondViewC"];
    BaseNavController *twodNav = [[BaseNavController alloc] initWithRootViewController:cardVC];
    
    UIStoryboard *threeSB = [UIStoryboard storyboardWithName:@"third" bundle:nil];
    ThirdViewC *threeVC = [threeSB instantiateViewControllerWithIdentifier:@"ThirdViewC"];
    BaseNavController *threeNav = [[BaseNavController alloc] initWithRootViewController:threeVC];

    
    oneNav.tabBarItem = [[UITabBarItem alloc]initWithTitle:@"首页" image:[UIImage imageNamed:@"Group 20"] tag:0];
    oneNav.tabBarItem.selectedImage = [[UIImage imageNamed:@"Group 12"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    twodNav.tabBarItem = [[UITabBarItem alloc]initWithTitle:@"商户" image:[UIImage imageNamed:@"Group 24"] tag:1];
    twodNav.tabBarItem.selectedImage = [[UIImage imageNamed:@"Group 17"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    threeNav.tabBarItem = [[UITabBarItem alloc]initWithTitle:@"我的" image:[UIImage imageNamed:@"Group 25"] tag:2];
    threeNav.tabBarItem.selectedImage = [[UIImage imageNamed:@"Group 18"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    [oneNav.tabBarItem setTitlePositionAdjustment:UIOffsetMake(0, -5)];
    [twodNav.tabBarItem setTitlePositionAdjustment:UIOffsetMake(0, -5)];
    [threeNav.tabBarItem setTitlePositionAdjustment:UIOffsetMake(0, -5)];

    
    if ( ((([UIScreen mainScreen].bounds.size.height) /([UIScreen mainScreen].bounds.size.width))> 2)) {
        CGFloat imageSpace = 5;
        CGFloat imageBtmSpace = -5;
        oneNav.tabBarItem.imageInsets = UIEdgeInsetsMake(6, 0, -6, 0);
        twodNav.tabBarItem.imageInsets = UIEdgeInsetsMake(6, 0, -6, 0);
        threeNav.tabBarItem.imageInsets = UIEdgeInsetsMake(6, 0, -6, 0);

        [oneNav.tabBarItem setTitlePositionAdjustment:UIOffsetMake(0, 6)];
        [twodNav.tabBarItem setTitlePositionAdjustment:UIOffsetMake(0, 6)];
        [threeNav.tabBarItem setTitlePositionAdjustment:UIOffsetMake(0, 6)];

    }

    self.tabBar.tintColor = [UIColor colorWithRed:180/255.0 green:36/255.0 blue:25/255.0 alpha:1];
    self.viewControllers = @[oneNav, twodNav, threeNav];
    self.delegate = self;
}

-(void)timerAction{
    [[NSNotificationCenter defaultCenter] postNotificationName:Notifi_Timer_Tabbar object:nil];
}

- (BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController{
    [[NSNotificationCenter defaultCenter] postNotificationName:Notifi_Timer_Tabbar object:nil];
    if (viewController.tabBarItem.tag == 1){
        NSString *token = [GxUserInfo sharedInstance].token;
        if (!token.length) {
            return [[GxUserInfo sharedInstance] isLogin:tabBarController logined:^(NSString *c) {
                [[NSNotificationCenter defaultCenter] postNotificationName:Notifi_Second_Tab object:@"1"];
                [[NSNotificationCenter defaultCenter] postNotificationName:Notifi_Tabbar_Index object:@(viewController.tabBarItem.tag)];
            }];
        }else{
            [[NSNotificationCenter defaultCenter] postNotificationName:Notifi_Second_Tab object:@"1"];
            return YES;
        }
    }else if(viewController.tabBarItem.tag == 2 ){
        NSString *token = [GxUserInfo sharedInstance].token;
        if (!token.length) {
            return [[GxUserInfo sharedInstance] isLogin:tabBarController logined:^(NSString *c) {
                [[NSNotificationCenter defaultCenter] postNotificationName:Notifi_Tabbar_Index object:@(viewController.tabBarItem.tag)];
            }];
        }else{
            return YES;
        }
    }else{
        return YES;
    }
}

- (void)tabIndexAction:(NSNotification *)notification
{
    NSInteger index = [notification.object integerValue];
    if(index <self.tabBar.items.count){
        self.selectedIndex = index;
    }
}

//#pragma mark --代理
//- (BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController{
//    
//    self.oldSelectIndex = tabBarController.selectedIndex;
//    // 记录之前选择的selectedIndex
//    return YES;
//}
//
//- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController{
//    if (![QFUserInfo sharedInstance].loadToken) {
//       if (self.selectedIndex == 1 || self.selectedIndex == 2 || self.selectedIndex == 4){
//        self.selectedIndex = self.oldSelectIndex;
//        [[QFUserInfo sharedInstance]isLogin:self logined:^(NSString *c) {
//        }];
//        }
//    }
//
//}


@end
