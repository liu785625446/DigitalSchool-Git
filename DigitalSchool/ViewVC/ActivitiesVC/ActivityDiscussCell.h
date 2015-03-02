//
//  ActivityDiscussCell.h
//  DigitalSchool
//
//  Created by 刘军林 on 15/2/5.
//  Copyright (c) 2015年 刘军林. All rights reserved.
//

#import <UIKit/UIKit.h>

@class PLDiscuss;

@interface ActivityDiscussCell : UITableViewCell

@property (nonatomic, strong) IBOutlet UILabel *discussContent;
@property (nonatomic, strong) IBOutlet UILabel *discussCreateTime;
@property (nonatomic, assign) IBOutlet UILabel *discussName;

@property (nonatomic, strong) PLDiscuss *discuss;
@end
