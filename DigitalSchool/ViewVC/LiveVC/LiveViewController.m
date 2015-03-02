//
//  LiveViewController.m
//  DigitalScholl
//
//  Created by rachel on 15/1/6.
//  Copyright (c) 2015年 刘军林. All rights reserved.
//

#import "LiveViewController.h"
#import "PLActivityProcess.h"
#import "ActivityCell.h"
#import "PLActivity.h"
#import "ActivitiesInfoViewController.h"

@interface LiveViewController ()

@end

@implementation LiveViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    self.baseTableView.hidden = YES;
    _activityList = [[NSArray alloc] init];
    _activityProcess = [[PLActivityProcess alloc] init];
    
    [_activityProcess getActivityList:10 didCurrentPage:1 didSuccess:^(NSMutableArray *array){
        _activityList = array;
//        self.baseTableView.hidden = NO;
        [self.baseTableView reloadData];
    }didFail:^(NSString *error) {
        
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
        // Dispose of any resources that can be recreated.
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.baseTableView setContentInset:UIEdgeInsetsMake(0, 0, 0, 0)];
    [self.baseTableView setContentOffset:CGPointMake(0, 0)];
}

-(void) viewDidAppear:(BOOL)animated
{
    [self.baseTableView setContentInset:UIEdgeInsetsMake(0, 0, 0, 0)];
    [self.baseTableView setContentOffset:CGPointMake(0, 0)];
}

#pragma mark-
#pragma mark UITableViewDelegate
-(NSInteger) numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_activityList count];
}

-(CGFloat) tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.1f;
}

-(CGFloat ) tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.1f;
}

-(CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return self.baseRect.size.width / 2;
}

-(UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"ActivitiesCell";
    ActivityCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
    PLActivity *activity = [_activityList objectAtIndex:indexPath.row];
    cell.activity = activity;
    return cell;
}

-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self performSegueWithIdentifier:@"ActivitiesInfo" sender:indexPath];
}

-(void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    NSIndexPath *indexPath = (NSIndexPath *)sender;
    if ([segue.identifier isEqualToString:@"ActivitiesInfo"]) {
        ActivitiesInfoViewController *activitiesView = segue.destinationViewController;
        activitiesView.activity = [_activityList objectAtIndex:indexPath.row];
    }
}

@end
