//
//  MNavigationDetailsViewController.m
//  DigitalSchool
//
//  Created by 刘军林 on 15/3/10.
//  Copyright (c) 2015年 刘军林. All rights reserved.
//

#import "MNavigationDetailsViewController.h"
#import "MCourseCell.h"

@interface MNavigationDetailsViewController ()
{
//    PLCourseProcess *courseProcess;
}
@end

@implementation MNavigationDetailsViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.tabBarController.automaticallyAdjustsScrollViewInsets = YES;
    self.baseTableView.backgroundColor = self.view.backgroundColor;
    
    _navsProcess = [[PLNavsProcess alloc] init];
    self.title = _navs.navTitle;
    
    [_navsProcess getNavsDatails:10 didCurrentPage:1 didNavId:_navs.navId didSuccess:^(NSMutableArray *array) {
        
    } didFail:^(NSString *error) {
        
    }];
//    [courseProcess getCourseFilter:10
//                    didCurrentPage:1
//                          didGrade:0
//                        didSubject:0
//                        didTeacher:0
//                           didType:0
//                        didSuccess:^(NSMutableArray *array)
//     {
//        _course_list = array;
//        [self.baseTableView reloadData];
//         
//    } didFail:^(NSString *error) {
//        
//    }];
//    courseProcess = [[PLCourseProcess alloc] init];
//    self.title = _titleStr;
    
    CGRect animationR = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    [super creatAnimationIndicator:animationR superView:self.view delegate:self];
    
    [self getData:self.currentPage];
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
    return [self.baseArray count];
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
    PLCourse *course = [self.baseArray objectAtIndex:indexPath.row];
    [cell setBaseModel:course];
    return cell;
}

-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark- RefreshViewDelegate
// 开始进入刷新状态就会调用
-(void)refreshViewBeginRefreshing:(MJRefreshBaseView *)refreshView
{
    [self getData:self.currentPage];
}


-(void)getData:(NSInteger)page
{
    if (page == 1)
    {
        [super startAnimationIndicator];
    }
    
//    [courseProcess getCourseFilter:MPageSize
//                    didCurrentPage:self.currentPage
//                          didGrade:0
//                        didSubject:0
//                        didTeacher:0
//                           didType:0
//                        didSuccess:^(NSMutableArray *array)
//     {
//         [super indicatorDataAnalysisSuccess:array page:page];
//         
//     } didFail:^(NSString *error) {
//         [super indicatorDataAnalysisFailure:page];
//     }];
}


@end
