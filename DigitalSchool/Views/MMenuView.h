//
//  MMenuView.h
//  DigitalScholl
//
//  Created by rachel on 15/1/7.
//  Copyright (c) 2015年 刘军林. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MenuHrizontalView.h"
#import "YYAnimationIndicator.h"

#define kSubTableViewTag 199

@class MMenuView;
@protocol MMenuViewDelegate <NSObject>

@required
-(void)didMMenuView:(MMenuView *)menuView menuItemTag:(NSInteger)menuItemTag;

@optional
-(void)loadDataMenuItemTag:(NSInteger)menuItemTag;

@end

@interface MMenuView : UIView
<MenuHrizontalViewDelegate,UIScrollViewDelegate>
{
    UIScrollView *superScrollView;
    NSInteger menuCount;
    NSInteger cuurentIndex;
    MenuHrizontalView *menuHrizontalView;
//    YYAnimationIndicator *animationLoad;
}
@property(nonatomic,assign)id <MMenuViewDelegate> delegate;

-(id)initWithFrame:(CGRect)frame
        itemsArray:(NSArray *)itemsTitleArray
         itemWidth:(float)itemWidth
   itemNormalColor:(UIColor *)itemNormalColor
   itemSelectColor:(UIColor *)itemSelectColor
     tableDelegate:(id <UITableViewDelegate>)tableViewDelegate
   tableDataSource:(id<UITableViewDataSource>)tableViewDataSource
        tableStyle:(UITableViewStyle)tableStyle
    separatorStyle:(UITableViewCellSeparatorStyle)separatorStyle;

-(void)mInitWithItemsTitleArray:(NSArray *)itemsTitleArray
                      itemWidth:(float)itemWidth
                itemNormalColor:(UIColor *)itemNormalColor
                itemSelectColor:(UIColor *)itemSelectColor
                  tableDelegate:(id <UITableViewDelegate>)tableViewDelegate
                tableDataSource:(id<UITableViewDataSource>)tableViewDataSource
                     tableStyle:(UITableViewStyle)tableStyle
                 separatorStyle:(UITableViewCellSeparatorStyle)separatorStyle;

-(void)reloadTableView:(NSInteger)index;
-(void)reloadAllTableView;
-(void)selectMenuHrizontalView:(NSInteger)index;

-(void)startAnimationIndicator:(NSInteger)mCurentIndex;
-(void)stopAnimationIndicatorLoadText:(NSString *)text
                             withType:(BOOL)type
                         mCurentIndex:(NSInteger)mCurentIndex;

#pragma mark -add上啦加载
-(void)creatFootViewRefresh:(NSInteger)mCurentIndex;
-(void)removeFootViewRefresh:(NSInteger)mCurentIndex;
-(void)menuEndRefreshing:(NSInteger)mCurentIndex;

@end
