//
//  MyMessageViewController.h
//  DigitalScholl
//
//  Created by rachel on 15/1/6.
//  Copyright (c) 2015年 刘军林. All rights reserved.
//

#import "MBaseTableViewController.h"
#import "UrlImageView.h"

@class PLUser;

@interface MyMessageViewController : MBaseTableViewController

@property (nonatomic, strong) IBOutlet NSLayoutConstraint *top;

@property (nonatomic, assign) IBOutlet UrlImageView *userImg;
@property (nonatomic, assign) IBOutlet UILabel *userName;

@property (nonatomic, strong) NSArray *titleArray;
@property (nonatomic, strong) NSArray *imageArray;

@property (nonatomic, strong) PLUser *current_user;

-(IBAction)settingsAction:(id)sender;

-(IBAction)myActivitiesAction:(id)sender;

@end
