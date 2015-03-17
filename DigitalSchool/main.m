//
//  main.m
//  DigitalSchool
//
//  Created by 刘军林 on 15/1/16.
//  Copyright (c) 2015年 刘军林. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"

#import "PLChapterProcess.h"
#import "PLWorkProcess.h"
#import "PLDiscussProcess.h"
#import "PLCourseProcess.h"
#import "PLNotesProcess.h"
#import "PLUserProcess.h"
#import "PLNavsProcess.h"

int main(int argc, char * argv[]) {
    
    //课程
    PLCourseProcess *courseProcess = [[PLCourseProcess alloc] init];
    [courseProcess getCourseMainImg:^(NSMutableArray *array) {
        
    } didFail:^(NSString *error) {
        
    }];
    
//    [courseProcess getCourseHostList:^(NSMutableArray *array) {
//        
//    } didFail:^(NSString *error) {
//        
//    }];
//
//    [courseProcess getCourseMainParents:^(NSMutableArray *array) {
//        
//    } didFail:^(NSString *error) {
//        
//    }];
//    
//    [courseProcess getCourseMainMicroCourses:^(NSMutableArray *array) {
//        
//    } didFail:^(NSString *error) {
//        
//    }];
//     
//    [courseProcess getCourseFilter:10 didCurrentPage:1 didGrade:1 didSubject:1 didTeacher:1 didType:0 didSuccess:^(NSMutableArray *array) {
//        
//    } didFail:^(NSString *error) {
//        
//    }];
//    
//    [courseProcess getCourseSearch:10 didCurrentPage:1 didSearch:@"课程" didSuccess:^(NSMutableArray *array) {
//        
//    } didFail:^(NSString *error) {
//        
//    }];
//    
//    [courseProcess getCourseConditionList:^(NSMutableArray *array) {
//        
//    } didFail:^(NSString *error) {
//        
//    }];
//    
//    [courseProcess submitCourseLookRecord:@"1" didUser:@"1" didSuccess:^(NSMutableArray *array) {
//        
//    } didFail:^(NSString *error) {
//        
//    }];
//    
//    [courseProcess getCourseLookRecord:@"1" didSuccess:^(NSMutableArray *array) {
//        
//    } didFail:^(NSString *error) {
//        
//    }];
//    
//    [courseProcess attentionCourse:@"1" didUser:@"1" didSuccess:^(NSMutableArray *array) {
//        
//    } didFail:^(NSString *error) {
//        
//    }];
//    
//    [courseProcess cancelAttentionCourse:@"1" didUser:@"1" didSuccess:^(NSMutableArray *array) {
//        
//    } didFail:^(NSString *error) {
//        
//    }];
//    
//    [courseProcess getAttentionCourse:1 didCurrentPage:1 diduserId:@"1" didSuccess:^(NSMutableArray *array) {
//        
//    } didFail:^(NSString *error) {
//        
//    }];
    
    
    //讨论
//    PLDiscussProcess *discussProcess = [[PLDiscussProcess alloc] init];
//    [discussProcess getCourseDiscussList:10 didCurrentPage:1 didCourseId:@"1" didSuccess:^(NSMutableArray *array) {
//        
//    } didFail:^(NSString *error) {
//        
//    }];
//    
//    [discussProcess getWorksDiscussList:10 didCurrentPage:1 didCourseId:@"1" didSuccess:^(NSMutableArray *array) {
//        
//    } didFail:^(NSString *error) {
//        
//    }];
//    
//    [discussProcess launchCourseDiscuss:@"1" didUserId:@"1" didContent:@"课程" didSuccess:^(NSMutableArray *array) {
//        
//    } didFail:^(NSString *error) {
//        
//    }];
//    
//    [discussProcess launchWorksDiscuss:@"1" didUserId:@"1" didContent:@"课程" didSuccess:^(NSMutableArray *array) {
//        
//    } didFail:^(NSString *error) {
//        
//    }];
//    
//    [discussProcess replyDiscuss:@"1" didDiscuss:@"1" didContent:@"课程测试" didSuccess:^(NSMutableArray *array) {
//        
//    } didFail:^(NSString *error) {
//        
//    }];
//    
//    [discussProcess replyWorks:@"1" didDiscuss:@"1" didContent:@"课程测试" didSuccess:^(NSMutableArray *array) {
//        
//    } didFail:^(NSString *error) {
//        
//    }];
//    
//    [discussProcess commentActivityDiscuss:@"1" didUserId:@"1" didContent:@"课程测试" didSuccess:^(NSMutableArray *array) {
//        
//    } didFail:^(NSString *error) {
//        
//    }];

    
    //章节
//    PLChapterProcess *chapter = [[PLChapterProcess alloc] init];
//    [chapter getChapterCorrelationListdGradeId:@"6" didCatalogId:@"2" didVolumes:@"1" didSuccess:^(NSMutableArray *array) {
//        
//    } didFail:^(NSString *error) {
//        
//    }];
    
    //作品
//    PLWorkProcess *works = [[PLWorkProcess alloc] init];
//    [works getMainAwardWorks:^(NSMutableArray *array) {
//        
//    } didFail:^(NSString *error) {
//        
//    }];
//    
//    [works getActivityWorksList:10 didCurrentPage:1 didActivityId:@"1" didType:0 didSuccess:^(NSMutableArray *array) {
//        
//    } didFail:^(NSString *error) {
//        
//    }];
//    
//    [works getWorksLookRecord:@"1" didSuccess:^(NSMutableArray *array) {
//        
//    } didFail:^(NSString *error) {
//        
//    }];
    
    //笔记
//    PLNotesProcess *notesProcess = [[PLNotesProcess alloc] init];
//    [notesProcess getCourseNotesList:10 didCurrentPage:1 didCourseId:@"1" didSuccess:^(NSMutableArray *array) {
//        
//    } didFail:^(NSString *error) {
//        
//    }];
//    
//    [notesProcess praiseNotes:@"1" didUser:@"1" didSuccess:^(NSMutableArray *array) {
//        
//    } didFail:^(NSString *error) {
//        
//    }];
//    
//    [notesProcess noteWrite:@"1" didCourseId:@"1" didContent:@"课程测试" didSuccess:^(NSMutableArray *array) {
//        
//    } didFail:^(NSString *error) {
//        
//    }];
    
//    PLUserProcess *userProcess = [[PLUserProcess alloc] init];
//    [userProcess rigesterUserName:@"ios123" didPassword:@"ios123" didNickName:@"ios测试" didUserType:@"1" didSuccess:^(NSMutableArray *array) {
//        
//    } didFail:^(NSString *error) {
//        
//    }];
    
//    [userProcess loginUserName:@"123456" didPassword:@"123456" didSuccess:^(NSMutableArray *array) {
//        
//    } didFail:^(NSString *error) {
//        
//    }];
//    
//    [userProcess modifyNickName:@"update" didUserId:@"402880e64bf71785014bf88229490000" didSuccess:^(NSMutableArray *array) {
//        
//    } didFail:^(NSString *error) {
//        
//    }];
//    
//    [userProcess modifyPassword:@"402880e64bf71785014bf88229490000" didOldPassword:@"123456" didNewPassword:@"654321" didSuccess:^(NSMutableArray *array) {
//        
//    } didFail:^(NSString *error) {
//        
//    }];
    
//    PLNavsProcess *nav = [[PLNavsProcess alloc] init];
//    [nav getNavsList:^(NSMutableArray *array) {
//        
//    } didFail:^(NSString *error) {
//        
//    }];
    
    @autoreleasepool {
        return UIApplicationMain(argc, argv, nil, NSStringFromClass([AppDelegate class]));
    }
}
