//
//  RegisterViewController.m
//  DigitalSchool
//
//  Created by 刘军林 on 15/3/8.
//  Copyright (c) 2015年 刘军林. All rights reserved.
//

#import "MRegisterViewController.h"

@interface MRegisterViewController ()

@end

@implementation MRegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _textBackGround.layer.cornerRadius = 3.0;
    _textBackGround.layer.borderColor = [[UIColor lightGrayColor] CGColor];
    _textBackGround.layer.borderWidth = 1.f;
    
    _radioBut1.groupId = @"RegisterType";
    _radioBut1.delegate = self;
    [_radioBut1 setTitle:@"学生" forState:UIControlStateNormal];
    [_radioBut1 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [_radioBut1 setChecked:YES];
    
    _radioBut2.groupId = @"RegisterType";
    _radioBut2.delegate = self;
    [_radioBut2 setTitle:@"老师" forState:UIControlStateNormal];
    [_radioBut2 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [_radioBut2 setChecked:YES];
    
    _radioBut3.groupId = @"RegisterType";
    _radioBut3.delegate = self;
    [_radioBut3 setTitle:@"家长" forState:UIControlStateNormal];
    [_radioBut3 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [_radioBut3 setChecked:YES];
    
    // Do any additional setup after loading the view.
}

-(void) didSelectedRadioButton:(QRadioButton *)radio groupId:(NSString *)groupId
{
    
}

-(IBAction)registerAction:(id)sender
{
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
