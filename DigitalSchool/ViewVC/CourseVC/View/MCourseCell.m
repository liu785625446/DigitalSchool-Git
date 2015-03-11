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
    if ([baseModel isKindOfClass:[PLCourse class]])
    {
        PLCourse *course = (PLCourse *) baseModel;
        [self setImgUrl:course.courseImgURL
                  title:course.courseName
                content:course.courseContent];
        
    }else if ([baseModel isKindOfClass:[PLActivity class]])
    {
        PLActivity *activity = (PLActivity *) baseModel;
        [self setImgUrl:activity.activityImg
                  title:activity.activityName
                content:activity.activityDetail];
        
    }else if ([baseModel isKindOfClass:[PLWorks class]])
    {
        
        PLWorks *works = (PLWorks *) baseModel;
        [self setImgUrl:works.workImg
                  title:works.workTitle
                content:works.workIntro];
    }
}

-(void)setImgUrl:(NSString*)url title:(NSString *)title content:(NSString *)content
{
    self.titleLabel.text = title;
    self.contentLabel.text = content;
    [self.iconImage setImageWithURL:[NSURL URLWithString:url]
                   placeholderImage:[UIImage imageNamed:@"MCourseDefalut.png"]];
    
}

@end
