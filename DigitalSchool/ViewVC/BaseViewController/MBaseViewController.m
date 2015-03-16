//
//  MBaseViewController.m
//  DigitalScholl
//
//  Created by rachel on 15/1/6.
//  Copyright (c) 2015年 刘军林. All rights reserved.
//

#import "MBaseViewController.h"
#import "PLUser.h"
#define KNavColor @"#33B4E4"

@interface MBaseViewController ()

@end

static BOOL isHUD = NO;

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
        }else if(self.tabBarItem.tag == 4)
        {//我的信息
             self.tabBarController.title = @"个人中心";
        }else
        {
            self.tabBarController.title = @"导航";
        }
        [self creatNavItem:NO];
    }
}

-(void) showMyHUD:(NSString *)msg
{
    isHUD = YES;
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        sleep(10);
        dispatch_async(dispatch_get_main_queue(), ^{
            if (isHUD) {
                [self showFailHUD:@"连接失败!"];
            }
        });
    });
    [SVProgressHUD showWithStatus:msg maskType:SVProgressHUDMaskTypeBlack];
}

-(void) showSuccessHUD:(NSString *)msg
{
    isHUD = NO;
    [SVProgressHUD dismissWithSuccess:msg afterDelay:1.0];
}

-(void) showFailHUD:(NSString *)msg
{
    isHUD = NO;
    [SVProgressHUD dismissWithError:msg afterDelay:1.0];
}

-(void) hideMyHUD
{
    isHUD = NO;
    [SVProgressHUD dismiss];
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

-(BOOL) checkUserLogin
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSData *userData = [userDefaults objectForKey:CURRENT_USER];
    if (!userData) {
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
        MLoginViewController *login = [storyboard instantiateViewControllerWithIdentifier:@"LoginIdentifity"];
        [self presentViewController:login animated:YES completion:nil];
        return NO;
    }
    return YES;
}

-(NSString *)getUserId
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSData *userData = [userDefaults objectForKey:CURRENT_USER];
    if (userData) {
        PLUser *user = [NSKeyedUnarchiver unarchiveObjectWithData:userData];
        return user.userId;
    }
    return @"";
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
