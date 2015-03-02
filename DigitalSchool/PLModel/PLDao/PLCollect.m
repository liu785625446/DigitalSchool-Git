//
//  PLCollect.m
//  DigitalSchool
//
//  Created by 刘军林 on 15/2/11.
//  Copyright (c) 2015年 刘军林. All rights reserved.
//

#import "PLCollect.h"

@implementation PLCollect

@synthesize attentionTime;
@synthesize userId;
@synthesize activitys;
@synthesize courses;

-(id) init{
    if ([super init]) {
        attentionTime = @"";
        userId = @"";
        activitys = [[PLActivity alloc] init];
        courses = [[PLCourse alloc] init];
    }
    return self;
}

-(void) setValue:(id)value forUndefinedKey:(NSString *)key
{
    if ([key isEqualToString:@"course"]) {
        [self.courses setValuesForKeysWithDictionary:value];
    }
    
    if ([key isEqualToString:@"activity"]) {
        [self.activitys setValuesForKeysWithDictionary:value];
    }
}

@end
