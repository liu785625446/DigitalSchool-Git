//
//  PLRecommendCourse.m
//  DigitalSchool
//
//  Created by 刘军林 on 15/2/10.
//  Copyright (c) 2015年 刘军林. All rights reserved.
//

#import "PLRecommendCourse.h"

@implementation PLRecommendCourse
@synthesize courseId;
@synthesize recommendImg;
@synthesize recommendId;
@synthesize plCourse;

-(id) init
{
    if ([super init]) {
        self.courseId = @"";
        self.recommendId = @"";
        self.plCourse = [[PLCourse alloc] init];
        self.recommendImg = @"";
    }
    return self;
}

-(void) setValue:(id)value forUndefinedKey:(NSString *)key
{
    if ([key isEqualToString:@"courseId"]) {
        self.courseId = value;
    }
    
    if ([key isEqualToString:@"id"]) {
        self.recommendId = value;
    }
    
    if ([key isEqualToString:@"img"]) {
        self.recommendImg = [NSString stringWithFormat:@"%@%@%@",@"http://",ALL_URL, value];
    }
    
    if ([key isEqualToString:@"course"]) {
        [self.plCourse setValuesForKeysWithDictionary:value];
    }
}

-(NSString *) description
{
    return [NSString stringWithFormat:@"PLRecommendCourse: { \n courseId:%@ \n recommendId:%@ \n recommendImg:%@ \n course:%@ \n } \n ", self.courseId, self.recommendId, self.recommendImg, self.plCourse];
}

@end
