//
//  MMenuView.m
//  DigitalScholl
//
//  Created by rachel on 15/1/7.
//  Copyright (c) 2015年 刘军林. All rights reserved.
//

#import "MMenuView.h"

#import "MJRefreshFooterView.h"

#define kMenuHrizontalHeight 40
#define kYYAnimationIndicatorTag 44
#define KMJRefreshFooterViewTag 600

@interface MMenuView()
<MJRefreshBaseViewDelegate>
@end

@implementation MMenuView

-(id)initWithFrame:(CGRect)frame
        itemsArray:(NSArray *)itemsTitleArray
         itemWidth:(float)itemWidth
   itemNormalColor:(UIColor *)itemNormalColor
   itemSelectColor:(UIColor *)itemSelectColor
     tableDelegate:(id <UITableViewDelegate>)tableViewDelegate
   tableDataSource:(id<UITableViewDataSource>)tableViewDataSource
        tableStyle:(UITableViewStyle)tableStyle
    separatorStyle:(UITableViewCellSeparatorStyle)separatorStyle
{
    self =  [super initWithFrame:frame];
    if (self)
    {
        [self mInitWithItemsTitleArray:itemsTitleArray
                             itemWidth:itemWidth
                       itemNormalColor:itemNormalColor
                       itemSelectColor:itemSelectColor
                         tableDelegate:tableViewDelegate
                       tableDataSource:tableViewDataSource
                            tableStyle:tableStyle
                        separatorStyle:separatorStyle];
    }
    return self;
}

-(void)mInitWithItemsTitleArray:(NSArray *)itemsTitleArray
                      itemWidth:(float)itemWidth
                itemNormalColor:(UIColor *)itemNormalColor
                itemSelectColor:(UIColor *)itemSelectColor
                  tableDelegate:(id<UITableViewDelegate>)tableViewDelegate
                tableDataSource:(id<UITableViewDataSource>)tableViewDataSource
                     tableStyle:(UITableViewStyle)tableStyle
                 separatorStyle:(UITableViewCellSeparatorStyle)separatorStyle
{
    menuCount = itemsTitleArray.count;
    
    CGRect menuR = CGRectMake(0, 0, self.frame.size.width, kMenuHrizontalHeight);
    menuHrizontalView = [[MenuHrizontalView alloc]initWithFrame:menuR
                                                    ButtonItems:itemsTitleArray
                                                      itemWidth:itemWidth
                                                itemNormalColor:itemNormalColor
                                                itemSelectColor:itemSelectColor];
    
    menuHrizontalView.backgroundColor = [UIColor whiteColor];
    menuHrizontalView.delegate = self;
    [self addSubview:menuHrizontalView];
    
    superScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, menuHrizontalView.frame.origin.y+kMenuHrizontalHeight, self.frame.size.width, self.frame.size.height-kMenuHrizontalHeight)];
    superScrollView.showsVerticalScrollIndicator = NO;
    superScrollView.showsHorizontalScrollIndicator = NO;
    superScrollView.pagingEnabled = YES;
    superScrollView.backgroundColor = [UIColor colorWithHexString:MListBarkGroundColor alpha:1];
    superScrollView.delegate = self;
    [self addSubview:superScrollView];
    
    
    for (int i=0; i<menuCount; i++)
    {
        UITableView *subTableView  =[[UITableView alloc]initWithFrame:CGRectMake(self.frame.size.width*i, 0, self.frame.size.width, superScrollView.frame.size.height) style:tableStyle];
        
        subTableView.separatorStyle = separatorStyle;
        subTableView.delegate = tableViewDelegate;
        subTableView.dataSource = tableViewDataSource;
        subTableView.backgroundColor = [UIColor colorWithHexString:MListBarkGroundColor alpha:1];
        subTableView.tag = i+kSubTableViewTag;
        
        [superScrollView addSubview:subTableView];
        
        CGRect anR = CGRectMake(0,0,subTableView.frame.size.width,subTableView.frame.size.height);
        YYAnimationIndicator *animationLoad = [[YYAnimationIndicator alloc]initWithFrame:anR];
        [animationLoad setLoadText:@"正在加载..."];
        animationLoad.tag = kYYAnimationIndicatorTag+i;
        [subTableView addSubview:animationLoad];
        
        
        
    }
    [superScrollView setContentSize:CGSizeMake(menuCount*self.frame.size.width, superScrollView.frame.size.height)];
    
    
    
//    [self addSubview:animationLoad];
    
}


#pragma mark - UIScrollViewDelegate
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    if (scrollView == superScrollView)
    {
        int page = scrollView.contentOffset.x / self.frame.size.width;
        
        [menuHrizontalView setSelectButton:page];
        [self selectMenu:page];
    }
}
-(void)selectMenu:(NSInteger)itemTag
{
    if (cuurentIndex != itemTag)
    {
        if (_delegate && [_delegate respondsToSelector:@selector(didMMenuView:menuItemTag:)])
        {
            [_delegate didMMenuView:self menuItemTag:itemTag];
        }
        cuurentIndex = itemTag;
        
        [UIView animateWithDuration:0.5 animations:^{
          [superScrollView setContentOffset:CGPointMake(itemTag*self.frame.size.width, 0)];
        }];
    }
    
}

#pragma mark- 设置title栏目到哪里
-(void)selectMenuHrizontalView:(NSInteger)index
{
    [menuHrizontalView setSelectButton:index];
    cuurentIndex = index;
    [superScrollView setContentOffset:CGPointMake(index*self.frame.size.width, 0)];
}

-(void)reloadTableView:(NSInteger)index
{
    UITableView *tableView =  (UITableView *)[superScrollView viewWithTag:index+kSubTableViewTag];
    [tableView reloadData];
}
-(void)reloadAllTableView
{
    for (UIView *view in superScrollView.subviews) {
        
        if ([view isKindOfClass:[UITableView class]]) {
            
            [(UITableView *)view reloadData];
        }
    }
}

#pragma mark- MenuHrizontalViewDelegate
-(void)didMenuHrizontalView:(MenuHrizontalView *)menuHrizontalView itemTag:(NSInteger)itemTag
{
    [self selectMenu:itemTag];
}

-(void)startAnimationIndicator:(NSInteger)mCurentIndex
{
    UIView *view =  [superScrollView viewWithTag:mCurentIndex+kSubTableViewTag];
    UIView *superView = [view viewWithTag:mCurentIndex+kYYAnimationIndicatorTag];
    if (superView)
    {
        YYAnimationIndicator *load =(YYAnimationIndicator *)superView;
        [load startAnimation];
    }
    
}
-(void)stopAnimationIndicatorLoadText:(NSString *)text
                             withType:(BOOL)type
                         mCurentIndex:(NSInteger)mCurentIndex
{
    UIView *view =  [superScrollView viewWithTag:mCurentIndex+kSubTableViewTag];
    UIView *superView = [view viewWithTag:mCurentIndex+kYYAnimationIndicatorTag];
    if (superView)
    {
        YYAnimationIndicator *load =(YYAnimationIndicator *)superView;
        [load stopAnimationWithLoadText:text withType:type];
    }

}

#pragma mark -add上啦加载
-(void)creatFootViewRefresh:(NSInteger)mCurentIndex
{
    UITableView *tableView=(UITableView *)[superScrollView viewWithTag:mCurentIndex+kSubTableViewTag];
    MJRefreshFooterView *footerView = (MJRefreshFooterView *)[tableView viewWithTag:mCurentIndex+KMJRefreshFooterViewTag];
    if (footerView == nil && ![footerView superview])
    {
        footerView = [MJRefreshFooterView footer];
        footerView.scrollView = tableView;
        footerView.delegate = self;
        footerView.tag = KMJRefreshFooterViewTag + mCurentIndex;
        
    }else
    {
        footerView.hidden = NO;
    }
}
-(void)removeFootViewRefresh:(NSInteger)mCurentIndex
{
    UITableView *tableView=(UITableView *)[superScrollView viewWithTag:mCurentIndex+kSubTableViewTag];
    MJRefreshFooterView *footerView = (MJRefreshFooterView *)[tableView viewWithTag:mCurentIndex+KMJRefreshFooterViewTag];
    
    if (footerView !=nil && [footerView superview])
    {
        footerView.hidden = YES;
    }
}
-(void)menuEndRefreshing:(NSInteger)mCurentIndex
{
    UITableView *tableView=(UITableView *)[superScrollView viewWithTag:mCurentIndex+kSubTableViewTag];
    MJRefreshFooterView *footerView = (MJRefreshFooterView *)[tableView viewWithTag:mCurentIndex+KMJRefreshFooterViewTag];
    [footerView endRefreshing];
}

#pragma mark-  MJRefreshBaseViewDelegate
// 开始进入刷新状态就会调用
- (void)refreshViewBeginRefreshing:(MJRefreshBaseView *)refreshView
{
    if (_delegate && [_delegate respondsToSelector:@selector(loadDataMenuItemTag:)])
    {
        [_delegate loadDataMenuItemTag:cuurentIndex];
    }
}
// 刷新完毕就会调用
- (void)refreshViewEndRefreshing:(MJRefreshBaseView *)refreshView
{
    [self reloadTableView:cuurentIndex];
    [refreshView endRefreshing];
}
// 刷新状态变更就会调用
- (void)refreshView:(MJRefreshBaseView *)refreshView stateChange:(MJRefreshState)state
{
    
}

@end
