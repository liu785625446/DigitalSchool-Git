//
//  PLCollect.h
//  DigitalSchool
//
//  Created by 刘军林 on 15/2/11.
//  Copyright (c) 2015年 刘军林. All rights reserved.
//

#import "PLBaseData.h"
#import "PLActivity.h"
#import "PLCourse.h"

@interface PLCollect : PLBaseData

@property (nonatomic, strong) NSString *attentionTime;
@property (nonatomic, strong) PLCourse *courses;
@property (nonatomic, strong) PLActivity *activitys;
@property (nonatomic, strong) NSString *userId;

@end
