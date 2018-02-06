//
//  AppDelegate.m
//  GxDemoOC
//
//  Created by zhxGx on 2017/8/21.
//  Copyright © 2017年 gx. All rights reserved.
//

#import "AppDelegate.h"
#import "ZWIntroductionViewController.h"
#import <UMMobClick/MobClick.h>
#import "LoginViewController.h"
#import "BaseTabbarC.h"
#import "Reachability.h"

@interface AppDelegate ()
@property (nonatomic, strong) ZWIntroductionViewController *introductionView;
@property (nonatomic, strong) Reachability *hostReachability;
@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    UMConfigInstance.appKey = @"";
    UMConfigInstance.ePolicy = BATCH;
    [MobClick startWithConfigure:UMConfigInstance];
     [self reachabilityNet];
    /*退出登录通知*/
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(userLoginOut) name:Notifi_Login_NO object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(timerMethod) name:Notifi_Timer_Tabbar object:nil];
    BOOL isFirstLaunch = [[NSUserDefaults standardUserDefaults] boolForKey:App_Launch_First];
    if (isFirstLaunch == YES) {
        
    }else{
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:App_Launch_First];
        __weak AppDelegate *weakSelf = self;
        NSArray *coverImageNames = [[NSArray alloc] initWithObjects:@"start1.png", @"start2.png", @"start3.png", nil];
        self.introductionView = [[ZWIntroductionViewController alloc] initWithCoverImageNames:coverImageNames backgroundImageNames:coverImageNames];
        
        self.window.rootViewController = self.introductionView;
        self.introductionView.didSelectedEnter = ^(NSInteger tag) {
            if (tag==2) {
                UIStoryboard *sB = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
                UITabBarController *tabBar = [sB instantiateViewControllerWithIdentifier:@"BaseTabbarC"];
                weakSelf.window.rootViewController = tabBar;
            }
        };
    }
    
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    
    return YES;
}
-(void)timerMethod{
    NSString *token = [GxUserInfo sharedInstance].token;
    if (!token.length) {
        NSLog(@"messageNumMethod time: no login");
        UIViewController *rootVC = [UIApplication sharedApplication].keyWindow.rootViewController;
        if ([rootVC isKindOfClass:[BaseTabbarC class]]) {
            BaseTabbarC *tabVC = (BaseTabbarC*)rootVC;
            UIViewController *vc = [tabVC.viewControllers objectAtIndex:2];
        }
    }else{
        
    }
}

-(void)reachabilityNet{
    // 检测指定服务器是否可达
    NSString *remoteHostName = @"www.baidu.com";
    self.hostReachability = [Reachability reachabilityWithHostName:remoteHostName];
    [self.hostReachability startNotifier];
}
- (void)appReachabilityChanged:(NSNotification *)notification{
    Reachability *reach = [notification object];
    if([reach isKindOfClass:[Reachability class]]){
        NetworkStatus status = [reach currentReachabilityStatus];
        // 两种检测:路由与服务器是否可达  三种状态:4g、WiFi、没有联网
        if (reach == self.hostReachability) {
            NSLog(@"hostReachability");
            if ([reach currentReachabilityStatus] == NotReachable) {
                [MacroMethodObject showHudTextinWindow:@"当前无网络连接"];
            } else{
               
            }
        }
        
    }
}
- (BOOL)application:(UIApplication *)application shouldAllowExtensionPointIdentifier:(NSString *)extensionPointIdentifier{
    return NO;
}
-(void)loginOutMethod{
    [[NSUserDefaults standardUserDefaults] setBool:NO forKey:Login_User_IsLogin];
    [GxUserInfo sharedInstance].token = nil;
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Login" bundle:nil];
    LoginViewController *lvc = [storyboard instantiateViewControllerWithIdentifier:@"LoginViewController"];
    lvc.hidesBottomBarWhenPushed = YES;
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:lvc];
    [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:nav animated:YES completion:nil];
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
