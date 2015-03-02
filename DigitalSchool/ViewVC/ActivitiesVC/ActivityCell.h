//
//  ActivityCell.h
//  DigitalSchool
//
//  Created by 刘军林 on 15/2/5.
//  Copyright (c) 2015年 刘军林. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UrlImageView.h"
#import "PLActivity.h"

@interface ActivityCell : UITableViewCell

@property (nonatomic, strong) IBOutlet UrlImageView *imageview;

@property (nonatomic, strong) PLActivity *activity;
@end
