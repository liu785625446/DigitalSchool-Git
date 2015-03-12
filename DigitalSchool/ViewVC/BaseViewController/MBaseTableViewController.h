//
//  MBaseTableViewController.h
//  DigitalScholl
//
//  Created by rachel on 15/1/6.
//  Copyright (c) 2015年 刘军林. All rights reserved.
//

#import "MBaseViewController.h"
#import "MJRefreshFooterView.h"
#import "YYAnimationIndicator.h"

@interface MBaseTableViewController : MBaseViewController
<UITableViewDataSource,UITableViewDelegate,MJRefreshBaseViewDelegate,YYAnimationDelegate>
{
    UITableView *baseTableView;
    NSMutableArray *baseArray;
    
    MJRefreshFooterView *_footView;
}
@property(nonatomic,strong)IBOutlet UITableView *baseTableView;
@property(nonatomic,strong)NSMutableArray *baseArray;
@property(nonatomic,assign)NSInteger currentPage;// 当前页数（从1开始，下同）

-(void)initBaseTableView:(UITableViewStyle)style
          separatorStyle:(UITableViewCellSeparatorStyle)separatorStyle
                   frame:(CGRect)frame;

#pragma mark- 创建加载动画
-(void)creatAnimationIndicator:(CGRect)frame superView:(UIView *)superView delegate:(id)delegate;
-(void)setIndicatorFrame:(CGFloat)height;
#pragma mark- 启动加载动画
-(void)startAnimationIndicator;
#pragma mark- 停止或者关闭加载动画
-(void)stopAnimationIndicatorLoadText:(NSString *)text withType:(BOOL)type;
-(void)stopAnimationIndicatorLoadText:(NSString *)text withType:(BOOL)type loadType:(MLoadType)loadType;
-(void)indicatorBringSubviewToFront;

#pragma mark- YYAnimationDelegate
-(void)didReloadData:(YYAnimationIndicator *)animationView;


#pragma mark -add上啦加载
-(void)creatFootViewRefresh;
-(void)removeFootViewRefresh;
#pragma mark- RefreshViewDelegate
// 开始进入刷新状态就会调用
-(void)refreshViewBeginRefreshing:(MJRefreshBaseView *)refreshView;
-(void)endRefresh:(MJRefreshFooterView *)refreshView;
// 刷新完毕就会调用
- (void)refreshViewEndRefreshing:(MJRefreshBaseView *)refreshView;
// 刷新状态变更就会调用
- (void)refreshView:(MJRefreshBaseView *)refreshView stateChange:(MJRefreshState)state;



#pragma mark- 有加载动画并且有上啦加载效果的数据解析成功
-(void)indicatorDataAnalysisSuccess:(NSArray *)array page:(NSInteger)page;
-(void)indicatorDataAnalysisFailure:(NSInteger)page;


@end
