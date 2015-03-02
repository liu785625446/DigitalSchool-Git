//
//  PLCourseProcess.h
//  DigitalSchool
//
//  Created by 刘军林 on 15/1/27.
//  Copyright (c) 2015年 刘军林. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PLBaseProcess.h"

@interface PLCourseProcess : PLBaseProcess

/**
 *  获取首页课程图片
 *
 *  @param success
 *  @param fail
 */
-(void) getCourseMainImg:(CallBackBlockSuccess)success didFail:(CallBackBlockFail)fail;

/**
 *  获取首页栏目列表
 *
 *  @param success
 *  @param fail
 */
-(void) getMainColumnsList:(int)pageSize didCurrentPage:(int)currentPage didColumnsId:(NSString*)columnsId didColumnsType:(NSString *)columnsType didSuccess:(CallBackBlockSuccess)success didFail:(CallBackBlockFail)fail;

/**
 *  获取栏目下的标题列表
 *
 *  @param success
 *  @param fail    
 */
-(void) getMainColumnsTitleList:(CallBackBlockSuccess)success didFail:(CallBackBlockFail)fail;

///**
// *  获取首页热门课程
// *
// *  @param success
// *  @param fail
// */
//-(void) getCourseHostList:(CallBackBlockSuccess)success didFail:(CallBackBlockFail)fail;
//
///**
// *  获取首页父母课程
// *
// *  @param success 
// *  @param fail
// */
//-(void) getCourseMainParents:(CallBackBlockSuccess) success didFail:(CallBackBlockFail)fail;

///**
// *  获取首页微课程
// *
// *  @param success
// *  @param fail    
// */
//-(void) getCourseMainMicroCourses:(CallBackBlockSuccess)success didFail:(CallBackBlockFail)fail;

/**
 *  筛选课程
 *
 *  @param pageSize    每页大小
 *  @param currentPage 当前页数
 *  @param grade       年级
 *  @param subject     科目
 *  @param teacher     教师
 *  @param type        课程类型
 *  @param success
 *  @param fail
 */
-(void) getCourseFilter:(int)pageSize didCurrentPage:(int)currentPage didGrade:(int)grade didSubject:(int)subject didTeacher:(int)teacher didType:(int)type didSuccess:(CallBackBlockSuccess)success didFail:(CallBackBlockFail)fail;

/**
 *  搜索课程
 *
 *  @param pageSize    每页大小
 *  @param currentPage 当前页数
 *  @param searchStr   搜索关键字
 *  @param success
 *  @param fail
 */
-(void) getCourseSearch:(int)pageSize didCurrentPage:(int)currentPage didSearch:(NSString *)searchStr didSuccess:(CallBackBlockSuccess)success didFail:(CallBackBlockFail)fail;

/**
 *  获取课程筛选条件
 *
 *  @param success
 *  @param fail
 */
-(void) getCourseConditionList:(CallBackBlockSuccess )success didFail:(CallBackBlockFail)fail;

/**
 *  提交课程观看记录
 *
 *  @param courseId 课程ID
 *  @param userId   用户ID
 *  @param success
 *  @param fail
 */
-(void) submitCourseLookRecord:(NSString *)courseId didUser:(NSString *)userId didSuccess:(CallBackBlockSuccess)success didFail:(CallBackBlockFail)fail;

/**
 *  获取课程观看记录
 *
 *  @param userId  用户ID
 *  @param success
 *  @param fail    
 */
-(void) getCourseLookRecord:(NSString *)userId didSuccess:(CallBackBlockSuccess)success didFail:(CallBackBlockFail)fail;

/**
 *  收藏课程
 *
 *  @param courseId 课程ID
 *  @param userId   用户ID
 *  @param success
 *  @param fail     
 */
-(void) attentionCourse:(NSString *)courseId didUser:(NSString *)userId didSuccess:(CallBackBlockSuccess)success didFail:(CallBackBlockFail)fail;

/**
 *  取消收藏
 *
 *  @param courseId 课程ID
 *  @param userId   用户ID
 *  @param success
 *  @param fail     
 */
-(void) cancelAttentionCourse:(NSString *)courseId didUser:(NSString *)userId didSuccess:(CallBackBlockSuccess)success didFail:(CallBackBlockFail)fail;

/**
 *  获取课程收藏列表
 *
 *  @param pageSize    每页大小
 *  @param currentPage 当前页
 *  @param userId      用户ID
 *  @param success
 *  @param fail        
 */
-(void) getAttentionCourse:(int)pageSize didCurrentPage:(int)currentPage diduserId:(NSString *)userId didSuccess:(CallBackBlockSuccess)success didFail:(CallBackBlockFail)fail;

/**
 *  获取相关章节列表
 *
 *  @param gradeId     年纪ID
 *  @param catalogId   目录ID
 *  @param volumesId   册ID
 *  @param success
 *  @param fail
 */
-(void) getChapterCorrelationListdGradeId:(NSString *)gradeId didCatalogId:(NSString *)catalogId didVolumes:(NSString *)volumesId didSuccess:(CallBackBlockSuccess)success didFail:(CallBackBlockFail)fail;

@end
