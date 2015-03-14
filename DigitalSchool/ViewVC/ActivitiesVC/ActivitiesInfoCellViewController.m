//
//  ActivitiesInfoCellViewController.m
//  DigitalSchool
//
//  Created by 刘军林 on 15/1/19.
//  Copyright (c) 2015年 刘军林. All rights reserved.
//

#import "ActivitiesInfoCellViewController.h"
#import "PLWorkProcess.h"
#import "PLDiscussProcess.h"
#import "ActivityWorksCell.h"
#import "ActivityDiscussCell.h"
#import "MCommentViewController.h"
#import "MPlayVideoViewController.h"
//#import "MWorksCell.h"
//#import "MCommentCell.h"

@interface ActivitiesInfoCellViewController ()

@end

@implementation ActivitiesInfoCellViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _discussProcess = [[PLDiscussProcess alloc] init];
    _workProcess = [[PLWorkProcess alloc] init];
    if (_cellStyle ==  ALLCOMMENT) {
        UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"ActivitiesInfoEdit.png"] style:UIBarButtonItemStyleDone target:self action:@selector(commentActivityAction:)];
        self.navigationItem.rightBarButtonItem = item;
    }
    
}


-(void) viewWillAppear:(BOOL)animated
{
    CGRect animationR = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    [super creatAnimationIndicator:animationR superView:self.view delegate:self];
    
    [self getDatas:self.currentPage];

}

-(void) commentActivityAction:(id)sender
{
    [self performSegueWithIdentifier:@"commentActivity" sender:nil];
}

-(void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"commentActivity"]) {
        UINavigationController *nav = segue.destinationViewController;
        MCommentViewController *commentView = [nav.viewControllers objectAtIndex:0];
        commentView.title = MCommentTitle;
        commentView.playVideoType = MPlayVideoTypeActivities;
        commentView.courseId = _styleId;
    }else if ([segue.identifier isEqualToString:@"playWorksIdentifier"]) {
        MPlayVideoViewController *play = segue.destinationViewController;
        play.mPlayVideoType = MPlayVideoTypeWorks;
        play.objectModel = sender;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -
#pragma mark UITableViewDelegate
-(NSInteger) numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.baseArray count];
}

-(CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 99.f;
}

-(UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (_cellStyle == WINNERWORKS) {
        static NSString *cellIdentifier = @"WorksCellIndentifier";
        ActivityWorksCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
        
        PLWorks *works = [self.baseArray objectAtIndex:indexPath.row];
        cell.works = works;
        
        return cell;
    }else if (_cellStyle == ALLWORKS) {
        static NSString *cellIdentifier = @"WorksCellIndentifier";
        ActivityWorksCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
        
        PLWorks *works = [self.baseArray objectAtIndex:indexPath.row];
        cell.works = works;
        return cell;
    }else{
        static NSString *cellIdentifier = @"CommentCellIndentifier";
        ActivityDiscussCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
        
        PLDiscuss *discuss = [self.baseArray objectAtIndex:indexPath.row];
        cell.discuss = discuss;
        
        return cell;
    }
}

-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (_cellStyle == ALLWORKS || _cellStyle == WINNERWORKS) { //作品
        PLWorks *works = [self.baseArray objectAtIndex:indexPath.row];
        [self performSegueWithIdentifier:@"playWorksIdentifier" sender:works];
    }else{ //评论
        
    }
}

#pragma mark- RefreshViewDelegate
// 开始进入刷新状态就会调用
-(void)refreshViewBeginRefreshing:(MJRefreshBaseView *)refreshView
{
    [self getDatas:self.currentPage];
}

-(void)getDatas:(NSInteger)page
{
    
    if (page == 1)
    {
        [self startAnimationIndicator];
    }
    if (_cellStyle == WINNERWORKS)
    {
        self.title = @"获奖作品";
        
        [_workProcess getActivityWorksList:MPageSize didCurrentPage:page didActivityId:_styleId didType:1 didSuccess:^(NSMutableArray *array){
            [super indicatorDataAnalysisSuccess:array page:page];
        }didFail:^(NSString *error) {
            [super indicatorDataAnalysisFailure:page];
        }];
        
    }else if (_cellStyle == ALLWORKS)
    {
        self.title = @"全部作品";
        
        [_workProcess getActivityWorksList:MPageSize didCurrentPage:page didActivityId:_styleId didType:0 didSuccess:^(NSMutableArray *array){
            [super indicatorDataAnalysisSuccess:array page:page];
        }didFail:^(NSString *error) {
            [super indicatorDataAnalysisFailure:page];
        }];
        
    }else if (_cellStyle ==  ALLCOMMENT)
    {
        self.title = @"全部评论";
        [_discussProcess getActivityDiscussList:MPageSize didCurrentPage:page didActivityId:_styleId didSuccess:^(NSMutableArray *array) {
            [super indicatorDataAnalysisSuccess:array page:page];
        } didFail:^(NSString *error) {
            [super indicatorDataAnalysisFailure:page];
        }];
    }
}

@end
