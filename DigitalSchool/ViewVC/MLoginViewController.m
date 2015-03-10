//
//  MLoginViewController.m
//  DigitalSchool
//
//  Created by 刘军林 on 15/2/5.
//  Copyright (c) 2015年 刘军林. All rights reserved.
//

#import "MLoginViewController.h"
#import "PLUser.h"

@interface MLoginViewController ()

@end

@implementation MLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _userProcess = [[PLUserProcess alloc] init];
    
    _backgroundImg.layer.cornerRadius = 3.0;
    _backgroundImg.layer.borderColor = [[UIColor lightGrayColor] CGColor];
    _backgroundImg.layer.borderWidth = 1.f;
    
    [_loginBut setImage:[UIImage imageNamed:@"loginBut_select.png"] forState:UIControlStateHighlighted];
    [_visitorsBut setImage:[UIImage imageNamed:@"visitorsBut_select.png"] forState:UIControlStateHighlighted];
    [_registerBut setImage:[UIImage imageNamed:@"registerBut_select.png"] forState:UIControlStateHighlighted];
    
    [_registerBut setImage:[UIImage imageNamed:@""] forState:UIControlStateSelected];
}

-(void) viewDidAppear:(BOOL)animated
{
    _keyboard = [[UIKeyboardViewController alloc] initWithControllerDelegate:self];
}

-(IBAction)visitorsActoin:(id)sender
{
//    [self performSegueWithIdentifier:@"LoginSuccess" sender:nil];
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(IBAction)loginAction:(id)sender
{
    if ([_userNameText.text isEqualToString:@""]) {
        [self.view makeToast:@"请输入用户名"];
        return;
    }
    
    if ([_pwdText.text isEqualToString:@""]) {
        [self.view makeToast:@"请输入密码"];
        return;
    }
    
    if ([_pwdText.text length] < 6) {
        [self.view makeToast:@"密码输入错误"];
        return;
    }
    
    [self showMyHUD:@"登入中..."];
    [_userProcess loginUserName:_userNameText.text
                    didPassword:_pwdText.text
                     didSuccess:^(NSMutableArray *array) {
                         if (array) {
                             id data = [array objectAtIndex:0];
                             if ([data isKindOfClass:[NSDictionary class]]) {
                                 PLUser *user = [[PLUser alloc] init];
                                 [user setValuesForKeysWithDictionary:data];
                                 NSUserDefaults *userDeault = [NSUserDefaults standardUserDefaults];
                                 NSData *userData = [NSKeyedArchiver archivedDataWithRootObject:user];
                                 [userDeault setObject:userData forKey:CURRENT_USER];
                                 [userDeault synchronize];
                                 [self showSuccessHUD:@"登入成功"];
                                 [self dismissViewControllerAnimated:YES completion:nil];
                             }else{
                                 [self showFailHUD:@"登入失败"];
                             }
                         }
    } didFail:^(NSString *error) {
        [self showFailHUD:error];
    }];
}

-(IBAction)registerAction:(id)sender
{
    [self performSegueWithIdentifier:@"RegisterIdentifier" sender:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

@end
