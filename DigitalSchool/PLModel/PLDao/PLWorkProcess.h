//
//  PLWorkProcess.h
//  DigitalSchool
//
//  Created by 刘军林 on 15/1/27.
//  Copyright (c) 2015年 刘军林. All rights reserved.
//

#import "PLBaseProcess.h"

@interface PLWorkProcess : PLBaseProcess

/**
 *  获取首页获奖作品
 *
 *  @param success
 *  @param fail
 */
-(void) getMainAwardWorks:(CallBackBlockSuccess)success didFail:(CallBackBlockFail)fail;

/**
 *  获取活动作品列表
 *
 *  @param pageSize    页面大小
 *  @param currentPage 当前页面
 *  @param activityId  活动id
 *  @param type        活动类型 0 全部 1获奖
 *  @param success
 *  @param fail        
 */
-(void) getActivityWorksList:(int)pageSize didCurrentPage:(int)currentPage didActivityId:(NSString *)activityId didType:(int)type didSuccess:(CallBackBlockSuccess)success didFail:(CallBackBlockFail)fail;

/**
 *  获取作品观看记录
 *
 *  @param userId
 *  @param success
 *  @param fail
 */
-(void) getWorksLookRecord:(NSString *)userId didSuccess:(CallBackBlockSuccess)success didFail:(CallBackBlockFail)fail;
@end
