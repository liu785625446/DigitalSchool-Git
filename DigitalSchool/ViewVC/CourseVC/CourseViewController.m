//
//  CourseViewController.m
//  DigitalScholl
//
//  Created by rachel on 15/1/6.
//  Copyright (c) 2015年 刘军林. All rights reserved.
//

#import "CourseViewController.h"
#import "MCourseCell.h"

#import "MScreeningViewController.h"
#import "MSearchViewController.h"
#import "MPlayVideoViewController.h"
#import "ActivitiesInfoViewController.h"

#import "PLCourseProcess.h"
#import "PLCourse.h"
#import "PLWorkProcess.h"
#import "PLWorks.h"
#import "PLDiscussProcess.h"

@interface CourseViewController ()
<MMenuViewDelegate,UITableViewDataSource,UITableViewDelegate>
{
    
}
@property(nonatomic,strong)PLCourseProcess *courseProcess;
@property(nonatomic,strong)PLWorkProcess *workProcess;
@property(nonatomic,strong)MMenuView *menuView;
@property(nonatomic,strong)MAdcolumnView *adcolumn;

@end

@implementation CourseViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    self.adcolumn = [[MAdcolumnView alloc]initWithFrame:CGRectMake(0, 64, self.view.frame.size.width, self.view.frame.size.width / 2)];
    [self.view addSubview:self.adcolumn];
    
    
    currentIndex = 0;
    hotCourseCurrentPage = 1;
    activitiesCurrentPage = 1;
    hotActivitiesCurrentPage = 1;
    microCourseCurrentPage = 1;
    datas = [[NSMutableArray alloc]init];
    for (int i =0; i<4; i++)
    {
        [datas addObject:[[NSMutableArray alloc]init]];
    }
    
    titles = [[NSMutableArray alloc]init];
    
    self.courseProcess = [[PLCourseProcess alloc]init];
    self.workProcess = [[PLWorkProcess alloc]init];
    
    [self.courseProcess getMainColumnsTitleList:^(NSMutableArray *array)
    {
        [titles addObjectsFromArray:array];
        
        
        [self creatMenu:array];
        
    } didFail:^(NSString *error) {
        
        
        
    }];
    
    [self.courseProcess getCourseMainImg:^(NSMutableArray *array)
    {
        [self.adcolumn creatAdcolumn:array];
        
    } didFail:^(NSString *error) {
        
    }];
    
    
}

-(void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [MobClick beginLogPageView:MCOURSE_MAIN];
}

-(void) viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    [MobClick endLogPageView:MCOURSE_MAIN];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

-(void)creatMenu:(NSArray *)mTitles
{
    if (self.menuView == nil)
    {
        CGRect menuR = CGRectMake(0, self.adcolumn.frame.origin.y+self.adcolumn.frame.size.height, self.view.frame.size.width,
                                  self.view.frame.size.height-(self.adcolumn.frame.origin.y+self.adcolumn.frame.size.height)-49);
        
        self.menuView = [[MMenuView alloc]initWithFrame:menuR
                                             itemsArray:mTitles
                                              itemWidth:self.view.frame.size.width/4
                                        itemNormalColor:[UIColor colorWithHexString:KNormalColor alpha:1]
                                        itemSelectColor:[UIColor colorWithHexString:KSelctColor alpha:1]
                                          tableDelegate:self
                                        tableDataSource:self
                                             tableStyle:UITableViewStyleGrouped
                                         separatorStyle:UITableViewCellSeparatorStyleNone];
        self.menuView.delegate =self;
        [self.view addSubview:self.menuView];
        
        
        NSDictionary *dic = [mTitles objectAtIndex:currentIndex];
        NSString *_id = [dic objectForKey:@"id"];
        NSString *type = [dic objectForKey:@"type"];
        [self getListData:currentIndex _id:_id type:type];
    }
}

#pragma mark- Action
-(void)ScreenAction:(id)item
{
    [self performSegueWithIdentifier:@"ScreeningIdentifier" sender:nil];
}
-(void)timeAction:(id)item
{
    [self performSegueWithIdentifier:@"WatchRecordIdentifier" sender:nil];
}
-(void)seachAction:(id)item
{
    MSearchViewController *screen = [[MSearchViewController alloc]init];
    screen.navigationItem.hidesBackButton = YES;
    [self.navigationController pushViewController:screen animated:NO];
}

#pragma mark-UITableViewDataSource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSInteger index = tableView.tag-kSubTableViewTag;
    if (datas.count>index)
    {
        return [[datas objectAtIndex:index]count];
    }
    return 0;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdectifier = @"McourseCell";
    MCourseCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdectifier];
    if (!cell)
    {
        cell = [[[NSBundle mainBundle]loadNibNamed:@"MCourseCell" owner:self options:nil] firstObject];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.backgroundColor = [UIColor colorWithHexString:MListBarkGroundColor alpha:1];
    }
    
    NSInteger index = tableView.tag-kSubTableViewTag;
    NSArray *data = [datas objectAtIndex:index];
    NSDictionary *titleDic = [titles objectAtIndex:currentIndex];
    int type = [[titleDic objectForKey:@"type"] intValue];
    if (type == 1)
    {
        //课程
        PLCourse *course = [data objectAtIndex:indexPath.row];
        [self setCell:cell
                title:course.courseName
              content:course.courseContent
                  url:course.courseImgURL];
        
    }else if (type == 2 )
    {
        //活动
        PLActivity *activity =[data objectAtIndex:indexPath.row];
        [self setCell:cell
                title:activity.activityName
              content:activity.activityDetail
                  url:activity.activityImg];
        
    }else
    {
        //作品
        PLWorks *works = [data objectAtIndex:indexPath.row];
        [self setCell:cell title:works.workTitle content:works.workIntro url:works.workImg];
    }
    return cell;
}
-(void)setCell:(MCourseCell *)cell title:(NSString *)title content:(NSString *)content url:(NSString *)url
{
    cell.titleLabel.text  = title;
    cell.contentLabel.text = content;
    [cell.iconImage setImageWithURL:[NSURL URLWithString:url]
                   placeholderImage:[UIImage imageNamed:@"MCourseDefalut.png"]];
}

#pragma mark -UITableViewDelegate
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
    return 92;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary *titleDic = [titles objectAtIndex:currentIndex];
    int type = [[titleDic objectForKey:@"type"] intValue];
    if (type == 2)
    {
        //活动
        [self performSegueWithIdentifier:@"AcitvitiesInfoIdentifier" sender:indexPath];
        
    }else
    {
        //作品、课程
        [self performSegueWithIdentifier:@"PlayIdentifier" sender:indexPath];
    }
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"PlayIdentifier"])
    {
        NSIndexPath *indexPath = sender;
        
        MPlayVideoViewController *mplay = segue.destinationViewController;
        NSArray *objects = [datas objectAtIndex:currentIndex];
        if (currentIndex == 1)
        {
            mplay.mPlayVideoType = MPlayVideoTypeWorks;
        }
        mplay.objectModel = [objects objectAtIndex:indexPath.row];

    }else if ([segue.identifier isEqualToString:@"ScreeningIdentifier"])
    {
        MScreeningViewController *screening = segue.destinationViewController;
        if (currentIndex == 0)
        {
            screening.courseType = currentIndex;
        }
        
        
    }else if ([segue.identifier isEqualToString:@"AcitvitiesInfoIdentifier"])
    {
        NSIndexPath *indexPath = sender;
        ActivitiesInfoViewController *activities = segue.destinationViewController;
        NSArray *objects = [datas objectAtIndex:currentIndex];
        activities.activity = [objects objectAtIndex:indexPath.row];
    }
}

#pragma mark- MMenuViewDelegate
-(void)didMMenuView:(MMenuView *)menuView menuItemTag:(NSInteger)menuItemTag
{
    currentIndex = menuItemTag;
    if ([[datas objectAtIndex:menuItemTag] count]<=0)
    {
        NSDictionary *dic = [titles objectAtIndex:menuItemTag];
        NSString *_id = [dic objectForKey:@"id"];
        NSString *type = [dic objectForKey:@"type"];
        [self getListData:menuItemTag _id:_id type:type];
    }
    
}
-(void)loadDataMenuItemTag:(NSInteger)menuItemTag
{
    NSDictionary *dic = [titles objectAtIndex:menuItemTag];
    NSString *_id = [dic objectForKey:@"id"];
    NSString *type = [dic objectForKey:@"type"];
    [self getListData:menuItemTag _id:_id type:type];
}

#pragma mark- 获取数据
-(void)getListData:(NSInteger)mCurrentIndex _id:(NSString *)_id type:(NSString *)type
{
    NSInteger page = 1;
    if (mCurrentIndex == 0)
    {
        page = hotCourseCurrentPage;
        
    }else if (mCurrentIndex ==1)
    {
        page = activitiesCurrentPage;
        
    }else if (mCurrentIndex == 2)
    {
        page = hotActivitiesCurrentPage;
        
    }else
    {
        page = microCourseCurrentPage;
    }
    if (page == 1)
    {
        [self.menuView startAnimationIndicator:mCurrentIndex];
    }
    
    [self.courseProcess getMainColumnsList:MPageSize
                            didCurrentPage:page
                              didColumnsId:_id
                            didColumnsType:type
                                didSuccess:^(NSMutableArray *array)
     {
         if (page == 1)
         {
             [self.menuView stopAnimationIndicatorLoadText:@"加载成功!"
                                                  withType:YES
                                              mCurentIndex:mCurrentIndex];
         }
         [self combinationDatas:array mCurrentIndex:mCurrentIndex];
         
     } didFail:^(NSString *error) {

         [self courseAndWorksDataFaild:mCurrentIndex];
     }];
}

#pragma mark-  组合数据
-(void)combinationDatas:(NSArray *)array mCurrentIndex:(NSInteger)mCurrentIndex
{
    NSMutableArray *mArray = [datas objectAtIndex:mCurrentIndex];
    
    if (array.count>0)
    {
        if (array.count>=MPageSize)
        {
            [self.menuView creatFootViewRefresh:mCurrentIndex];
        }else
        {
            [self.menuView removeFootViewRefresh:mCurrentIndex];
        }
        
        [mArray addObjectsFromArray:array];
        if (mCurrentIndex == 0)
        {
            hotCourseCurrentPage +=1;
            
        }else if (mCurrentIndex == 1)
        {
            activitiesCurrentPage +=1;
            
        }else if (mCurrentIndex == 2)
        {
            hotActivitiesCurrentPage +=1;
        }else
        {
            microCourseCurrentPage +=1;
        }
        
    }else
    {
        if (mArray.count<=0)
        {
            [self.menuView stopAnimationIndicatorLoadText:@"没有数据!"
                                                 withType:NO
                                             mCurentIndex:mCurrentIndex];
        }else
        {
            [self.menuView removeFootViewRefresh:mCurrentIndex];
        }
    }
    [self.menuView reloadTableView:mCurrentIndex];
}

#pragma mark- 数据解析失败调用
-(void)courseAndWorksDataFaild:(NSInteger)mCurrentIndex
{
    NSInteger page = 1;
    if (mCurrentIndex == 0)
    {
        page = hotCourseCurrentPage;
        
    }else if (mCurrentIndex ==1)
    {
        page = activitiesCurrentPage;
        
    }else if (mCurrentIndex == 2)
    {
        page = hotActivitiesCurrentPage;
        
    }else
    {
        page = microCourseCurrentPage;
    }
    
    if (page == 1)
    {
        [self.menuView stopAnimationIndicatorLoadText:@"加载失败!"
                                             withType:NO
                                         mCurentIndex:mCurrentIndex];
    }else
    {
        [self.menuView menuEndRefreshing:mCurrentIndex];
    }
}

@end
