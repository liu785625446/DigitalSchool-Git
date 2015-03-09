//
//  MCollectListViewController.m
//  DigitalSchool
//
//  Created by 刘军林 on 15/2/11.
//  Copyright (c) 2015年 刘军林. All rights reserved.
//

#import "MCollectListViewController.h"
#import "PLActivityProcess.h"
#import "PLCourseProcess.h"
#import "PLActivity.h"
#import "PLCourse.h"
#import "MCourseCell.h"
#import "ActivityCell.h"
#import "PLCollect.h"
#import "ActivitiesInfoViewController.h"
#import "MPlayVideoViewController.h"

@interface MCollectListViewController ()

@end

@implementation MCollectListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    PLActivityProcess *activityProcess = [[PLActivityProcess alloc] init];
    PLCourseProcess *courseProcess = [[PLCourseProcess alloc] init];
    
    if (_collectType == COLLECT_COURSE) {
        self.title = @"收藏课程";
        
        if (![self checkUserLogin]) {
            return;
        }
        
        [courseProcess getAttentionCourse:10 didCurrentPage:1 diduserId:@"1" didSuccess:^(NSMutableArray *array) {
            _collect_list = array;
            [self.baseTableView reloadData];
        } didFail:^(NSString *error) {
            
        }];
    }else if (_collectType == COLLECT_ACTIVITY) {
        self.title = @"收藏活动";
        if (![self checkUserLogin]) {
            return;
        }

        [activityProcess  activityAttentions:10 didCurrentPage:1 didUserId:@"1" didSuccess:^(NSMutableArray *array) {
            _collect_list = array;
            [self.baseTableView reloadData];
        } didFail:^(NSString *error) {
            
        }];
    }
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark
#pragma UITableViewDelegate
-(NSInteger) numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_collect_list count];
}

-(CGFloat) tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.1f;
}

-(CGFloat) tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.1f;
}

-(CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (_collectType == COLLECT_COURSE) {
        return 90;
    }else{
        return self.view.frame.size.width/2;
    }
}

-(UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (_collectType == COLLECT_COURSE) {
        static NSString *cellIdectifier = @"CourseIdentifierCell";
        MCourseCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdectifier];
        PLCollect *collect = [_collect_list objectAtIndex:indexPath.row];
        [cell setBaseModel:collect.courses];
        return cell;
    }else{
        static NSString *cellIdentifier = @"MActivityCollectCell";
        ActivityCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
        
        PLCollect *collect = [_collect_list objectAtIndex:indexPath.row];
        [cell setActivity:collect.activitys];
        
        return cell;
    }
}

-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (_collectType == COLLECT_ACTIVITY) {
        [self performSegueWithIdentifier:@"ActivityInfoIdentifier" sender:indexPath];
    }else if (_collectType == COLLECT_COURSE) {
        [self performSegueWithIdentifier:@"CoursePlayIdentifier" sender:indexPath];
    }
}

-(void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    NSIndexPath *indexpath = (NSIndexPath *) sender;
    if ([segue.identifier isEqualToString:@"ActivityInfoIdentifier"]) {
        ActivitiesInfoViewController *activity = segue.destinationViewController;
        PLCollect *collect = [_collect_list objectAtIndex:indexpath.row];
        activity.activity = collect.activitys;
    }else if ([segue.identifier isEqualToString:@"CoursePlayIdentifier"]) {
        MPlayVideoViewController *play = segue.destinationViewController;
        PLCollect *collect = [_collect_list objectAtIndex:indexpath.row];
        play.objectModel = collect.courses;
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
