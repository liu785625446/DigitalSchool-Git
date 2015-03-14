//
//  MNavigationDetailsViewController.h
//  DigitalSchool
//
//  Created by 刘军林 on 15/3/10.
//  Copyright (c) 2015年 刘军林. All rights reserved.
//

#import "MBaseTableViewController.h"
#import "PLNavs.h"
#import "PLNavsProcess.h"

@interface MNavigationDetailsViewController : MBaseTableViewController

@property (nonatomic, strong) NSMutableArray *course_list;
@property (nonatomic, strong) PLNavsProcess *navsProcess;
@property (nonatomic, strong) PLNavs *navs;

@end
