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
    
    _text_array = @[@[@"清除缓存"],@[@"版本更新",@"意见更新",@"关于我们"],@[@"退出登入"]];
    _image_array = @[ @[@"SystemSettingsClear.png"], @[@"SystemSettingsScrean.png",@"SystemSettings.png",@"SystemSettingsAbout.png"], @[@"SystemSettingsUser.png"] ];
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
