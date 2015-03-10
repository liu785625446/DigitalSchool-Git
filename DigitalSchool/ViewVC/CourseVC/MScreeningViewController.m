//
//  MScreeningViewController.m
//  DigitalScholl
//
//  Created by rachel on 15/1/14.
//  Copyright (c) 2015年 刘军林. All rights reserved.
//

#import "MScreeningViewController.h"

#import "MScreeningMenu.h"

#import "MCourseCell.h"
#import "MPlayVideoViewController.h"

#import "PLCourseProcess.h"

@interface MScreeningViewController ()
<MScreeningMenuDelegate>
{
    
}
@property(nonatomic,strong)PLCourseProcess *courseProcess;
@property(nonatomic,strong)MScreeningMenu *menu;
@property(nonatomic,strong)NSMutableArray *screenItems;//用来存取筛选条件的数组

@end

@implementation MScreeningViewController
@synthesize courseType = _courseType;

-(id)initWithCoder:(NSCoder *)aDecoder
{
   self = [super initWithCoder:aDecoder];
    if (self)
    {
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    self.title = @"课程筛选";
    
    currentPage = 1;
    self.screenItems = [[NSMutableArray alloc]init];
    self.courseProcess = [[PLCourseProcess alloc]init];
    
    CGRect animationR = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    [super creatAnimationIndicator:animationR superView:self.view delegate:self];
    
    [self startAnimationIndicator];

    [self.courseProcess  getCourseConditionList:^(NSMutableArray *array) {
        
        [self.screenItems addObjectsFromArray:array];
        
        [self getGradeListCurrentPage:currentPage
                             didGrade:0
                           didSubject:0
                           didTeacher:0
                              didType:self.courseType+1];
        
        
    } didFail:^(NSString *error)
    {
        [super stopAnimationIndicatorLoadText:YYFailReloadText
                                     withType:NO
                                     loadType:MLoadTypeFail];
    }];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark- 创建列表控件
-(void)creatTableView
{
    if (!self.baseTableView)
    {
        CGRect tabR = CGRectMake(0, self.menu.frame.origin.y+self.menu.frame.size.height,
                                 self.view.frame.size.width,self.view.frame.size.height-self.menu.frame.origin.y-self.menu.frame.size.height);
        
        [super initBaseTableView:UITableViewStyleGrouped
                  separatorStyle:UITableViewCellSeparatorStyleNone
                           frame:tabR];
        self.baseTableView.backgroundColor = self.view.backgroundColor;
        [super indicatorBringSubviewToFront];
    }
    
}
-(void)creatMScreeningMenuWithMenuSelects:(NSArray *)menuSelects
{
    if (!self.menu)
    {
        CGRect rect = CGRectMake(0, 64, self.view.frame.size.width, kMenuHeight*self.screenItems.count+kSpace*(self.screenItems.count-1));
        self.menu = [[MScreeningMenu alloc]initWithFrame:rect
                                                   memus:self.screenItems
                                             menuSelects:menuSelects];
        self.menu.delegate = self;
        [self.view addSubview:self.menu];
 
        [super setIndicatorFrame:self.menu.frame.size.height+self.menu.frame.origin.y];
 
    }
}

#pragma mark-UITableViewDataSource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.baseArray.count;
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
    
    PLCourse *course = [self.baseArray objectAtIndex:indexPath.row];
    cell.titleLabel.text  = course.courseName;
    cell.contentLabel.text = course.courseContent;
    [cell.iconImage setImageWithURL:[NSURL URLWithString:course.courseImgURL]
                   placeholderImage:[UIImage imageNamed:@"MCourseDefalut.png"]];
    return cell;
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
    [self performSegueWithIdentifier:@"Play1Identifier" sender:indexPath];
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"Play1Identifier"])
    {
        NSIndexPath *indexPath = sender;
        PLCourse *course = [self.baseArray objectAtIndex:indexPath.row];
        MPlayVideoViewController *play = segue.destinationViewController;
        play.mPlayVideoType = MPlayVideoTypeCourse;
        play.objectModel = course;
    }
}

#pragma mark- MScreeningMenuDelegate
-(void)didMenuLine:(NSInteger)line row:(NSInteger)row menuObject:(id)menuObject
{
    NSLog(@"line = %d,row = %d",line,row);
    currentPage = 1;
    [self.baseArray removeAllObjects];
    [self.baseTableView reloadData];
    
    if (line == 0)
    {//年级
        grade = [[menuObject objectForKey:@"id"] intValue];
        
    }else if (line == 1)
    {//科目
        subject = [[menuObject objectForKey:@"id"] intValue];
        
    }else if (line == 2)
    {//教师
        teacher = [[menuObject objectForKey:@"id"] intValue];;
    }
    [self getGradeListCurrentPage:currentPage
                         didGrade:grade
                       didSubject:subject
                       didTeacher:teacher
                          didType:self.courseType+1];
}
#pragma mark- RefreshViewDelegate
// 开始进入刷新状态就会调用
-(void)refreshViewBeginRefreshing:(MJRefreshBaseView *)refreshView
{
    [self getGradeListCurrentPage:currentPage
                         didGrade:grade
                       didSubject:subject
                       didTeacher:teacher
                          didType:self.courseType+1];
}
#pragma mark- YYAnimationDelegate
-(void)didReloadData:(YYAnimationIndicator *)animationView
{
    [self getGradeListCurrentPage:currentPage
                         didGrade:grade
                       didSubject:subject
                       didTeacher:teacher
                          didType:self.courseType+1];
}

#pragma mark- 获取筛选课程
-(void)getGradeListCurrentPage:(int)mCurrentPage
                      didGrade:(int)mGrade
                    didSubject:(int)mSubject
                    didTeacher:(int)mTeacher
                       didType:(NSInteger)type
{
    NSLog(@"mCurrentPage = %D,mGrade = %D,mSubject= %d,mTeacher = %d,type = %d",mCurrentPage,mGrade,mSubject,mTeacher,type);
    
    if (mCurrentPage == 1)
    {
        [super startAnimationIndicator];
    }
    
    [self.courseProcess getCourseFilter:MPageSize
                         didCurrentPage:mCurrentPage
                               didGrade:mGrade
                             didSubject:mSubject
                             didTeacher:mTeacher
                                didType:type
                             didSuccess:^(NSMutableArray *array)
     {
         if (mCurrentPage == 1)
         {//默认是从第一页开始
             
             [super stopAnimationIndicatorLoadText:@"加载成功!" withType:YES];
             [self creatMScreeningMenuWithMenuSelects:@[[NSIndexPath indexPathForRow:self.courseType inSection:0]]];
             [self creatTableView];
             
         }
         if (array.count >0 && array.count == MPageSize)
         {
             currentPage +=1;
             [super creatFootViewRefresh];
             
         }else
         {
             for (id object in array)
             {
                 [self.baseArray addObject:object];
                 [self.baseTableView insertRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:self.baseArray.count-1 inSection:0]] withRowAnimation:UITableViewRowAnimationMiddle];
             }
             if (array.count == 0)
             {
                 [super removeFootViewRefresh];
                 if (self.baseArray.count<=0)
                 {
                     [super stopAnimationIndicatorLoadText:@"没有数据!" withType:NO];
                 }
                 
             }else
             {
                 currentPage +=1;
             }
         }
         
     } didFail:^(NSString *error)
     {
         if (mCurrentPage == 1)
         {
             [super stopAnimationIndicatorLoadText:YYFailReloadText
                                          withType:NO
                                          loadType:MLoadTypeFail];
         }
     }];
}


@end
