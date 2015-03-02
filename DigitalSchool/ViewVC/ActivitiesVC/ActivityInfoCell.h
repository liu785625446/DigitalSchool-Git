//
//  ActivityInfoCell.h
//  DigitalSchool
//
//  Created by 刘军林 on 15/2/6.
//  Copyright (c) 2015年 刘军林. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PLActivity.h"

@interface ActivityInfoCell : UITableViewCell

@property (nonatomic, assign) IBOutlet UILabel *activityContent;
@property (nonatomic, assign) IBOutlet UILabel *activityTips;

@property (nonatomic, strong) PLActivity *activity;

@end
