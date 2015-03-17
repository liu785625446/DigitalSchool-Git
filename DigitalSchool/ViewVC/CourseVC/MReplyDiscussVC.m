//
//  MReplyDiscussVC.m
//  DigitalSchool
//
//  Created by rachel on 15/3/16.
//  Copyright (c) 2015年 刘军林. All rights reserved.
//

#import "MReplyDiscussVC.h"
#import "PLDiscussProcess.h"
#import "PLDiscuss.h"

#import "MReplyDiscussCell.h"

@interface MReplyDiscussVC ()

@property(nonatomic,strong)PLDiscussProcess *discussProcess;
@end

@implementation MReplyDiscussVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = @"评论回复";
    if (self.playType != MPlayVideoTypeActivities)
    {
        UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"BtnBottomNormal0.png"]
                                                                 style:UIBarButtonItemStyleDone
                                                                target:self
                                                                action:@selector(backAction:)];
        self.navigationItem.leftBarButtonItem = item;
    }
    
    CGRect animationR = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    [super creatAnimationIndicator:animationR superView:self.view delegate:self];
    
    self.discussProcess = [[PLDiscussProcess alloc]init];
    
    [self getReplyDiscussList:self.currentPage];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    
}

#pragma mark-UITableViewDataSource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.baseArray.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MReplyDiscussCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ReplyDiscussIdentifier" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    PLDiscuss *peplyDis = [self.baseArray objectAtIndex:indexPath.row];
    [cell.iconImg setImageWithURL:[NSURL URLWithString:peplyDis.pluser.userImg]
                 placeholderImage:[UIImage imageNamed:@"ActivitiesInfoHead1.png"]];
    cell.contentLabel.text = peplyDis.discussContent;
    cell.timeLabel.text = peplyDis.discussCreateTime;
    cell.nikeLabel.text = peplyDis.pluser.userNickName;
    
    return cell;
}
#pragma mark -UITableViewDelegate
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    PLDiscuss *peplyDis = [self.baseArray objectAtIndex:indexPath.row];
    CGSize maxSize = [MTool boundingRectWithSizeWithText:peplyDis.discussContent
                                                 MaxSize:CGSizeMake(250, 10000)
                                                textFont:[UIFont systemFontOfSize:14]];
    float contenH = (maxSize.height - 20);
    
    return 72+(contenH>0?contenH:0);
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark - Navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 
}
#pragma mark- RefreshViewDelegate
// 开始进入刷新状态就会调用
-(void)refreshViewBeginRefreshing:(MJRefreshBaseView *)refreshView
{
    [self getReplyDiscussList:self.currentPage];
}

#pragma mark- YYAnimationDelegate
-(void)didReloadData:(YYAnimationIndicator *)animationView
{
    [self getReplyDiscussList:self.currentPage];
}

#pragma mark- 获取数据
-(void)getReplyDiscussList:(int)mCurrentPage
{
    if (mCurrentPage == 1)
    {
        [super startAnimationIndicator];
    }
    
    if (self.playType == MPlayVideoTypeActivities)
    {
        
        [self.discussProcess getActivitiesReplyDiscussList:MPageSize
                                            didCurrentPage:mCurrentPage
                                              didDiscussId:self.discussId
                                                didSuccess:^(NSMutableArray *array)
        {
            [super indicatorDataAnalysisSuccess:array page:mCurrentPage];
        } didFail:^(NSString *error) {
            [super indicatorDataAnalysisFailure:mCurrentPage];
        }];
        
    }else
    {
        [self.discussProcess getReplyDiscussList:MPageSize
                                  didCurrentPage:mCurrentPage
                                    didDiscussId:self.discussId
                                didPlayVideoType:self.playType
                                      didSuccess:^(NSMutableArray *array)
         {
             [super indicatorDataAnalysisSuccess:array page:mCurrentPage];
             
         } didFail:^(NSString *error) {
             [super indicatorDataAnalysisFailure:mCurrentPage];
         }];
    }
    
    
}

#pragma mark-返回
-(void)backAction:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
