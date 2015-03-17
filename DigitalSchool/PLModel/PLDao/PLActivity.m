//
//  PLActivity.m
//  DigitalSchool
//
//  Created by 刘军林 on 15/2/3.
//  Copyright (c) 2015年 刘军林. All rights reserved.
//

#import "PLActivity.h"
#import "PLUser.h"

@implementation PLActivity

@synthesize activityCollectNum;
@synthesize activityDetail;
@synthesize activityEndTime;
@synthesize activityId;
@synthesize activityImg;
@synthesize activityJoinNum;
@synthesize activityName;
@synthesize activityPhone;
@synthesize activityStartTime;
@synthesize activityTips;
@synthesize plUser;

-(id) init
{
    if ([super init]) {
        self.activityCollectNum = @"";
        self.activityDetail = @"";
        self.activityEndTime = @"";
        self.activityId = @"";
        self.activityImg = @"";
        self.activityJoinNum = @"";
        self.activityName = @"";
        self.activityPhone = @"";
        self.activityStartTime = @"";
        self.activityTips = @"";
        self.plUser = [[PLUser alloc]init];
    }
    return self;
}

-(void) setValue:(id)value forUndefinedKey:(NSString *)key
{
    if ([key isEqualToString:@"collectNum"]) {
        self.activityCollectNum = value;
    }
    
    if ([key isEqualToString:@"detail"] || [key isEqualToString:@"intro"])
    {
        self.activityDetail = value;
    }
    
    if ([key isEqualToString:@"endTime"]) {
        self.activityEndTime = value;
    }
    
    if ([key isEqualToString:@"id"]) {
        self.activityId = value;
    }
    
    if ([key isEqualToString:@"img"]) {
        self.activityImg = [NSString stringWithFormat:@"%@%@%@",@"http://",ALL_URL, value];
    }
    
    if ([key isEqualToString:@"joinNum"]) {
        self.activityJoinNum = value;
    }
    
    if ([key isEqualToString:@"name"]) {
        self.activityName = value;
    }
    
    if ([key isEqualToString:@"phone"]) {
        self.activityPhone = value;
    }
    
    if ([key isEqualToString:@"startTime"]) {
        self.activityStartTime = value;
    }
    
    if ([key isEqualToString:@"tips"]) {
        self.activityTips = value;
    }
    if ([key isEqualToString:@"title"])
    {
        self.activityName = value;
    }
    if ([key isEqualToString:@"admin"]|| [key isEqualToString:@"user"]) {
        if ([value isKindOfClass:[NSDictionary class]]) {
            [self.plUser setValuesForKeysWithDictionary:value];
        }
    }
    
}

-(NSString *) description
{
    return [NSString stringWithFormat:@"\nActivity { \n activityCollectNum:%@ \n activitydetail:%@ \n activityEndTime:%@\n activityId:%@\n activityImg:%@ \n activityJoinNum:%@ \n activityName:%@ \n activityPhone:%@ \n activityStartTime:%@ \n tips:%@\n", self.activityCollectNum, self.activityDetail, self.activityEndTime, self.activityId, self.activityImg, self.activityJoinNum, self.activityName, self.activityPhone, self.activityStartTime, self.activityTips];
}

@end
