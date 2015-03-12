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
{
    PLActivityProcess *activityProcess;
    PLCourseProcess *courseProcess;
}
@end

@implementation MCollectListViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = _collectType == COLLECT_COURSE?@"收藏课程":@"收藏活动";
    
    activityProcess = [[PLActivityProcess alloc] init];
    courseProcess = [[PLCourseProcess alloc] init];
    
    CGRect animationR = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    [super creatAnimationIndicator:animationR superView:self.view delegate:self];
    
    
    [self getCollectData:self.currentPage];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}

#pragma mark
#pragma UITableViewDelegate
-(NSInteger) numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.baseArray count];
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
        PLCollect *collect = [self.baseArray objectAtIndex:indexPath.row];
        [cell setBaseModel:collect.courses];
        return cell;
    }else{
        static NSString *cellIdentifier = @"MActivityCollectCell";
        ActivityCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
        
        PLCollect *collect = [self.baseArray objectAtIndex:indexPath.row];
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
        PLCollect *collect = [self.baseArray objectAtIndex:indexpath.row];
        activity.activity = collect.activitys;
    }else if ([segue.identifier isEqualToString:@"CoursePlayIdentifier"]) {
        MPlayVideoViewController *play = segue.destinationViewController;
        PLCollect *collect = [self.baseArray objectAtIndex:indexpath.row];
        play.objectModel = collect.courses;
    }
}

#pragma mark- RefreshViewDelegate
// 开始进入刷新状态就会调用
-(void)refreshViewBeginRefreshing:(MJRefreshBaseView *)refreshView
{
    [self getCollectData:self.currentPage];
}

-(void)getCollectData:(NSInteger)page
{
    if (![self checkUserLogin]) {
        return;
    }
    
    if (page ==1)
    {
        [super startAnimationIndicator];
    }
    
    if (_collectType == COLLECT_COURSE) {
        
        [courseProcess getAttentionCourse:MPageSize didCurrentPage:page diduserId:@"1" didSuccess:^(NSMutableArray *array) {
            [super indicatorDataAnalysisSuccess:array page:page];
        } didFail:^(NSString *error) {
            [super indicatorDataAnalysisFailure:page];
        }];
    }else if (_collectType == COLLECT_ACTIVITY) {

        [activityProcess  activityAttentions:MPageSize didCurrentPage:page didUserId:@"1" didSuccess:^(NSMutableArray *array) {
            [super indicatorDataAnalysisSuccess:array page:page];
        } didFail:^(NSString *error) {
            [super indicatorDataAnalysisFailure:page];
        }];
    }
}

@end
