//
//  PLDiscussProcess.h
//  DigitalSchool
//
//  Created by 刘军林 on 15/1/30.
//  Copyright (c) 2015年 刘军林. All rights reserved.
//

#import "PLBaseProcess.h"

@interface PLDiscussProcess : PLBaseProcess

/**
 *  获取课程评论列表
 *
 *  @param pageSize    页面大小
 *  @param currentPage 当前页面
 *  @param courseId    课程id
 *  @param success
 *  @param fail
 */
-(void) getCourseDiscussList:(int)pageSize didCurrentPage:(int)currentPage didCourseId:(NSString *)courseId didSuccess:(CallBackBlockSuccess)success didFail:(CallBackBlockFail)fail;

/**
 *  获取作品评论列表
 *
 *  @param pageSize
 *  @param currentPage
 *  @param courseId
 *  @param success
 *  @param fail
 */
-(void) getWorksDiscussList:(int)pageSize didCurrentPage:(int)currentPage didCourseId:(NSString *)courseId didSuccess:(CallBackBlockSuccess)success didFail:(CallBackBlockFail)fail;

/**
 *  评论课程
 *
 *  @param courseId       课程id
 *  @param userId         用户id
 *  @param discussContent 评论内容
 *  @param success
 *  @param fail
 */
-(void) launchCourseDiscuss:(NSString *)courseId didUserId:(NSString *)userId didContent:(NSString *)discussContent didSuccess:(CallBackBlockSuccess)success didFail:(CallBackBlockFail)fail;

/**
 *  评论作品
 *
 *  @param workId
 *  @param userId
 *  @param discussContent
 *  @param success
 *  @param fail
 */
-(void) launchWorksDiscuss:(NSString *)workId didUserId:(NSString *)userId didContent:(NSString *)discussContent didSuccess:(CallBackBlockSuccess)success didFail:(CallBackBlockFail)fail;

/**
 *  回复课程评论
 *
 *  @param userId    用户id
 *  @param discussId 课程id
 *  @param content   评论内容
 *  @param success
 *  @param fail
 */
-(void) replyDiscuss:(NSString *)userId didDiscuss:(NSString *)discussId didContent:(NSString *)content didSuccess:(CallBackBlockSuccess)success didFail:(CallBackBlockFail)fail;

/**
 *  回复作品评论
 *
 *  @param userId
 *  @param discussId
 *  @param content
 *  @param success
 *  @param fail
 */
-(void) replyWorks:(NSString *)userId didDiscuss:(NSString *)discussId didContent:(NSString *)content didSuccess:(CallBackBlockSuccess)success didFail:(CallBackBlockFail)fail;

/**
 *  评论活动
 *
 *  @param activityId 活动ID
 *  @param userId     用户id
 *  @param content    评论内容
 *  @param success
 *  @param fail
 */
-(void) commentActivityDiscuss:(NSString *)activityId didUserId:(NSString *)userId didContent:(NSString *)content didSuccess:(CallBackBlockSuccess)success didFail:(CallBackBlockFail)fail;

/**
 *  获取活动评论列表
 *
 *  @param pageSize
 *  @param currentPage
 *  @param activityId
 *  @param success
 *  @param fail
 */
-(void) getActivityDiscussList:(int)pageSize didCurrentPage:(int)currentPage didActivityId:(NSString *)activityId didSuccess:(CallBackBlockSuccess)success didFail:(CallBackBlockFail)fail;
@end
