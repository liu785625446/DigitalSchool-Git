    //
    //  PLCourse.h
    //  PersistenceLayer
    //
    //  Created by 刘军林 on 15/1/7.
    //  Copyright (c) 2015年 刘军林. All rights reserved.
    //

#import <Foundation/Foundation.h>
#import "PLBaseData.h"
#import "PLTeacher.h"
    //课程表

@interface PLCourse : PLBaseData

@property (nonatomic, strong) NSString *courseId;
@property (nonatomic, strong) NSString *courseName;
@property (nonatomic, strong) NSString *courseImgURL;
@property (nonatomic, strong) NSString *courseVideoURL;
@property (nonatomic, strong) NSString *courseTime;
@property (nonatomic, strong) NSString *courseIntroduction;
@property (nonatomic, strong) NSString *courseContent;
@property (nonatomic, strong) NSString *courseGrade;
@property (nonatomic, strong) PLTeacher *courseTeacher;

@property (nonatomic, strong) NSString *chapterId;
@property (nonatomic, strong) NSString *gradeId;
@property (nonatomic, strong) NSString *length;
@property (nonatomic, strong) NSString *status;
@property (nonatomic, strong) NSString *subjectId;
@property (nonatomic, strong) NSString *type;

@end
