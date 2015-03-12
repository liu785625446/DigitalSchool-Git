//
//  MCollectListViewController.h
//  DigitalSchool
//
//  Created by 刘军林 on 15/2/11.
//  Copyright (c) 2015年 刘军林. All rights reserved.
//

#import "MBaseTableViewController.h"

@class PLCourseProcess;
@class PLActivityProcess;

typedef enum {
    COLLECT_COURSE = 0,
    COLLECT_ACTIVITY
}COLLECT_TYPE;


@interface MCollectListViewController : MBaseTableViewController

@property (assign) COLLECT_TYPE collectType;

@end
