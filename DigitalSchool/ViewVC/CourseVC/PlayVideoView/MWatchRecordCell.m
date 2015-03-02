//
//  MWatchRecordCell.m
//  DigitalSchool
//
//  Created by 刘军林 on 15/2/11.
//  Copyright (c) 2015年 刘军林. All rights reserved.
//

#import "MWatchRecordCell.h"
#import "PLLookCourse.h"

@implementation MWatchRecordCell

@synthesize image;
@synthesize title;
@synthesize time;

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void) setObject:(id)object
{
    PLLookCourse *lookCourse = (PLLookCourse *) object;
    if (![lookCourse.courses.courseName isEqualToString:@""]) {
        self.title.text = lookCourse.courses.courseName;
    }
    
    if (![lookCourse.works.workTitle isEqualToString:@""]) {
        self.title.text = lookCourse.works.workTitle;
    }
    
    self.time.text = lookCourse.watchTime;
}

@end
