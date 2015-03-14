//
//  MBaseTableViewController.m
//  DigitalScholl
//
//  Created by rachel on 15/1/6.
//  Copyright (c) 2015年 刘军林. All rights reserved.
//

#import "MBaseTableViewController.h"

@interface MBaseTableViewController ()
{
    YYAnimationIndicator *indicator;
}
@property(nonatomic,strong)YYAnimationIndicator * indicator;
@end

@implementation MBaseTableViewController
@synthesize baseArray;
@synthesize baseTableView;
@synthesize indicator;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    if (self.baseArray ==nil)
    {
        self.baseArray = [[NSMutableArray alloc]init];
    }
    _currentPage = 1;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}
-(void)initBaseTableView:(UITableViewStyle)style
          separatorStyle:(UITableViewCellSeparatorStyle)separatorStyle
                   frame:(CGRect)frame
{
    baseTableView = [[UITableView alloc]initWithFrame:frame style:style];
    baseTableView.separatorStyle = separatorStyle;
    baseTableView.delegate = self;
    baseTableView.dataSource = self;
    [self.view addSubview:baseTableView];
    
    if (!indicator.superview)
    {
        [self creatAnimationIndicator:frame superView:self.baseTableView delegate:self];
    }
}

#pragma mark-UITableViewDataSource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 0;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return nil;
}
#pragma mark -UITableViewDelegate
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 0;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

#pragma mark- 加载动画
-(void)creatAnimationIndicator:(CGRect)frame superView:(UIView*)superView delegate:(id)delegate
{
    if (indicator.superview)
    {
        [indicator removeFromSuperview];
    }
    indicator = [[YYAnimationIndicator alloc]initWithFrame:frame];
    indicator.delegate = delegate;
    [indicator setLoadText:@"正在加载中..."];
    [superView addSubview:indicator];
}
-(void)setIndicatorFrame:(CGFloat)height
{
    self.indicator.frame  = CGRectMake(self.indicator.frame.origin.x, height, self.indicator.frame.size.width, self.indicator.frame.size.height-height);
}

-(void)startAnimationIndicator
{
    [indicator startAnimation];
}
-(void)stopAnimationIndicatorLoadText:(NSString *)text withType:(BOOL)type
{
    [self stopAnimationIndicatorLoadText:text withType:type loadType:MLoadTypeDefault];
}
-(void)stopAnimationIndicatorLoadText:(NSString *)text withType:(BOOL)type loadType:(MLoadType)loadType
{
    [indicator stopAnimationWithLoadText:text withType:type loadType:loadType];
}

-(void)indicatorBringSubviewToFront
{
    UIView *superView = indicator.superview;
    [superView bringSubviewToFront:indicator];
}

#pragma mark- YYAnimationDelegate
-(void)didReloadData:(YYAnimationIndicator *)animationView
{
    
}

#pragma mark -add上啦加载
-(void)creatFootViewRefresh
{
    if (_footView == nil && ![_footView superview])
    {
        _footView = [MJRefreshFooterView footer];
        _footView.scrollView = self.baseTableView;
        _footView.delegate = self;
        
    }else
    {
        _footView.hidden = NO;
    }
    
}
-(void)removeFootViewRefresh
{
    if (_footView !=nil && [_footView superview])
    {
        _footView.hidden = YES;
    }
}
#pragma mark- RefreshViewDelegate
// 开始进入刷新状态就会调用
- (void)refreshViewBeginRefreshing:(MJRefreshBaseView *)refreshView
{
    NSLog(@"开始进入刷新状态就会调用");
    
}
-(void)endRefresh:(MJRefreshFooterView *)refreshView
{
    [self.baseTableView reloadData];
    [refreshView endRefreshing];
}
// 刷新完毕就会调用
- (void)refreshViewEndRefreshing:(MJRefreshBaseView *)refreshView{
    NSLog(@"刷新完毕就会调用");
}
// 刷新状态变更就会调用
- (void)refreshView:(MJRefreshBaseView *)refreshView stateChange:(MJRefreshState)state{
    NSLog(@"刷新状态变更就会调用");
}

#pragma mark- 有加载动画并且有上啦加载效果的数据解析成功
-(void)indicatorDataAnalysisSuccess:(NSArray *)array page:(NSInteger)page
{
    if (page == 1)
    {//默认是从第一页开始
        
        [self stopAnimationIndicatorLoadText:@"加载成功!" withType:YES];
    }
    
    if (array.count >0 && array.count == MPageSize)
    {
        _currentPage +=1;
        [self creatFootViewRefresh];
        
    }else
    {
        for (id object in array)
        {
            [self.baseArray addObject:object];
            [self.baseTableView insertRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:self.baseArray.count-1 inSection:0]] withRowAnimation:UITableViewRowAnimationNone];
        }
        if (array.count == 0)
        {
            [self removeFootViewRefresh];
            if (self.baseArray.count<=0)
            {
                [self stopAnimationIndicatorLoadText:YYNOTDATATEXT withType:NO];
            }
            
        }else
        {
            _currentPage +=1;
        }
    }
    [self.baseTableView reloadData];
}
-(void)indicatorDataAnalysisFailure:(NSInteger)page
{
    if (page == 1)
    {
        [self stopAnimationIndicatorLoadText:YYFailReloadText
                                    withType:NO
                                    loadType:MLoadTypeFail];
    }
}

@end
