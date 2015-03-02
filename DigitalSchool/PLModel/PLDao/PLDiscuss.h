//
//  PLDiscuss.h
//  DigitalSchool
//
//  Created by 刘军林 on 15/1/30.
//  Copyright (c) 2015年 刘军林. All rights reserved.
//

#import "PLBaseData.h"
#import "PLUser.h"

@interface PLDiscuss : PLBaseData

@property (nonatomic, strong) NSString *discussContent;
@property (nonatomic, strong) NSString *discussCreateTime;
@property (nonatomic, strong) NSString *courseId;
@property (nonatomic, strong) NSString *discussId;
@property (nonatomic, strong) PLUser *pluser;

@end
