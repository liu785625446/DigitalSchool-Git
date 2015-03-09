//
//  MUpdatePwdTableViewController.h
//  DigitalSchool
//
//  Created by 刘军林 on 15/3/9.
//  Copyright (c) 2015年 刘军林. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PLUserProcess.h"
#import "PLUser.h"

@interface MUpdatePwdTableViewController : UITableViewController

@property (nonatomic, assign) IBOutlet UITextField *pwd1;
@property (nonatomic, assign) IBOutlet UITextField *pwd2;
@property (nonatomic, assign) IBOutlet UITextField *pwd3;

@property (nonatomic, strong) PLUserProcess *userProcess;
@property (nonatomic, strong) PLUser *current_user;

-(void) showMyHUD:(NSString *)msg;
-(void) showFailHUD:(NSString *)msg;
-(void) showSuccessHUD:(NSString *)msg;
-(void) hideMyHUD;

@end
