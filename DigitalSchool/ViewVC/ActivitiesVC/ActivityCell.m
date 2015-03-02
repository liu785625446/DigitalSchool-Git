//
//  ActivityCell.m
//  DigitalSchool
//
//  Created by 刘军林 on 15/2/5.
//  Copyright (c) 2015年 刘军林. All rights reserved.
//

#import "ActivityCell.h"

@implementation ActivityCell

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
    [self.imageview setImageWithURL:[NSURL URLWithString:_activity.activityImg] placeholderImage:[UIImage imageNamed:@"MCourseDefalut.png"]];
}

@end
