//
//  MAdcolumnView.h
//  DigitalScholl
//
//  Created by rachel on 15/1/15.
//  Copyright (c) 2015年 刘军林. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MAdcolumnView : UIView
<UIScrollViewDelegate>
{
    UIPageControl *pageControl;
}
-(id)initWithFrame:(CGRect)frame adcolumns:(NSArray *)adcolumns;

-(void)creatAdcolumn:(NSArray *)adcolumns;
@end
