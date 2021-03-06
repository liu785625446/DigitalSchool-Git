//
//  MyMessageViewController.m
//  DigitalScholl
//
//  Created by rachel on 15/1/6.
//  Copyright (c) 2015年 刘军林. All rights reserved.
//

#import "MyMessageViewController.h"
#import "ActivitiesMessageCell.h"
#import "MyMessageCell.h"
#import "MCollectListViewController.h"

@interface MyMessageViewController ()

@end

@implementation MyMessageViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];

    _titleArray = @[@"",@"意见反馈",@"离线缓存",@"我收藏的课程",@"我收藏的活动",@"一键拨打客服电话"];
    _imageArray = @[@"",@"SystemSettings.png",@"BtnBottomNormal3.png",@"BtnBottomNormal5.png",@"BtnBottomNormal5.png",@"MyRootMenu.png"];
    [self.baseTableView reloadData];
    self.navigationController.navigationBarHidden = YES;
//    [self.baseTableView setContentInset:UIEdgeInsetsMake(0, 0, 0, 0)];
}

-(void) viewDidAppear:(BOOL)animated
{
//    [self.baseTableView setContentInset:UIEdgeInsetsMake(0, 0, 0, 0)];
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    self.navigationController.navigationBarHidden = NO;
}

-(IBAction)settingsAction:(id)sender
{
    [self performSegueWithIdentifier:@"SystemSettings" sender:nil];
}

-(IBAction)myActivitiesAction:(id)sender
{
    [self.tabBarController setSelectedIndex:1];
}

#pragma mark -
#pragma mark UITableViewDelegate
-(NSInteger) numberOfSectionsInTableView:(UITableView *)tableView
{
    return [_titleArray count];
}

-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

-(CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 45.f;
}

-(CGFloat) tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.1;
}

-(CGFloat) tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 10.0f;
}

-(UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        static NSString *cellIdentifier = @"ActivitiesMessageCell";
        ActivitiesMessageCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
        return cell;
    }else{
        static NSString *cellIdentifier = @"MyMessageCell";
        MyMessageCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
        cell.textLabel.font = [UIFont systemFontOfSize:15.f];
        cell.textLabel.text = [_titleArray objectAtIndex:indexPath.section];
        cell.imageView.image = [UIImage imageNamed:[_imageArray objectAtIndex:indexPath.section]];
        return cell;
    }
}

-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    [cell setSelected:NO animated:YES];
    if (indexPath.section == 2) {
        [self performSegueWithIdentifier:@"OfflineCache" sender:nil];
    }else if (indexPath.section == 3){
        [self performSegueWithIdentifier:@"CollectIdentifier" sender:@"0"];
    }else if (indexPath.section == 4){
        [self performSegueWithIdentifier:@"CollectIdentifier" sender:@"1"];
    }else if (indexPath.section == 5) {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"tel://18682048054"]];
    }
}

-(void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"CollectIdentifier"]) {
        MCollectListViewController *collect = segue.destinationViewController;
        NSString *code = (NSString *) sender;
        if ([code isEqualToString:@"0"]) {
            collect.collectType = COLLECT_COURSE;
        }else if ([code isEqualToString:@"1"]){
            collect.collectType = COLLECT_ACTIVITY;
        }
    }
}

@end
