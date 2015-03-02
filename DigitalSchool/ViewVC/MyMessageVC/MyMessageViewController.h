//
//  MyMessageViewController.h
//  DigitalScholl
//
//  Created by rachel on 15/1/6.
//  Copyright (c) 2015年 刘军林. All rights reserved.
//

#import "MBaseTableViewController.h"

@interface MyMessageViewController : MBaseTableViewController

@property (nonatomic, strong) IBOutlet NSLayoutConstraint *top;

@property (nonatomic, strong) NSArray *titleArray;
@property (nonatomic, strong) NSArray *imageArray;

-(IBAction)settingsAction:(id)sender;

-(IBAction)myActivitiesAction:(id)sender;

@end
