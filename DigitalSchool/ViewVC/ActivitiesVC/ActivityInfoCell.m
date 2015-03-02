//
//  ActivityInfoCell.m
//  DigitalSchool
//
//  Created by 刘军林 on 15/2/6.
//  Copyright (c) 2015年 刘军林. All rights reserved.
//

#import "ActivityInfoCell.h"

@implementation ActivityInfoCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void) setActivity:(PLActivity *)activity
{
    _activity = activity;
    _activityContent.text = _activity.activityDetail;
    _activityContent.text = _activity.activityTips;
}

@end
