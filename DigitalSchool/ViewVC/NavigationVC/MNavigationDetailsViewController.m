//
//  MNavigationDetailsViewController.m
//  DigitalSchool
//
//  Created by 刘军林 on 15/3/10.
//  Copyright (c) 2015年 刘军林. All rights reserved.
//

#import "MNavigationDetailsViewController.h"
#import "PLCourseProcess.h"
#import "MCourseCell.h"

@interface MNavigationDetailsViewController ()

@end

@implementation MNavigationDetailsViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.tabBarController.automaticallyAdjustsScrollViewInsets = YES;
    self.baseTableView.backgroundColor = self.view.backgroundColor;
    
    PLCourseProcess *courseProcess = [[PLCourseProcess alloc] init];
    self.title = _titleStr;
    [courseProcess getCourseFilter:10
                    didCurrentPage:1
                          didGrade:0
                        didSubject:0
                        didTeacher:0
                           didType:0
                        didSuccess:^(NSMutableArray *array)
     {
        _course_list = array;
        [self.baseTableView reloadData];
         
    } didFail:^(NSString *error) {
        
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSInteger) numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_course_list count];
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.1;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 10;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 90;
}

-(UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdectifier = @"CourseIdentifierCell";
    MCourseCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdectifier];
    if (!cell)
    {
        cell = [[[NSBundle mainBundle]loadNibNamed:@"MCourseCell" owner:self options:nil] firstObject];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.backgroundColor = [UIColor colorWithHexString:MListBarkGroundColor alpha:1];
    }
    PLCourse *course = [_course_list objectAtIndex:indexPath.row];
    [cell setBaseModel:course];
    return cell;
}

-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}


@end
