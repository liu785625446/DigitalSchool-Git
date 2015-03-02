//
//  MBaseTableViewController.m
//  DigitalScholl
//
//  Created by rachel on 15/1/6.
//  Copyright (c) 2015年 刘军林. All rights reserved.
//

#import "MBaseTableViewController.h"
#import "YYAnimationIndicator.h"

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
        [self creatAnimationIndicator:frame superView:self.baseTableView height:50];
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
-(void)creatAnimationIndicator:(CGRect)frame superView:(UIView*)superView height:(float)height
{
    if (indicator.superview)
    {
        [indicator removeFromSuperview];
    }
    indicator = [[YYAnimationIndicator alloc]initWithFrame:CGRectMake(frame.size.width/2-height, frame.size.height/2-height, 100, 100)];
    [indicator setLoadText:@"正在加载中..."];
    [superView addSubview:indicator];
}
-(void)setIndicatorFrame:(CGFloat)height
{
    self.indicator.frame  = CGRectMake(self.indicator.frame.origin.x, height/2-self.indicator.frame.size.height/2, self.indicator.frame.size.width, self.indicator.frame.size.height);
}

-(void)startAnimationIndicator
{
    [indicator startAnimation];
}
-(void)stopAnimationIndicatorLoadText:(NSString *)text withType:(BOOL)type
{
    [indicator stopAnimationWithLoadText:text withType:type];
}
-(void)indicatorBringSubviewToFront
{
    UIView *superView = indicator.superview;
    [superView bringSubviewToFront:indicator];
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


@end
