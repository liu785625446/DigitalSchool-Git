//
//  PLUser.h
//  DigitalSchool
//
//  Created by 刘军林 on 15/1/27.
//  Copyright (c) 2015年 刘军林. All rights reserved.
//

#import "PLBaseData.h"

//用户表

@interface PLUser : PLBaseData

@property (nonatomic, strong) NSString *userAge;
@property (nonatomic, strong) NSString *userCreateTime;
@property (nonatomic, strong) NSString *userId;
@property (nonatomic, strong) NSString *userImg;
@property (nonatomic, strong) NSString *userNickName;
@property (nonatomic, strong) NSString *userSafeQuestion;
@property (nonatomic, strong) NSString *userStatus;
@property (nonatomic, strong) NSString *userUpdateTime;
@property (nonatomic, strong) NSString *userName;

@end
