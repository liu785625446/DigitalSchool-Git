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

@interface MRegisterViewController : MBaseViewController<QRadioButtonDelegate>

@property (nonatomic, strong) IBOutlet UITextField *userNameText;
@property (nonatomic, strong) IBOutlet UITextField *nickNameText;
@property (nonatomic, strong) IBOutlet UITextField *pwdText;
@property (nonatomic, strong) IBOutlet UITextField *pwdText1;

@property (nonatomic, strong) IBOutlet UIView *textBackGround;

@property (nonatomic, strong) IBOutlet QRadioButton *radioBut1;
@property (nonatomic, strong) IBOutlet QRadioButton *radioBut2;
@property (nonatomic, strong) IBOutlet QRadioButton *radioBut3;

@property (nonatomic, strong) IBOutlet UIButton *registerBut;
@property (nonatomic, strong) IBOutlet UIButton *cancelBut;

@property (nonatomic, strong) UIKeyboardViewController *keyboard;

@end
