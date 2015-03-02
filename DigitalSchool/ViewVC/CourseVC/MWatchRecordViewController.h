//
//  MWatchRecordViewController.h
//  DigitalSchool
//
//  Created by 刘军林 on 15/2/11.
//  Copyright (c) 2015年 刘军林. All rights reserved.
//

#import "MBaseTableViewController.h"
#import "PLCourseProcess.h"
#import "PLWorkProcess.h"

@interface MWatchRecordViewController : MBaseTableViewController

@property (nonatomic, strong) NSArray *watchRecord_list;

@property (nonatomic, strong) PLCourseProcess *courseProcess;
@property (nonatomic, strong) PLWorkProcess *workProcess;

@property (assign) int course_works;

-(IBAction)recordSegmentedAction:(id)sender;

@end
