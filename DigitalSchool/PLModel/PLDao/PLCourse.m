    //
    //  PLCourse.m
    //  PersistenceLayer
    //
    //  Created by 刘军林 on 15/1/7.
    //  Copyright (c) 2015年 刘军林. All rights reserved.
    //

#import "PLCourse.h"

@implementation PLCourse

@synthesize courseId;
@synthesize courseName;
@synthesize courseImgURL;
@synthesize courseVideoURL;
@synthesize courseTime;
@synthesize courseIntroduction;
@synthesize courseContent;
@synthesize courseGrade;
@synthesize courseTeacher;

@synthesize chapterId;
@synthesize gradeId;
@synthesize length;
@synthesize status;
@synthesize subjectId;
@synthesize type;

-(id) init
{
    if ([super init]) {
        courseId = @"";
        courseName = @"";
        courseImgURL = @"";
        courseVideoURL = @"";
        courseTime = @"";
        courseIntroduction = @"";
        courseGrade = @"";
        courseContent = @"";
        courseTeacher = [[PLTeacher alloc] init];
        
        chapterId = @"";
        gradeId = @"";
        length = @"";
        status = @"";
        subjectId = @"";
        type = @"";
    }
    return self;
}

-(void) setValue:(id)value forUndefinedKey:(NSString *)key
{
    if ([key isEqualToString:@"id"]) {
        self.courseId = value;
    }
    
    if ([key isEqualToString:@"img"]) {
        self.courseImgURL = [NSString stringWithFormat:@"%@%@%@",@"http://",ALL_URL, value];
    }
    
    if ([key isEqualToString:@"content"] || [key isEqualToString:@"intro"])
    {
        self.courseContent = value;
    }
    
    if ([key isEqualToString:@"grade"]) {
        self.courseGrade = value;
    }
    
    if ([key isEqualToString:@"title"]) {
        self.courseName = value;
    }
    
    if ([key isEqualToString:@"introduction"]) {
        self.courseIntroduction = value;
    }
    
    if ([key isEqualToString:@"updateTime"]) {
        self.courseTime = value;
    }
    if ([key isEqualToString:@"url"])
    {
        self.courseVideoURL = [NSString stringWithFormat:@"%@%@%@",@"http://",ALL_URL, value];;
    }
    
    if ([key isEqualToString:@"teacher"]) {
        NSDictionary *dic = (NSDictionary *)value;
        [self.courseTeacher setValuesForKeysWithDictionary:dic];
    }
}

-(NSString *)description
{
    return [NSString stringWithFormat:@"PLCourse { \n courseId:%@ \n courseName:%@ \n courseImgURL:%@ \n courseVideoURL:%@ \n courseTime:%@ \n courseSummary:%@ \n courseGrade:%@ \n courseContent:%@ \n courseTeacher:%@ \n} \n",self.courseId, self.courseName, self.courseImgURL, self.courseVideoURL, self.courseTime, self.courseIntroduction, self.courseGrade, self.courseContent, self.courseTeacher];
}
@end
