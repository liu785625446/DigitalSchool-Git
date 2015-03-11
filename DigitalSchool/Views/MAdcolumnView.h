//
//  MAdcolumnView.h
//  DigitalScholl
//
//  Created by rachel on 15/1/15.
//  Copyright (c) 2015年 刘军林. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "PLRecommendCourse.h"

@protocol MAdcolumnDelegate <NSObject>

-(void)didAdcolumnObject:(id)object withIndex:(NSInteger)index;

@end

@interface MAdcolumnView : UIView
<UIScrollViewDelegate>
{
    UIPageControl *pageControl;
    NSMutableArray *mAdcolumns;
}
@property(nonatomic,assign)id<MAdcolumnDelegate> delegate;
-(id)initWithFrame:(CGRect)frame adcolumns:(NSArray *)adcolumns;

-(void)creatAdcolumn:(NSArray *)adcolumns;
@end
