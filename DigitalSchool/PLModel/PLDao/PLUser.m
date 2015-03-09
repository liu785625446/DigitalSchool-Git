//
//  PLUser.m
//  DigitalSchool
//
//  Created by 刘军林 on 15/1/27.
//  Copyright (c) 2015年 刘军林. All rights reserved.
//

#import "PLUser.h"

@implementation PLUser

@synthesize userAge;
@synthesize userCreateTime;
@synthesize userId;
@synthesize userImg;
@synthesize userName;
@synthesize userNickName;
@synthesize userSafeQuestion;
@synthesize userStatus;
@synthesize userUpdateTime;

-(id) init
{
    if ([super init]) {
        self.userAge = @"";
        self.userCreateTime = @"";
        self.userId = @"";
        self.userImg = @"";
        self.userName = @"";
        self.userNickName = @"";
        self.userSafeQuestion = @"";
        self.userStatus = @"";
        self.userUpdateTime = @"";
    }
    return self;
}

-(void) setValue:(id)value forUndefinedKey:(NSString *)key
{
    if ([key isEqualToString:@"age"]) {
        self.userAge = value;
    }
    
    if ([key isEqualToString:@"createTime"]) {
        self.userCreateTime = value;
    }
    
    if ([key isEqualToString:@"id"]) {
        self.userId = value;
    }
    
    if ([key isEqualToString:@"img"]) {
        self.userImg = [NSString stringWithFormat:@"%@%@%@",@"http://",ALL_URL, value];
    }
    
    if ([key isEqualToString:@"nickName"]) {
        self.userNickName = value;
    }
    
    if ([key isEqualToString:@"safeQuestion"]) {
        self.userSafeQuestion = value;
    }
    
    if ([key isEqualToString:@"status"]) {
        self.userStatus = value;
    }
    
    if ([key isEqualToString:@"updateTime"]) {
        self.userUpdateTime = value;
    }
    
    if ([key isEqualToString:@"username"]) {
        self.userName = value;
    }
    
    if ([key isEqualToString:@"type"]) {
        self.userType = value;
    }
}

-(id) initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super init]) {
        self.userId = [aDecoder decodeObjectForKey:@"userId"];
        self.userAge = [aDecoder decodeObjectForKey:@"userAge"];
        self.userCreateTime = [aDecoder decodeObjectForKey:@"createTime"];
        self.userImg = [aDecoder decodeObjectForKey:@"userImg"];
        self.userNickName = [aDecoder decodeObjectForKey:@"userNickName"];
        self.userSafeQuestion = [aDecoder decodeObjectForKey:@"userSafeQuestion"];
        self.userStatus = [aDecoder decodeObjectForKey:@"userStatus"];
        self.userUpdateTime = [aDecoder decodeObjectForKey:@"userUpdateTime"];
        self.userName = [aDecoder decodeObjectForKey:@"userName"];
        self.userType = [aDecoder decodeObjectForKey:@"userType"];
    }
    return self;
}

-(void) encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self.userId forKey:@"userId"];
    [aCoder encodeObject:self.userAge forKey:@"userAge"];
    [aCoder encodeObject:self.userCreateTime forKey:@"createTime"];
    [aCoder encodeObject:self.userImg forKey:@"userImg"];
    [aCoder encodeObject:self.userNickName forKey:@"userNickName"];
    [aCoder encodeObject:self.userSafeQuestion forKey:@"userSafeQuestion"];
    [aCoder encodeObject:self.userStatus forKey:@"userStatus"];
    [aCoder encodeObject:self.userUpdateTime forKey:@"userUpdateTime"];
    [aCoder encodeObject:self.userName forKey:@"userName"];
    [aCoder encodeObject:self.userType forKey:@"userType"];
}

-(NSString *) description
{
    return [NSString stringWithFormat:@"\n User { \n userAge:%@ \n userCreateTime:%@ \n userId:%@ \n userImg:%@ \n userNickName:%@ \n userSafeQuestion:%@ \n userStatus:%@ \n userUpdateTime:%@ \n userName:%@\n userType:%@\n} \n",self.userAge, self.userCreateTime, self.userId, self.userImg, self.userNickName, self.userSafeQuestion, self.userStatus, self.userUpdateTime, self.userName, self.userType];
}

@end
