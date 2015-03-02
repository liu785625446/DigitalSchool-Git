//
//  PLWorks.m
//  DigitalSchool
//
//  Created by 刘军林 on 15/1/27.
//  Copyright (c) 2015年 刘军林. All rights reserved.
//

#import "PLWorks.h"

@implementation PLWorks

@synthesize workId;
@synthesize workImg;
@synthesize workTitle;
@synthesize workUpdateTime;
@synthesize workURL;
@synthesize workWatchNum;
@synthesize user;
@synthesize workIntro;

-(id) init
{
    if ([super init]) {
        self.workId = @"";
        self.workImg = @"";
        self.workTitle = @"";
        self.workUpdateTime = @"";
        self.workURL = @"";
        self.workWatchNum = @"";
        self.workIntro =@"";
        self.user = [[PLUser alloc] init];
    }
    return self;
}

-(void) setValue:(id)value forUndefinedKey:(NSString *)key
{
    if ([key isEqualToString:@"activityId"]) {
        self.workId = value;
    }
    if ([key isEqualToString:@"id"]) {
        
    }
    if ([key isEqualToString:@"img"]) {
        self.workImg = [NSString stringWithFormat:@"%@%@%@",@"http://",ALL_URL, value];
    }
    if ([key isEqualToString:@"title"]) {
        self.workTitle = value;
    }
    if ([key isEqualToString:@"updateTime"]) {
        self.workUpdateTime = value;
    }
    if ([key isEqualToString:@"url"]) {
        self.workURL = [NSString stringWithFormat:@"%@%@%@",@"http://",ALL_URL, value];
    }
    if ([key isEqualToString:@"watchNum"]) {
        self.workWatchNum = value;
    }
    if ([key isEqualToString:@"admin"]) {
        NSDictionary *dic = (NSDictionary *)value;
        [self.user setValuesForKeysWithDictionary:dic];
    }
    if ([key isEqualToString:@"intro"]) {
        self.workIntro = value;
    }
}

-(NSString *)description
{
    return [NSString stringWithFormat:@" \n Works: { \n workId:%@ \n workImg:%@ \n workTitle:%@ \n workUpdateTime:%@ \n workURL:%@ \n workwatchNum:%@ \n user:%@ \n } \n ", self.workId, self.workImg, self.workTitle, self.workUpdateTime, self.workURL, self.workWatchNum, self.user];
}

@end
