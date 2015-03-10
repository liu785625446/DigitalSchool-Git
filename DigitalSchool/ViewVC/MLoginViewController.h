//
//  MLoginViewController.h
//  DigitalSchool
//
//  Created by 刘军林 on 15/2/5.
//  Copyright (c) 2015年 刘军林. All rights reserved.
//

#import "MBaseViewController.h"
#import "UIKeyboardViewController.h"
#import "PLUserProcess.h"

#define REMEMBER_USERNAME @"remember_username"
#define REMEMBER_PASSWORD @"remember_password"

@class MBaseViewController;

@interface MLoginViewController : MBaseViewController

@property (nonatomic, assign) IBOutlet UIImageView *backgroundImg;

@property (nonatomic, assign) IBOutlet UIButton *loginBut;
@property (nonatomic, assign) IBOutlet UIButton *registerBut;
@property (nonatomic, assign) IBOutlet UIButton *visitorsBut;
@property (nonatomic, assign) IBOutlet UIButton *rememberBut;

@property (nonatomic, assign) IBOutlet UITextField *userNameText;
@property (nonatomic, assign) IBOutlet UITextField *pwdText;

@property (nonatomic, strong) UIKeyboardViewController *keyboard;

@property (nonatomic, strong) PLUserProcess *userProcess;

-(IBAction)visitorsActoin:(id)sender;

@end
