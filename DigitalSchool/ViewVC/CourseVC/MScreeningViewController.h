//
//  MScreeningViewController.h
//  DigitalScholl
//
//  Created by rachel on 15/1/14.
//  Copyright (c) 2015年 刘军林. All rights reserved.
//

#import "MBaseTableViewController.h"

@interface MScreeningViewController :MBaseTableViewController
{
    int grade; //年级ID（全部：0）
    int subject; //科目ID（全部：0）
    int teacher; //教师ID（全部：0）
    
    BOOL isCourseCondition;//用来判断是是获取筛选条件，还是课程信息
}
@property(nonatomic,assign)NSInteger courseType; // 课程类型（常规课程：1  父母教育：2   微课程：3）
@end
