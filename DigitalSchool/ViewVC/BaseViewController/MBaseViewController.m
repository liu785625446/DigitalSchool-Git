//
//  MBaseViewController.m
//  DigitalScholl
//
//  Created by rachel on 15/1/6.
//  Copyright (c) 2015年 刘军林. All rights reserved.
//

#import "MBaseViewController.h"
#define KNavColor @"#33B4E4"

@interface MBaseViewController ()

@end

@implementation MBaseViewController
@synthesize baseRect;

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tabBarController.automaticallyAdjustsScrollViewInsets = NO;
    baseRect = [UIScreen mainScreen].bounds;
    self.view.backgroundColor = [UIColor colorWithHexString:MListBarkGroundColor alpha:1];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    if (self.tabBarItem.tag == 1)
    {//课程
        [self creatNavItem:YES];
         self.tabBarController.title = @"";
        
    }else
    {
        
        if (self.tabBarItem.tag ==2)
        {//活动
             self.tabBarController.title = @"活动";
        }else if (self.tabBarItem.tag ==3)
        {//直播
             self.tabBarController.title = @"直播";
        }else
        {//我的信息
             self.tabBarController.title = @"我的资料";
        }
        [self creatNavItem:NO];
    }
}

-(void)creatNavItem:(BOOL)isCreatItem
{
    if (isCreatItem)
    {
        
        UIBarButtonItem *seachItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"MNavItemSearch.png"] style:UIBarButtonItemStyleDone target:self action:@selector(seachAction:)];
        
        UIBarButtonItem *timeItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"MNavItemTime.png"]  style:UIBarButtonItemStyleDone target:self action:@selector(timeAction:)];
        
        UIBarButtonItem *screenItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"MNavItemScreen.png"] style:UIBarButtonItemStyleDone target:self action:@selector(ScreenAction:)];
        
        self.tabBarController.navigationItem.rightBarButtonItems = @[screenItem,timeItem,seachItem];
        
        
        UIBarButtonItem *courseItem = [[UIBarButtonItem alloc]initWithTitle:@"课程首页" style:UIBarButtonItemStyleDone target:nil action:nil];
        self.tabBarController.navigationItem.leftBarButtonItem = courseItem;
    }else
    {
        self.tabBarController.navigationItem.rightBarButtonItems = nil;
        self.tabBarController.navigationItem.leftBarButtonItem = nil;
    }
}

-(void) checkUserLogin
{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
    MLoginViewController *login = [storyboard instantiateViewControllerWithIdentifier:@"LoginIdentifity"];
    [self presentViewController:login animated:YES completion:nil];
}

#pragma mark- Action
-(void)ScreenAction:(id)item
{
    
}
-(void)timeAction:(id)item
{
    
}
-(void)seachAction:(id)item
{
    
}

@end
