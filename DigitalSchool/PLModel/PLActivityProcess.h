//
//  PLActivityProcess.h
//  DigitalSchool
//
//  Created by 刘军林 on 15/2/3.
//  Copyright (c) 2015年 刘军林. All rights reserved.
//

#import "PLBaseProcess.h"

@interface PLActivityProcess : PLBaseProcess

/**
 *  获取活动列表
 *
 *  @param pageSize    页面大小
 *  @param currentPage 当前页面
 *  @param success
 *  @param fail
 */
-(void) getActivityList:(int)pageSize didCurrentPage:(int)currentPage didSuccess:(CallBackBlockSuccess)success didFail:(CallBackBlockFail)fail;

/**
 *  活动收藏
 *
 *  @param activityId 活动id
 *  @param userId     用户id
 *  @param success
 *  @param fail
 */
-(void)activityCollect:(NSString *)activityId didUserID:(NSString *)userId didSuccess:(CallBackBlockSuccess)success didFail:(CallBackBlockFail)fail;

/**
 *  取消活动收藏
 *
 *  @param Id      收藏id
 *  @param userId  用户id
 *  @param success
 *  @param fail
 */
-(void) activityCancelCollect:(NSString *)Id didUserId:(NSString *)userId didSuccess:(CallBackBlockSuccess)success didFail:(CallBackBlockFail)fail;

/**
 *  活动收藏列表
 *
 *  @param pageSize    页面大小
 *  @param currentPage 当前页面
 *  @param userId      用户id
 *  @param success
 *  @param fail
 */
-(void) activityAttentions:(int )pageSize didCurrentPage:(int )currentPage didUserId:(NSString *)userId didSuccess:(CallBackBlockSuccess)success didFail:(CallBackBlockFail)fail;

@end
