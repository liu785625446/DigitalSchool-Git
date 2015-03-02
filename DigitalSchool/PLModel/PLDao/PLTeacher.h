//
//  PLTeacher.h
//  DigitalSchool
//
//  Created by 刘军林 on 15/1/29.
//  Copyright (c) 2015年 刘军林. All rights reserved.
//

#import "PLBaseData.h"

@interface PLTeacher : PLBaseData

@property (nonatomic, strong) NSString *teacherId;
@property (nonatomic, strong) NSString *teacherImg;
@property (nonatomic, strong) NSString *teacherIntroduction;
@property (nonatomic, strong) NSString *teacherName;

@end
