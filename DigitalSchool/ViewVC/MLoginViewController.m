//
//  MLoginViewController.m
//  DigitalSchool
//
//  Created by 刘军林 on 15/2/5.
//  Copyright (c) 2015年 刘军林. All rights reserved.
//

#import "MLoginViewController.h"

@interface MLoginViewController ()

@end

@implementation MLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
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
