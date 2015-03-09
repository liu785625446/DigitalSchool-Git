//
//  RegisterViewController.h
//  DigitalSchool
//
//  Created by 刘军林 on 15/3/8.
//  Copyright (c) 2015年 刘军林. All rights reserved.
//

#import "MBaseViewController.h"
#import "QRadioButton.h"
#import "UIKeyboardViewController.h"

@class PLUserProcess;

@interface MRegisterViewController : MBaseViewController<QRadioButtonDelegate>
{
    int registerType;
}

@property (nonatomic, assign) IBOutlet UITextField *userNameText;
@property (nonatomic, assign) IBOutlet UITextField *nickNameText;
@property (nonatomic, assign) IBOutlet UITextField *pwdText;
@property (nonatomic, assign) IBOutlet UITextField *pwdText1;

@property (nonatomic, assign) IBOutlet UIView *textBackGround;

@property (nonatomic, assign) IBOutlet QRadioButton *radioBut1;
@property (nonatomic, assign) IBOutlet QRadioButton *radioBut2;
@property (nonatomic, assign) IBOutlet QRadioButton *radioBut3;

@property (nonatomic, assign) IBOutlet UIButton *registerBut;
@property (nonatomic, assign) IBOutlet UIButton *cancelBut;

@property (nonatomic, strong) UIKeyboardViewController *keyboard;

@property (nonatomic, strong) PLUserProcess *userProcess;

@end
