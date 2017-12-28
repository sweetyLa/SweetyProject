//
//  AppDelegate+Main.m
//  EagleCloud
//
//  Created by    apple on 2017/11/8.
//  Copyright © 2017年 sweety. All rights reserved.
//

#import "AppDelegate+Main.h"
#import "MainTabbarViewController.h"
#import "LoginViewController.h"

@implementation AppDelegate (Main)

- (void)addRootViewController
{
    NSUserDefaults *userD = [NSUserDefaults standardUserDefaults];
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    
    if ([[userD objectForKey:@"login"] isEqualToString:@"login"])
    {
        // tabbar
        MainTabbarViewController * tabBarVC = [[MainTabbarViewController alloc] init];
        self.window.rootViewController = tabBarVC;
        
    }
    else
    {
        
        [INDisplayManager setNavBarDisplay];
        //登录界面
        LoginViewController *login = [[LoginViewController alloc] init];
        BaseNavigationViewController *nav = [[BaseNavigationViewController alloc] initWithRootViewController:login];
        self.window.rootViewController = nav;
        
    }
    [self.window makeKeyAndVisible];
}

@end
