//
//  MSearchViewController.m
//  DigitalScholl
//
//  Created by rachel on 15/1/15.
//  Copyright (c) 2015年 刘军林. All rights reserved.
//

#import "MSearchViewController.h"
#import "PLCourseProcess.h"

@interface MSearchViewController ()
<UISearchBarDelegate>

@property(nonatomic,strong)PLCourseProcess *courseProcess;
@property(nonatomic,strong)NSString *seachText;
@end

@implementation MSearchViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UISearchBar *searchBar = [[UISearchBar alloc]initWithFrame:CGRectMake(0, 0, 100, 20)];
    searchBar.placeholder = @"搜索课程";
    searchBar.delegate = self;
    searchBar.tintColor=[UIColor blueColor];
    [searchBar becomeFirstResponder];
    self.navigationItem.titleView = searchBar;
    
    UIBarButtonItem *cancelItem = [[UIBarButtonItem alloc]initWithTitle:@"取消" style:UIBarButtonItemStyleDone target:self action:@selector(cancelAction)];
    self.navigationItem.rightBarButtonItem = cancelItem;
    
    self.courseProcess = [[PLCourseProcess alloc]init];
    
    CGRect animationR = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    [super creatAnimationIndicator:animationR superView:self.view delegate:self];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

-(void)creatTableView
{
    if (self.baseTableView == nil)
    {
        [super initBaseTableView:UITableViewStyleGrouped
                  separatorStyle:UITableViewCellSeparatorStyleNone
                           frame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
        self.baseTableView.backgroundColor = self.view.backgroundColor;
    }
    
}

#pragma mark- 取消
-(void)cancelAction
{
    UISearchBar *searchBar = (UISearchBar *)self.navigationItem.titleView;
    [searchBar resignFirstResponder];
    
    [self.navigationController popViewControllerAnimated:NO];
}
#pragma mark- RefreshViewDelegate
// 开始进入刷新状态就会调用
-(void)refreshViewBeginRefreshing:(MJRefreshBaseView *)refreshView
{
    [self getData:self.seachText];
}
#pragma mark- UISearchBarDelegate
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    [searchBar resignFirstResponder];
    self.currentPage = 1;
    self.seachText = searchBar.text;
    [self getData:searchBar.text];
}

-(void)getData:(NSString *)searchText
{
    if (self.currentPage == 1)
    {
        [super startAnimationIndicator];
    }
    [self.courseProcess getCourseSearch:MPageSize
                         didCurrentPage:self.currentPage
                              didSearch:searchText
                             didSuccess:^(NSMutableArray *array)
     {
         
         if (self.currentPage == 1)
         {//默认是从第一页开始
             
             [self creatTableView];
             
             [super indicatorBringSubviewToFront];
         }
         [super indicatorDataAnalysisSuccess:array page:self.currentPage];

         
     } didFail:^(NSString *error)
     {
         [super indicatorDataAnalysisFailure:self.currentPage];
     }];
}

#pragma mark- YYAnimationDelegate
-(void)didReloadData:(YYAnimationIndicator *)animationView
{
    [self getData:self.seachText];
}

@end
