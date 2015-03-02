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
}

-(NSString *) description
{
    return [NSString stringWithFormat:@"\n User { \n userAge:%@ \n userCreateTime:%@ \n userId:%@ \n userImg:%@ \n userNickName:%@ \n userSafeQuestion:%@ \n userStatus:%@ \n userUpdateTime:%@ \n userName:%@\n} \n",self.userAge, self.userCreateTime, self.userId, self.userImg, self.userNickName, self.userSafeQuestion, self.userStatus, self.userUpdateTime, self.userName];
}

@end
