//
//  ActivitiesInfoViewController.h
//  DigitalSchool
//
//  Created by 刘军林 on 15/1/17.
//  Copyright (c) 2015年 刘军林. All rights reserved.
//

#import "MBaseTableViewController.h"
#import "PLActivity.h"

@class PLActivityProcess;

@interface ActivitiesInfoViewController : MBaseTableViewController

@property (nonatomic, strong) IBOutlet UIScrollView *scrollview;
@property (nonatomic, strong) IBOutlet UIPageControl *page;

@property (nonatomic, strong) IBOutlet UIView *tableTop;
@property (nonatomic, assign) IBOutlet UILabel *joinLabel;
@property (nonatomic, assign) IBOutlet UILabel *collectLabel;

@property (nonatomic, strong) PLActivity *activity;
@property (nonatomic, strong) PLActivityProcess *activityProcess;

-(IBAction)uploadWorksAction:(id)sender;
-(IBAction)activityCollectAction:(id)sender;

@end
