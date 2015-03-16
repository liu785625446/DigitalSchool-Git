//
//  SystemSettingsViewController.m
//  DigitalSchool
//
//  Created by 刘军林 on 15/1/21.
//  Copyright (c) 2015年 刘军林. All rights reserved.
//

#import "SystemSettingsViewController.h"

@interface SystemSettingsViewController ()

@end

@implementation SystemSettingsViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSData *data = [userDefaults objectForKey:CURRENT_USER];
    
    if (data) {
        _text_array = @[@[@"版本更新",@"用户反馈",@"关于我们"],@[@"退出登入"]];
        _image_array = @[@[@"SystemSettingsScrean.png",@"SystemSettings.png",@"SystemSettingsAbout.png"], @[@"SystemSettingsUser.png"] ];
    }else{
        _text_array = @[@[@"版本更新",@"用户反馈",@"关于我们"]];
        _image_array = @[@[@"SystemSettingsScrean.png",@"SystemSettings.png",@"SystemSettingsAbout.png"] ];
    }
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -
#pragma mark Action

#pragma mark -
#pragma mark UITableViewDelegate
-(NSInteger) numberOfSectionsInTableView:(UITableView *)tableView
{
    return [_text_array count];
}

-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSArray *array = [_text_array objectAtIndex:section];
    return [array count];
}

-(CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44.f;
}

-(CGFloat) tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 10.f;
}

-(CGFloat) tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.1f;
}

-(UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"SystemSettingsCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
    cell.textLabel.font = [UIFont systemFontOfSize:15.];
    cell.textLabel.text = [[_text_array objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
    cell.imageView.image = [UIImage imageNamed:[[_image_array objectAtIndex:indexPath.section] objectAtIndex:indexPath.row]];
    return cell;
}

-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
//    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
//    [cell setSelected:NO animated:YES];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath.section == 0) {
        
    }else {
        [self showMyHUD:@"注销中..."];
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
            [userDefault removeObjectForKey:CURRENT_USER];
            [userDefault synchronize];
            sleep(1);
            dispatch_async(dispatch_get_main_queue(), ^{
                [self showSuccessHUD:@"注销成功"];
                [self.navigationController popViewControllerAnimated:YES];
            });
        });
    }
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
