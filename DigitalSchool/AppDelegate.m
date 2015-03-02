//
//  AppDelegate.m
//  DigitalScholl
//
//  Created by 刘军林 on 15-1-4.
//  Copyright (c) 2015年 刘军林. All rights reserved.
//

#import "AppDelegate.h"
#import "BLTool.h"

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    [[UITabBar appearance]setTintColor:[UIColor colorWithHexString:MNavBarBarkGroundColor alpha:1]];
    
    [[UINavigationBar appearance]setBarTintColor:[UIColor colorWithHexString:MTitleColor alpha:1]];
    
    [[UINavigationBar appearance]setTintColor:[UIColor whiteColor]];
    
    [[UINavigationBar appearance]setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];
    
    NSLog(@"%@",[BLTool getKeyCode:@""]);
    
    [@"aa" stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    //    [[UINavigationBar appearance] setBackgroundColor:[UIColor redColor]];
    [[UINavigationBar appearance] setBarTintColor:[UIColor colorWithHexString:@"06AC41" alpha:0.5]];
    //    [[UINavigationBar appearance] setTintColor:[UIColor redColor]];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    
}

@end
