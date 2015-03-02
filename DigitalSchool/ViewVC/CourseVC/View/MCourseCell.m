//
//  MCourseCell.m
//  DigitalScholl
//
//  Created by rachel on 15/1/8.
//  Copyright (c) 2015年 刘军林. All rights reserved.
//

#import "MCourseCell.h"
#import "PLActivity.h"
#import "PLWorks.h"

@implementation MCourseCell

-(void) setBaseModel:(PLBaseData *)baseModel
{
    if ([baseModel isKindOfClass:[PLCourse class]]) {
        PLCourse *course = (PLCourse *) baseModel;
        [self.iconImage setImageWithURL:[NSURL URLWithString:course.courseImgURL] placeholderImage:[UIImage imageNamed:@"MCourseDefalut.png"]];
        self.titleLabel.text = course.courseName;
        self.contentLabel.text = course.courseContent;
    }else if ([baseModel isKindOfClass:[PLActivity class]])
    {
        PLActivity *activity = (PLActivity *) baseModel;
        [self.iconImage setImageWithURL:[NSURL URLWithString:activity.activityImg] placeholderImage:[UIImage imageNamed:@"MCourseDefalut.png"]];
        self.titleLabel.text = activity.activityName;
        self.contentLabel.text = activity.activityDetail;
    }else if ([baseModel isKindOfClass:[PLWorks class]]) {
        PLWorks *works = (PLWorks *) baseModel;
        [self.iconImage setImageWithURL:[NSURL URLWithString:works.workImg] placeholderImage:[UIImage imageNamed:@"MCourseDefalut.png"]];
        self.titleLabel.text = works.workTitle;
        self.contentLabel.text = works.workIntro;
    }
}

@end
