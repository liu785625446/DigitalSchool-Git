//
//  PLLookCourse.m
//  DigitalSchool
//
//  Created by 刘军林 on 15/1/30.
//  Copyright (c) 2015年 刘军林. All rights reserved.
//

#import "PLLookCourse.h"

@implementation PLLookCourse

@synthesize lookId;
@synthesize userId;
@synthesize watchTime;
@synthesize courses;
@synthesize works;

-(id)init
{
    if ([super init]) {
        self.lookId = @"";
        self.userId = @"";
        self.watchTime = @"";
        self.courses = [[PLCourse alloc] init];
        self.works = [[PLWorks alloc] init];
    }
    return self;
}

-(void) setValue:(id)value forUndefinedKey:(NSString *)key
{
    if ([key isEqualToString:@"id"]) {
        self.lookId = value;
    }
    
    if ([key isEqualToString:@"course"]) {
        [self.courses setValuesForKeysWithDictionary:value];
    }
    
    if ([key isEqualToString:@"work"]) {
        [self.works setValuesForKeysWithDictionary:value];
    }
}

-(NSString *) description
{
    return [NSString stringWithFormat:@"\nPLLookCourse: { \n course:%@ \n userId:%@ \n watchTime:%@ \n } \n",self.courses, self.userId, self.watchTime ];
}

@end
