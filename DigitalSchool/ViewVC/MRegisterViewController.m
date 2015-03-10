//
//  RegisterViewController.m
//  DigitalSchool
//
//  Created by 刘军林 on 15/3/8.
//  Copyright (c) 2015年 刘军林. All rights reserved.
//

#import "MRegisterViewController.h"
#import "PLUserProcess.h"
#import "PLUser.h"

@interface MRegisterViewController ()

@end

@implementation MRegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _userProcess = [[PLUserProcess alloc] init];
    
    _textBackGround.layer.cornerRadius = 3.0;
    _textBackGround.layer.borderColor = [[UIColor lightGrayColor] CGColor];
    _textBackGround.layer.borderWidth = 1.f;
    
    registerType = 1;
    
    _radioBut3.groupId = @"RegisterType";
    _radioBut3.delegate = self;
    [_radioBut3 setTitle:@"家长" forState:UIControlStateNormal];
    [_radioBut3 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [_radioBut3 setChecked:YES];
    
    _radioBut2.groupId = @"RegisterType";
    _radioBut2.delegate = self;
    [_radioBut2 setTitle:@"老师" forState:UIControlStateNormal];
    [_radioBut2 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [_radioBut2 setChecked:YES];
    
    _radioBut1.groupId = @"RegisterType";
    _radioBut1.delegate = self;
    [_radioBut1 setTitle:@"学生" forState:UIControlStateNormal];
    [_radioBut1 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [_radioBut1 setChecked:YES];
    
    // Do any additional setup after loading the view.
}

-(void) didSelectedRadioButton:(QRadioButton *)radio groupId:(NSString *)groupId
{
    registerType = radio.tag;
}

-(IBAction)registerAction:(id)sender
{
    if ([_userNameText.text isEqualToString:@""]) {
        [self.view makeToast:@"请输入用户名"];
        return;
    }
    
    if ([_nickNameText.text isEqualToString:@""]) {
        [self.view makeToast:@"请输入昵称"];
        return;
    }
    
    if ([_pwdText.text isEqualToString:@""]) {
        [self.view makeToast:@"请输入密码"];
        return;
    }
    
    if ([_pwdText.text isEqualToString:@""]) {
        [self.view makeToast:@"请输入确认密码"];
        return;
    }
    
    NSString *regex = @"^[0-9a-zA-Z_\u3E00-\u9FA5]{5,20}$";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    if (![pred evaluateWithObject:_userNameText.text]) {
        [self.view makeToast:@"用户名格式错误"];
        return;
    }
    
    if ([_pwdText.text length] < 6) {
        [self.view makeToast:@"密码不能小于六位"];
        return;
    }
    
    if (![_pwdText.text isEqualToString:_pwdText1.text]) {
        [self.view makeToast:@"密码输入不一致"];
        return;
    }
    
    [self showMyHUD:@"注册中..."];
    [_userProcess rigesterUserName:_userNameText.text didPassword:_pwdText.text didNickName:_nickNameText.text didUserType:[NSString stringWithFormat:@"%d",registerType] didSuccess:^(NSMutableArray *array) {
        if (array) {
            id data = [array objectAtIndex:0];
            if ([data isKindOfClass:[NSDictionary class]]) {
                PLUser *user = [[PLUser alloc] init];
                [user setValuesForKeysWithDictionary:data];
                NSUserDefaults *userDeault = [NSUserDefaults standardUserDefaults];
                NSData *userData = [NSKeyedArchiver archivedDataWithRootObject:user];
                [userDeault setObject:userData forKey:CURRENT_USER];
                [userDeault synchronize];
                [self showSuccessHUD:@"注册成功"];
                [self dismissViewControllerAnimated:YES completion:nil];
            }else{
                [self showFailHUD:@"注册失败"];
            }
        }else{
            [self showFailHUD:@"注册失败"];
        }
    } didFail:^(NSString *error) {
        [self showFailHUD:error];
    }];
}

-(IBAction)cancelAction:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void) viewDidAppear:(BOOL)animated
{
    _keyboard = [[UIKeyboardViewController alloc] initWithControllerDelegate:self];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
