//
//  PLRecommendCourse.h
//  DigitalSchool
//
//  Created by 刘军林 on 15/2/10.
//  Copyright (c) 2015年 刘军林. All rights reserved.
//

#import "PLBaseData.h"
#import "PLCourse.h"

@interface PLRecommendCourse : PLBaseData

@property (nonatomic, strong) NSString *courseId;
@property (nonatomic, strong) NSString *recommendId;
@property (nonatomic, strong) NSString *recommendImg;
@property (nonatomic, strong) PLCourse *plCourse;

@end
