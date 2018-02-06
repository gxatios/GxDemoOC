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

@interface AppDelegate ()
@property (nonatomic, strong) ZWIntroductionViewController *introductionView;

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    UMConfigInstance.appKey = @"59c9d47307fe651b28000621";
    UMConfigInstance.ePolicy = BATCH;
    [MobClick startWithConfigure:UMConfigInstance];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loginOutMethod) name:Notifi_Login_Out object:nil];
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
                UIStoryboard *sB = [UIStoryboard storyboardWithName:@"Home" bundle:nil];
                UITabBarController *tabBar = [sB instantiateViewControllerWithIdentifier:@"TabBar"];
                weakSelf.window.rootViewController = tabBar;
            }
        };
    }
    
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    
    return YES;
}
- (BOOL)application:(UIApplication *)application shouldAllowExtensionPointIdentifier:(NSString *)extensionPointIdentifier{
    return NO;
}
-(void)loginOutMethod{
    [[NSUserDefaults standardUserDefaults] setBool:NO forKey:Login_User_IsLogin];
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
