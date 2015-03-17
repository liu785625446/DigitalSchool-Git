//
//  AppDelegate.m
//  DigitalScholl
//
//  Created by 刘军林 on 15-1-4.
//  Copyright (c) 2015年 刘军林. All rights reserved.
//

#import "AppDelegate.h"
#import "BLTool.h"
#import "UMFeedback.h"
#import "PLUserProcess.h"
#import "PLUser.h"
#define UMENT_APPKEY @"54fbf719fd98c5ba19000928"

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    [MobClick startWithAppkey:UMENT_APPKEY reportPolicy:BATCH channelId:@""];
    [UMFeedback setAppkey:UMENT_APPKEY];
    [MobClick checkUpdate];
    
    NSString *version = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBoundleShortVersionString"];
    [MobClick setAppVersion:version];
    
    [[UITabBar appearance]setTintColor:[UIColor colorWithHexString:MNavBarBarkGroundColor alpha:1]];
    
    [[UINavigationBar appearance]setBarTintColor:[UIColor colorWithHexString:MTitleColor alpha:1]];
    
    [[UINavigationBar appearance]setTintColor:[UIColor whiteColor]];
    
    [[UINavigationBar appearance]setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];
    
//    NSLog(@"%@",[BLTool getKeyCode:@""]);
    
    [@"aa" stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    //    [[UINavigationBar appearance] setBackgroundColor:[UIColor redColor]];
    [[UINavigationBar appearance] setBarTintColor:[UIColor colorWithHexString:@"06AC41" alpha:0.5]];
    
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    id username = [userDefault objectForKey:REMEMBER_USERNAME];
    id pwd = [userDefault objectForKey:REMEMBER_PASSWORD];
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
       
        if (username && pwd) {
            PLUserProcess *userProcess = [[PLUserProcess alloc] init];
            [userProcess loginUserName:username didPassword:pwd didSuccess:^(NSMutableArray *array) {
                if (array) {
                    id data = [array objectAtIndex:0];
                    if ([data isKindOfClass:[NSDictionary class]]) {
                        
                    }else{
                        [userDefault removeObjectForKey:CURRENT_USER];
                        [userDefault synchronize];
                    }
                }else
                {
                    [userDefault removeObjectForKey:CURRENT_USER];
                    [userDefault synchronize];
                }
            } didFail:^(NSString *error) {
                [userDefault removeObjectForKey:CURRENT_USER];
                [userDefault synchronize];
            }];
        }else{
            [userDefault removeObjectForKey:CURRENT_USER];
            [userDefault synchronize];
        }
        
    });
    
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
