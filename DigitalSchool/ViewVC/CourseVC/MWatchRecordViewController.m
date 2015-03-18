//
//  MWatchRecordViewController.m
//  DigitalSchool
//
//  Created by 刘军林 on 15/2/11.
//  Copyright (c) 2015年 刘军林. All rights reserved.
//

#import "MWatchRecordViewController.h"
#import "MWatchRecordCell.h"
#import "PLLookCourse.h"
#import "MPlayVideoViewController.h"

@interface MWatchRecordViewController ()

@end

@implementation MWatchRecordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _courseProcess = [[PLCourseProcess alloc] init];
    _workProcess = [[PLWorkProcess alloc] init];
    
    CGRect animationR = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    [super creatAnimationIndicator:animationR superView:self.view delegate:self];
    
    [self.baseArray addObject:[[NSMutableArray alloc]init]];
    [self.baseArray addObject:[[NSMutableArray alloc]init]];
    
    [self getDatas:_course_works];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark -
-(IBAction)recordSegmentedAction:(id)sender
{
    UISegmentedControl *segmented = (UISegmentedControl *)sender;
    _course_works = segmented.selectedSegmentIndex;
    [[self.baseArray objectAtIndex:_course_works] removeAllObjects];
    [self.baseTableView reloadData];
    [self getDatas:_course_works];
}

#pragma mark UITableViewDelegate
-(NSInteger) numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [[self.baseArray objectAtIndex:_course_works] count];
}

-(CGFloat) tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.1f;
}

-(CGFloat) tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.1f;
}

-(CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50.0f;
}

-(UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"WatchRecordIdentifier";
    MWatchRecordCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
    NSMutableArray *arry = [self.baseArray objectAtIndex:_course_works];
    PLLookCourse *lookCourse = [arry objectAtIndex:indexPath.row];
    cell.object = lookCourse;
    return cell;
}

-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSMutableArray *arry = [self.baseArray objectAtIndex:_course_works];
    PLLookCourse *lookCourse = [arry objectAtIndex:indexPath.row];
    [self performSegueWithIdentifier:@"lookPlayIdentifier" sender:lookCourse];
}

-(void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    PLLookCourse *lookCourse = (PLLookCourse *)sender;
    if ([segue.identifier isEqualToString:@"lookPlayIdentifier"]) {
        MPlayVideoViewController *play = segue.destinationViewController;
        if (_course_works == 0) {
            play.objectModel = lookCourse.courses;
            play.mPlayVideoType = MPlayVideoTypeCourse;
        }else if (_course_works == 1) {
            play.objectModel = lookCourse.works;
            play.mPlayVideoType = MPlayVideoTypeWorks;
        }
    }
}
-(void)getDatas:(NSInteger)index
{
     [super startAnimationIndicator];
    
    if (index == 0)
    {
        [_courseProcess getCourseLookRecord:@"1"
                                 didSuccess:^(NSMutableArray *array)
        {
            NSMutableArray *arr = [self.baseArray objectAtIndex:index];
            [arr setArray:array];
            if (array.count<=0)
            {
                [self stopAnimationIndicatorLoadText:YYNOTDATATEXT withType:NO];
            }else
            {
                [self stopAnimationIndicatorLoadText:@"加载成功!" withType:YES];
            }
            [self.baseTableView reloadData];
            
        } didFail:^(NSString *error)
         {
             [super indicatorDataAnalysisFailure:1];
         }];
        
    }else{
        
        [_workProcess getWorksLookRecord:@"1"
                              didSuccess:^(NSMutableArray *array)
         {
             NSMutableArray *arr = [self.baseArray objectAtIndex:index];
             [arr setArray:array];
             if (array.count<=0)
             {
                 [self stopAnimationIndicatorLoadText:YYNOTDATATEXT withType:NO];
             }else
             {
                 [self stopAnimationIndicatorLoadText:@"加载成功!" withType:YES];
             }
             [self.baseTableView reloadData];
             
         } didFail:^(NSString *error)
         {
             [super indicatorDataAnalysisFailure:1];
         }];
    }

}

#pragma mark- YYAnimationDelegate
-(void)didReloadData:(YYAnimationIndicator *)animationView
{
    [self getDatas:_course_works];
}

@end
