//
//  ActivitiesViewController.h
//  DigitalScholl
//
//  Created by rachel on 15/1/6.
//  Copyright (c) 2015年 刘军林. All rights reserved.
//

#import "MBaseTableViewController.h"

@class PLActivityProcess;

@interface ActivitiesViewController : MBaseTableViewController

@property (nonatomic, strong) NSArray *activityList;
@property (nonatomic, strong) PLActivityProcess *activityProcess;

@end
