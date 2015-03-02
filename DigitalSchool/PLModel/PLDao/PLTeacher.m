//
//  PLTeacher.m
//  DigitalSchool
//
//  Created by 刘军林 on 15/1/29.
//  Copyright (c) 2015年 刘军林. All rights reserved.
//

#import "PLTeacher.h"

@implementation PLTeacher

@synthesize teacherId;
@synthesize teacherImg;
@synthesize teacherIntroduction;
@synthesize teacherName;

-(id) init
{
    if ([super init]) {
        self.teacherId = @"";
        self.teacherImg = @"";
        self.teacherIntroduction = @"";
        self.teacherName = @"";
    }
    return self;
}

-(void) setValue:(id)value forUndefinedKey:(NSString *)key
{
    if ([key isEqualToString:@"id"]) {
        self.teacherId = value;
    }
    
    if ([key isEqualToString:@"img"]) {
        self.teacherImg = [NSString stringWithFormat:@"%@%@%@",@"http://",ALL_URL, value];
    }
    
    if ([key isEqualToString:@"introduction"]) {
        self.teacherIntroduction = value;
    }
    
    if ([key isEqualToString:@"name"]) {
        self.teacherName = value;
    }
}

-(NSString *) description
{
    return [NSString stringWithFormat:@"teacher: \n { teacherName: %@ \n teacherIntroduction:%@ \n teacherImg:%@ \n } \n", self.teacherName, self.teacherIntroduction, self.teacherImg];
}

@end
