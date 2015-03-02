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
    
    [_courseProcess getCourseLookRecord:@"1" didSuccess:^(NSMutableArray *array) {
        _watchRecord_list = array;
        [self.baseTableView reloadData];
    } didFail:^(NSString *error) {
        
    }];
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -
-(IBAction)recordSegmentedAction:(id)sender
{
    UISegmentedControl *segmented = (UISegmentedControl *)sender;
    _course_works = segmented.selectedSegmentIndex;
    if (_course_works == 0) {
        [_courseProcess getCourseLookRecord:@"1" didSuccess:^(NSMutableArray *array) {
            _watchRecord_list = array;
            [self.baseTableView reloadData];
        } didFail:^(NSString *error) {
            
        }];
    }else{
        [_workProcess getWorksLookRecord:@"1" didSuccess:^(NSMutableArray *array) {
            _watchRecord_list = array;
            [self.baseTableView reloadData];
        } didFail:^(NSString *error) {
            
        }];
    }
}

#pragma mark UITableViewDelegate
-(NSInteger) numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_watchRecord_list count];
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
    
    PLLookCourse *lookCourse = [_watchRecord_list objectAtIndex:indexPath.row];
    cell.object = lookCourse;
    return cell;
}

-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    PLLookCourse *lookCourse = [_watchRecord_list objectAtIndex:indexPath.row];
    [self performSegueWithIdentifier:@"lookPlayIdentifier" sender:lookCourse];
}

-(void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    PLLookCourse *lookCourse = (PLLookCourse *)sender;
    if ([segue.identifier isEqualToString:@"lookPlayIdentifier"]) {
        MPlayVideoViewController *play = segue.destinationViewController;
        if (_course_works == 0) {
            play.objectModel = lookCourse.courses;
        }else if (_course_works == 1) {
            play.objectModel = lookCourse.works;
            play.mPlayVideoType = MPlayVideoTypeWorks;
        }
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
