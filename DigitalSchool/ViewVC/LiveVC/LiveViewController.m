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

- (void)viewDidLoad
{
    [super viewDidLoad];
    _activityProcess = [[PLActivityProcess alloc] init];
    
    CGRect animationR = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    [super creatAnimationIndicator:animationR superView:self.view delegate:self];
    
    [self getActivityData:self.currentPage];
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
    return [self.baseArray count];
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
    PLActivity *activity = [self.baseArray objectAtIndex:indexPath.row];
    cell.activity = activity;
    return cell;
}

-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self performSegueWithIdentifier:@"ActivitiesInfo" sender:indexPath];
}

#pragma mark- RefreshViewDelegate
// 开始进入刷新状态就会调用
-(void)refreshViewBeginRefreshing:(MJRefreshBaseView *)refreshView
{
    [self getActivityData:self.currentPage];
}

#pragma mark -获取活动列表
-(void)getActivityData:(NSInteger)page
{
    if (page == 1)
    {
        [super startAnimationIndicator];
    }
    [_activityProcess getActivityList:MPageSize
                       didCurrentPage:page
                           didSuccess:^(NSMutableArray *array){
                               
                               [super indicatorDataAnalysisSuccess:array page:page];
                               
                           }didFail:^(NSString *error) {
                               [super indicatorDataAnalysisFailure:page];
                           }];
}


@end
