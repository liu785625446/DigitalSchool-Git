//
//  CourseViewController.h
//  DigitalScholl
//
//  Created by rachel on 15/1/6.
//  Copyright (c) 2015年 刘军林. All rights reserved.
//

#import "MBaseViewController.h"
#import "MMenuView.h"
#import "MAdcolumnView.h"

@interface CourseViewController : MBaseViewController
{
    NSInteger currentIndex;
    NSMutableArray *datas;
    NSMutableArray *titles;
    
    int hotCourseCurrentPage; // 热门当前页数（从1开始，下同）
    int activitiesCurrentPage;    //活动获奖当前页数（从1开始，下同）
    int hotActivitiesCurrentPage; //热门活动当前页数（从1开始，下同）
    int microCourseCurrentPage; //微课程当前页数（从1开始，下同）
}


@end
