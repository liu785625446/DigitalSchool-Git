//
//  PLDiscuss.m
//  DigitalSchool
//
//  Created by 刘军林 on 15/1/30.
//  Copyright (c) 2015年 刘军林. All rights reserved.
//

#import "PLDiscuss.h"

@implementation PLDiscuss

@synthesize discussContent;
@synthesize discussCreateTime;
@synthesize discussId;
@synthesize courseId;
@synthesize pluser;

-(id ) init
{
    if ([super init]) {
        pluser = [[PLUser alloc] init];
    }
    return self;
}

-(void) setValue:(id)value forUndefinedKey:(NSString *)key
{
    if ([key isEqualToString:@"content"]) {
        self.discussContent = value;
    }
    
    if ([key isEqualToString:@"createTime"]) {
        self.discussCreateTime = value;
    }
    
    if ([key isEqualToString:@"id"]) {
        self.discussId = value;
    }
    
    if ([key isEqualToString:@"admin"] || [key isEqualToString:@"user"]) {
        [self.pluser setValuesForKeysWithDictionary:value];
    }
}

-(NSString *)description
{
    return [NSString stringWithFormat:@"\nDiscuss \n { \n discussContent:%@ \n discussCreateTime:%@ \n discussId:%@ \n courseId:%@ \n user:%@\n",self.discussContent, self.discussCreateTime, self.discussId,self.courseId, self.pluser];
}

@end
