//
//  PLNotesProcess.h
//  DigitalSchool
//
//  Created by 刘军林 on 15/2/2.
//  Copyright (c) 2015年 刘军林. All rights reserved.
//

#import "PLBaseProcess.h"

@interface PLNotesProcess : PLBaseProcess

/**
 *  获取课程笔记列表
 *
 *  @param pageSize    页面大小
 *  @param currentPage 当前页面
 *  @param courseId    课程id
 *  @param success
 *  @param fail
 */
-(void) getCourseNotesList:(int)pageSize didCurrentPage:(int)currentPage didCourseId:(NSString *)courseId didSuccess:(CallBackBlockSuccess)success didFail:(CallBackBlockFail)fail;

/**
 *  赞笔记
 *
 *  @param noteId  笔记id
 *  @param userId  用户id
 *  @param success
 *  @param fail
 */
-(void) praiseNotes:(NSString *)noteId didUser:(NSString *)userId didSuccess:(CallBackBlockSuccess)success didFail:(CallBackBlockFail)fail;
/**
 *  发表笔记
 *
 *  @param noteId  笔记id
 *  @param userId  用户id
 *  @param contentId 笔记内容
 *  @param success
 *  @param fail
 */
-(void) noteWrite:(NSString *)userId didCourseId:(NSString *)courseId didContent:(NSString *)contentId didSuccess:(CallBackBlockSuccess)success didFail:(CallBackBlockFail)fail;
@end
