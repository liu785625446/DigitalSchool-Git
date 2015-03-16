//
//  MPlayVideoViewController.m
//  DigitalSchool
//
//  Created by rachel on 15/1/20.
//  Copyright (c) 2015年 刘军林. All rights reserved.
//

#import "MPlayVideoViewController.h"

#import "MBottomView.h"
#import "MMenuView.h"

#import "MDetailsCell.h"
#import "MIntroductionCell.h"
#import "MChapterCell.h"
#import "MDiscussNotesCell.h"

#import "PLCourseProcess.h"
#import "PLDiscussProcess.h"
#import "PLNotesProcess.h"

#import "PLDiscuss.h"
#import "PLNotes.h"


#define MDiscussButtonTag 99 //讨论回复按钮tag
#define MNotesButtonTag 100 //笔记赞按钮tag

#define MPlayPageSize 10


@interface MPlayVideoViewController ()
<UITableViewDataSource,UITableViewDelegate,
MBottomViewDelegate,MMenuViewDelegate,MDiscussNotesCellDelegate>
{
    
}
@property(nonatomic,strong)MMenuView *menuView;
@property(nonatomic,strong)PLCourseProcess *courseProcess;
@property(nonatomic,strong)PLDiscussProcess *discussProcess;
@property(nonatomic,strong)PLNotesProcess *notesProcess;

@end

@implementation MPlayVideoViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.statusBarHidden = YES;
    
    MBottomView *mbttom = [[MBottomView alloc]initWithFrame:CGRectMake(0, self.view.frame.size.height-40,
                                                                       self.view.frame.size.width, 40)];
    mbttom.delegate = self;
    [self.view addSubview:mbttom];
    
    NSArray *itemArray = nil;
    if (self.mPlayVideoType == MPlayVideoTypeCourse)
    {
        itemArray = @[@"详细信息",@"讨论",@"笔记",@"章节"];
    }else
    {
        itemArray = @[@"详细信息",@"讨论"];
    }
    
    
    CGRect menuR = CGRectMake(0, MOVIEPLAYER_HEIGHT, self.view.frame.size.width,
                              self.view.frame.size.height-mbttom.frame.size.height-MOVIEPLAYER_HEIGHT);
    self.menuView = [[MMenuView alloc]initWithFrame:menuR
                                         itemsArray:itemArray
                                          itemWidth:self.view.frame.size.width/itemArray.count
                                    itemNormalColor:[UIColor grayColor]
                                    itemSelectColor:[UIColor colorWithHexString:@"#AA0000" alpha:1]
                                      tableDelegate:self
                                    tableDataSource:self
                                         tableStyle:UITableViewStyleGrouped
                                     separatorStyle:UITableViewCellSeparatorStyleSingleLine];
    self.menuView.delegate = self;
    [self.view addSubview:self.menuView];
    
    [self setNeedsStatusBarAppearanceUpdate];
    _moviePlayer = [[DSMoviePlayerController alloc] init];
    _moviePlayer.delegate = self;
    
//    self.view.translatesAutoresizingMaskIntoConstraints = NO;
    _moviePlayer.view.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:_moviePlayer.view];
    
    [_moviePlayer setScalingMode:MPMovieScalingModeAspectFit];
    [_moviePlayer addConstraintSupview:self.view];
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"课程2" ofType:@"mp4"];
    NSURL *url = [[NSURL alloc] initFileURLWithPath:path];
    
//    if (self.mPlayVideoType == MPlayVideoTypeCourse)
//    {
//        PLCourse *course = self.objectModel;
//        [_moviePlayer setContentURL:[NSURL URLWithString:course.courseVideoURL]];
//        
//    }else
//    {
//        PLWorks *work = self.objectModel;
//        [_moviePlayer setContentURL:[NSURL URLWithString:work.workURL]];
//    }
    [_moviePlayer setContentURL:url];
    [_moviePlayer setRepeatMode:MPMovieRepeatModeOne];
    [_moviePlayer setMovieSourceType:MPMovieSourceTypeFile];
    [_moviePlayer play];
    
    
    self.courseProcess = [[PLCourseProcess alloc]init];
    self.discussProcess = [[PLDiscussProcess alloc]init];
    self.notesProcess = [[PLNotesProcess alloc]init];
    
    discussCurrentPage = 1;
    noteCurrentPage = 1;
    correlationCurrentPage = 1;
    datas = [[NSMutableArray alloc]init];
    for (int i = 0; i<itemArray.count; i++)
    {
        NSMutableArray *arr = [[NSMutableArray alloc]init];
        [datas addObject:arr];
    }
    
    
}

-(void) viewWillDisappear:(BOOL)animated
{
    [_moviePlayer stop];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}
-(UIStatusBarStyle) preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

-(BOOL) prefersStatusBarHidden
{
    return self.statusBarHidden;
}

#pragma mark- TableViewDataSource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSInteger index = tableView.tag-kSubTableViewTag;
    switch (index)
    {
        case 0:
        {
            return 3;
        }
            break;
        case 1:
        {
            if (index <datas.count)
            {
                NSArray *arry = [datas objectAtIndex:index];
                return [arry count];
            }
            return 0;
        }
            break;
        case 2:
        {
            if (index <datas.count)
            {
                NSArray *arry = [datas objectAtIndex:index];
                return [arry count];
            }
            return 0;
        }
            break;
        case 3:
        {
            if (index <datas.count)
            {
                NSArray *arry = [datas objectAtIndex:index];
                return [arry count];
            }
            return 0;
        }
            break;
    }
    return 0;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger tag = tableView.tag - kSubTableViewTag;
    
    if (tag == 0)
    {
        return [self mInitDetailedCellWithTableView:tableView indexPath:indexPath];
        
    }else if (tag == 1 || tag == 2)
    {
        return [self mInitDiscussNotesCellWithTableView:tableView indexPath:indexPath];
        
    }else if (tag == 3)
    {
        return [self mInitChapterCellWithTableView:tableView indexPath:indexPath];
    }
    return nil;
}

#pragma mark- 初始化详细信息Cell
-(UITableViewCell *)mInitDetailedCellWithTableView:(UITableView *)tableView indexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row ==0)
    {
        static NSString *normoIdentifier = @"NormoTableViewCell";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:normoIdentifier];
        if (!cell)
        {
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:normoIdentifier];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        if (self.mPlayVideoType == MPlayVideoTypeCourse)
        {
            PLCourse *course = self.objectModel;
            cell.textLabel.text = course.courseName;
            
        }else
        {
            PLWorks *work = self.objectModel;
            cell.textLabel.text = work.workTitle;
        }
        
        return  cell;
        
    }else if (indexPath.row ==1)
    {
        static NSString *Identifier = @"MDetailsCellI";
        MDetailsCell *cell = [tableView dequeueReusableCellWithIdentifier:Identifier];
        if (!cell)
        {
            cell = [[NSBundle mainBundle]loadNibNamed:@"MDetailsCell" owner:nil options:nil].firstObject;
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.iconImageView.layer.masksToBounds = YES;
            cell.iconImageView.layer.cornerRadius = cell.iconImageView.frame.size.width/2;
        }
        if (self.mPlayVideoType == MPlayVideoTypeCourse)
        {
            PLCourse *course = self.objectModel;
            cell.titleLabel.text = @"讲师";
            [cell.iconImageView setImageWithURL:[NSURL URLWithString:course.courseTeacher.teacherImg]
                               placeholderImage:[UIImage imageNamed:@"ActivitiesInfoHead1.png"]];
            cell.nameLabel.text = course.courseTeacher.teacherName;
            cell.detailLabel.text = course.courseTeacher.teacherIntroduction;
            
        }else
        {
            PLWorks *work = self.objectModel;
            cell.titleLabel.text = @"作者";
            [cell.iconImageView setImageWithURL:[NSURL URLWithString:work.user.userImg]
                               placeholderImage:[UIImage imageNamed:@"ActivitiesInfoHead1.png"]];
            cell.nameLabel.text = work.user.userName;
            cell.detailLabel.text = work.user.userSafeQuestion;
        }
       
        
        return cell;
        
    }else if (indexPath.row ==2)
    {
        static NSString *Identifier = @"MIntroductionCell";
        MIntroductionCell *cell = [tableView dequeueReusableCellWithIdentifier:Identifier];
        if (!cell)
        {
            cell = [[NSBundle mainBundle]loadNibNamed:@"MIntroductionCell" owner:nil options:nil].firstObject;
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        if (self.mPlayVideoType == MPlayVideoTypeCourse)
        {
            PLCourse *course = self.objectModel;
            cell.detailLabel.text = course.courseIntroduction;
            cell.titleLabel.text = @"课程简介";
            
        }else
        {
            PLWorks *work = self.objectModel;
            cell.titleLabel.text = @"作品简介";
            cell.detailLabel.text = work.workIntro;
        }
        
        
        return cell;
    }
    return nil;
}

#pragma mark- 初始化章节Cell
-(UITableViewCell *)mInitChapterCellWithTableView:(UITableView *)tableView indexPath:(NSIndexPath *)indexPath
{
    static NSString *Identifier = @"MChapterCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:Identifier];
    if (!cell)
    {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:Identifier];
        cell.selectionStyle = UITableViewCellSelectionStyleBlue;
    }
    cell.textLabel.text = [NSString stringWithFormat:@"第%d章节",indexPath.row+1];
    return cell;
}
#pragma mark- 初始化讨论和笔记Cell
-(UITableViewCell *)mInitDiscussNotesCellWithTableView:(UITableView *)tableView indexPath:(NSIndexPath *)indexPath
{
    static NSString *Identifier = @"MDiscussNotesCell";
    MDiscussNotesCell *cell = [tableView dequeueReusableCellWithIdentifier:Identifier];
    if (!cell)
    {
        cell = [[NSBundle mainBundle]loadNibNamed:@"MDiscussNotesCell" owner:nil options:nil].firstObject;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.delegate = self;
        
    }
    NSInteger index = tableView.tag-kSubTableViewTag;
    NSArray *array = [datas objectAtIndex:index];
    cell.tag = indexPath.row;
    
    if (index == 1)
    {//讨论
        PLDiscuss *discuss = [array objectAtIndex:indexPath.row];
        [cell.iconImage setImageWithURL:[NSURL URLWithString:discuss.pluser.userImg]
                       placeholderImage:[UIImage imageNamed:@"ActivitiesInfoHead1.png"]];
        cell.userName.text = discuss.pluser.userNickName;
        cell.content.text = discuss.discussContent;
        cell.timeLabel.text = discuss.discussCreateTime;
        cell.otherBtn.tag = MDiscussButtonTag;
        [cell.otherBtn setTitle:@"回复" forState:UIControlStateNormal];
        
    }else
    {//笔记
        PLNotes *notes = [array objectAtIndex:indexPath.row];
        [cell.iconImage setImageWithURL:[NSURL URLWithString:notes.user.userImg]
                       placeholderImage:[UIImage imageNamed:@"ActivitiesInfoHead1.png"]];
        cell.userName.text = notes.user.userNickName;
        cell.content.text = notes.noteContent;
        cell.timeLabel.text = notes.noteCreateTime;
        [cell.otherBtn setTitle:@"赞" forState:UIControlStateNormal];
        cell.otherBtn.tag = MNotesButtonTag;
    }
    
    return cell;
}

#pragma mark- UITableViewDelegate
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger tag = tableView.tag - kSubTableViewTag;
    if (tag == 0)
    {
        if (indexPath.row ==1)
        {
            //作者或者老师介绍
            NSString *text = @"";
            float contenH = 0;
            if (self.mPlayVideoType == MPlayVideoTypeCourse)
            {
                PLCourse *course = self.objectModel;
                text = course.courseTeacher.teacherIntroduction;
            }else
            {
                PLWorks *work = self.objectModel;
                text = work.user.userSafeQuestion;
            }
            CGSize maxSize = [MTool boundingRectWithSizeWithText:text
                                                         MaxSize:CGSizeMake(250, 10000)
                                                        textFont:[UIFont systemFontOfSize:14]];
            contenH = (maxSize.height - 17);
            
            return 95+(contenH>0?contenH:0);
            
        }else if (indexPath.row == 2)
        {
            //简介
            
            NSString *text = @"";
            float contenH = 0;
            if (self.mPlayVideoType == MPlayVideoTypeCourse)
            {
                PLCourse *course = self.objectModel;
                text = course.courseIntroduction;
                
            }else
            {
                PLWorks *work = self.objectModel;
                text = work.workIntro;
            }
            CGSize maxSize = [MTool boundingRectWithSizeWithText:text
                                                         MaxSize:CGSizeMake(302, 10000)
                                                        textFont:[UIFont systemFontOfSize:14]];
            contenH = (maxSize.height - 17);
            
            return 63+(contenH>0?contenH:0);
        }
        
    }else if (tag == 1 || tag == 2)
    {
        float contenH = 0;
        if (tag<datas.count)
        {
            NSArray *array = [datas objectAtIndex:tag];
            if (indexPath.row< array.count)
            {
                NSString *text = @"";
                if (tag == 1)
                {
                    //讨论
                    PLDiscuss *discuss = [array objectAtIndex:indexPath.row];
                    text = discuss.discussContent;
                    
                }else
                {
                    //笔记
                    PLNotes *notes = [array objectAtIndex:indexPath.row];
                    text = notes.noteContent;
                }
                CGSize maxSize = [MTool boundingRectWithSizeWithText:text
                                                             MaxSize:CGSizeMake(242, 10000)
                                                            textFont:[UIFont systemFontOfSize:14]];
                contenH = (maxSize.height - 17);
            }
            
        }
        return 109+(contenH>0?contenH:0);
        
    }else if(tag ==3)
    {
        return 44;
    }
    return 44;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.1;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.1;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (currentIndex == 3) {
        
        self.objectModel = [[datas objectAtIndex:currentIndex] objectAtIndex:indexPath.row];
        NSMutableArray *dis = [datas objectAtIndex:1];
        [dis removeAllObjects];
        discussCurrentPage =1;
        NSMutableArray *note = [datas objectAtIndex:2];
        [note removeAllObjects];
        noteCurrentPage =1;
        [_moviePlayer setCurrentPlaybackTime:floor(0)];
        [_moviePlayer play];
        [self.menuView reloadAllTableView];
        [self.menuView selectMenuHrizontalView:0];
    }
}


#pragma mark- DSMoviePlayerDelegate
-(void) moviePlayerClickScreen:(DSMoviePlayerController *)moviePlayer
{
    
}
#pragma mark- MBottomViewDelegate
-(void)didButtonIndex:(NSInteger)index
{
    
    switch (index)
    {
        case 0:
        {
            //返回
            [self dismissViewControllerAnimated:NO completion:nil];
            self.statusBarHidden = NO;
            [self setNeedsStatusBarAppearanceUpdate];
        }
            break;
        case 1:
        {
            //讨论
             if (![self checkUserLogin]) {
                 return;
             }
            [self performSegueWithIdentifier:@"CommentIdentifier" sender:MCommentTitle];
            
        }
            break;
        case 2:
        {
            //笔记
     
             if (![self checkUserLogin]) {
                 return;
             }
            [self performSegueWithIdentifier:@"CommentIdentifier" sender:MNoteTitle];
        }
            break;
        case 3:
        {
            //缓存
        }
            break;
        case 4:
        {
            //分享
        }
            break;
        case 5:
        {
            //收藏
            NSString *_id = @"";
            if (self.mPlayVideoType == MPlayVideoTypeCourse) {
                PLCourse *course = self.objectModel;
                _id = course.courseId;
            }else
            {
                PLWorks *works = self.objectModel;
                _id =works.workId;
            }
            
            if (![self checkUserLogin]) {
                return;
            }
            [self.courseProcess attentionCourse:_id
                                        didUser:@"0"
                                     didSuccess:^(NSMutableArray *array)
             {
                 [self shoMakeToast:@"收藏成功!"];
                 
             } didFail:^(NSString *error) {
                 [self shoMakeToast:error];
             }];
        }
            break;
    }
}

#pragma mark- MMenuViewDelegate
-(void)didMMenuView:(MMenuView *)menuView menuItemTag:(NSInteger)menuItemTag
{
    currentIndex = menuItemTag;
    if (menuItemTag != 0)
    {
        if (menuItemTag<datas.count)
        {
            NSArray *array = [datas objectAtIndex:menuItemTag];
            if (array.count<=0)
            {
                if (menuItemTag<datas.count)
                {
                    if ([[datas objectAtIndex:menuItemTag] count]<=0)
                    {
                        [self loadDataMenuItemTag:menuItemTag];
                    }
                }
            }
        }
    }
}
-(void)loadDataMenuItemTag:(NSInteger)menuItemTag
{
    NSString *_id = @"";
    
    if (self.mPlayVideoType == MPlayVideoTypeCourse)
    {
        PLCourse *course = self.objectModel;
        _id = course.courseId;
        
    }else
    {
        PLWorks *works = self.objectModel;
        _id =works.workId;
    }
    
    if (menuItemTag == 1)
    {//讨论
        
        [self getDiscussionsList:menuItemTag courseId:_id];
        
    }else if (menuItemTag == 2)
    {//笔记
        
        [self getNotesList:menuItemTag courseId:_id];
        
    }else if (menuItemTag == 3)
    {//章节
        
        [self getCorrelationList:menuItemTag courseId:_id];
    }
}

#pragma mark- MCommentDelegate
-(void)didCommentSuccess:(id)object title:(NSString *)title
{
    if (object != nil)
    {
        if ([title isEqualToString:MCommentTitle])
        {
            //发讨论
//            if (self.mPlayVideoType == MPlayVideoTypeCourse)
//            {
//                //课程
//                NSMutableArray *array = [datas objectAtIndex:1];
//                [array insertObject:object atIndex:0];
//                
//            }else if (self.mPlayVideoType == MPlayVideoTypeWorks)
//            {
//                //作品
//            }
            
            NSMutableArray *array = [datas objectAtIndex:1];
            [array insertObject:object atIndex:0];
            [self.menuView reloadTableView:1];
            
        }else if ([title isEqualToString:MNoteTitle])
        {
            //记笔记
            
        }
    }
}


#pragma mark- 获取讨论列表
-(void)getDiscussionsList:(NSInteger)mCurrentIndex courseId:(NSString *)courseId
{
    NSLog(@"获取讨论 discussCurrentPage=%d  courseId = %@",discussCurrentPage,courseId);
    
    if (discussCurrentPage == 1)
    {
        [self.menuView startAnimationIndicator:mCurrentIndex];
    }
    
    if (self.mPlayVideoType == MPlayVideoTypeCourse)
    {//课程
        [self.discussProcess getCourseDiscussList:MPlayPageSize
                                   didCurrentPage:discussCurrentPage
                                      didCourseId:courseId
                                       didSuccess:^(NSMutableArray *array)
         {
             
             [self courseAndWorksDataSuccess:mCurrentIndex array:array];
             
         } didFail:^(NSString *error) {
             
             [self courseAndWorksDataFaild:mCurrentIndex];
         }];
    }else
    {//活动奖励(作品)
        
        [self.discussProcess getWorksDiscussList:MPlayPageSize
                                  didCurrentPage:discussCurrentPage
                                     didCourseId:courseId
                                      didSuccess:^(NSMutableArray *array)
        {
            [self courseAndWorksDataSuccess:mCurrentIndex array:array];
            
        } didFail:^(NSString *error) {
            
            [self courseAndWorksDataFaild:mCurrentIndex];
        }];
        
    } 
}


#pragma mark- 获取笔记列表
-(void)getNotesList:(NSInteger)mCurrentIndex courseId:(NSString *)courseId
{
    if (noteCurrentPage == 1)
    {
        [self.menuView startAnimationIndicator:mCurrentIndex];
    }
    
    [self.notesProcess getCourseNotesList:MPlayPageSize
                           didCurrentPage:noteCurrentPage
                              didCourseId:courseId
                               didSuccess:^(NSMutableArray *array)
     {
         
         [self courseAndWorksDataSuccess:mCurrentIndex array:array];
         
     } didFail:^(NSString *error){
         
         [self courseAndWorksDataFaild:mCurrentIndex];
         
     }];
}

#pragma mark- 获取章节列表
-(void)getCorrelationList:(NSInteger)mCurrentIndex courseId:(NSString *)courseId
{
    if (correlationCurrentPage == 1) {
        
         [self.menuView startAnimationIndicator:mCurrentIndex];
    }
    PLCourse *course = self.objectModel;
    [self.courseProcess getChapterCorrelationListdGradeId:course.gradeId
                                             didCatalogId:course.subjectId
                                               didVolumes:@"1"
                                               didSuccess:^(NSMutableArray *array)
     {
        [self courseAndWorksDataSuccess:mCurrentIndex array:array];
        
    } didFail:^(NSString *error) {
        [self courseAndWorksDataFaild:mCurrentIndex];
    }];
}
#pragma mark- 数据解析成功调用
-(void)courseAndWorksDataSuccess:(NSInteger)mCurrentIndex array:(NSArray*)array
{
    NSInteger page = 1;
    if (mCurrentIndex == 1)
    {//讨论
        
        page = discussCurrentPage;
        
    }else if (mCurrentIndex ==2)
    {//笔记
        
        page = noteCurrentPage;
    }
    
    if (page == 1)
    {
        [self.menuView stopAnimationIndicatorLoadText:@"加载成功!"
                                             withType:YES
                                         mCurentIndex:mCurrentIndex];
    }else
    {
        [self.menuView menuEndRefreshing:mCurrentIndex];
    }
    
    [self combinationDatas:array mCurrentIndex:mCurrentIndex];
    
}
#pragma mark- 数据解析失败调用
-(void)courseAndWorksDataFaild:(NSInteger)mCurrentIndex
{
    NSInteger page = 1;
    if (mCurrentIndex == 1)
    {//讨论
        
        page = discussCurrentPage;
        
    }else if (mCurrentIndex ==2)
    {//笔记
        
        page = noteCurrentPage;
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


#pragma mark-  组合讨论数据，笔记数据，章节数据
-(void)combinationDatas:(NSArray *)array mCurrentIndex:(NSInteger)mCurrentIndex
{
    NSMutableArray *mArray = [datas objectAtIndex:mCurrentIndex];
    
    if (array.count>0)
    {
        if (array.count>=MPlayPageSize)
        {
            [self.menuView creatFootViewRefresh:mCurrentIndex];
        }else
        {
            [self.menuView removeFootViewRefresh:mCurrentIndex];
        }
        
        [mArray addObjectsFromArray:array];
        if (mCurrentIndex == 1)
        {
            discussCurrentPage +=1;
            
        }else if (mCurrentIndex == 2)
        {
            noteCurrentPage +=1;
            
        }else if (mCurrentIndex == 3)
        {
            correlationCurrentPage +=1;
        }
        
    }else
    {
        if (mArray.count<=0)
        {
            [self.menuView stopAnimationIndicatorLoadText:YYNOTDATATEXT
                                                 withType:NO
                                             mCurentIndex:mCurrentIndex];
        }else
        {
            [self.menuView removeFootViewRefresh:mCurrentIndex];
        }
    }
    [self.menuView reloadTableView:mCurrentIndex];
}

#pragma mark- 提示信息
-(void)shoMakeToast:(NSString *)text
{
    [self.view makeToast:text
                duration:0.5
                position:[NSValue valueWithCGPoint:CGPointMake(self.view.frame.size.width/2,kMainWindowBouns.size.height-60)]];
}

#pragma mark- MDiscussNotesCellDelegate(讨论里面的回复事件或笔记里面的赞事件)
-(void)replyCdiscussOrPraiseNote:(MDiscussNotesCell *)cell otherButton:(UIButton *)button
{
    NSInteger row = cell.tag;
    
    if (button.tag == MDiscussButtonTag)//讨论回复
    {
        
       NSDictionary *dic =  @{@"title": MReplyCommentTitle,@"row":[NSString stringWithFormat:@"%d",row]};
       [self performSegueWithIdentifier:@"CommentIdentifier" sender:dic];
        
    }else//笔记赞
    {
        NSArray *object = [datas objectAtIndex:currentIndex];
        PLNotes *notes = [object objectAtIndex:row];
 
         if (![self checkUserLogin]) {
             return;
         }
        [self.notesProcess praiseNotes:notes.noteId
                               didUser:@"1"
                            didSuccess:^(NSMutableArray *array)
        {
            [self shoMakeToast:@"赞成功"];
            
        } didFail:^(NSString *error) {
            [self shoMakeToast:@"赞成功"];
        }];
    }
}

#pragma mark- 界面调整参数传递
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"CommentIdentifier"])
    {
        
        UINavigationController *commentN = segue.destinationViewController;
        MCommentViewController *comment =(MCommentViewController *)commentN.visibleViewController;
        comment.playVideoType = self.mPlayVideoType;
        comment.delegate = self;
        
        if ([sender isKindOfClass:[NSDictionary class]])
        {
            comment.title = [sender objectForKey:@"title"];
            NSInteger row = [[sender objectForKey:@"row"] integerValue];
            NSArray *object = [datas objectAtIndex:currentIndex];
            PLDiscuss *discuss = [object objectAtIndex:row];
            comment.courseId = discuss.discussId;
            
        }else
        {
            NSString *_id = @"";
            if (self.mPlayVideoType == MPlayVideoTypeCourse)
            {
                PLCourse *course = self.objectModel;
                _id = course.courseId;
                
            }else
            {
                PLWorks *works = self.objectModel;
                _id =works.workId;
            }
            comment.title = sender;
            comment.courseId = _id;
        }
        
    }
}
@end
