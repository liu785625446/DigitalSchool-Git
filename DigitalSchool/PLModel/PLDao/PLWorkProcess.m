//
//  PLWorkProcess.m
//  DigitalSchool
//
//  Created by 刘军林 on 15/1/27.
//  Copyright (c) 2015年 刘军林. All rights reserved.
//

#import "PLWorkProcess.h"
#import "PLWorks.h"
#import "PLLookCourse.h"

@implementation PLWorkProcess

-(void) getMainAwardWorks:(CallBackBlockSuccess)success didFail:(CallBackBlockFail)fail
{
    [PLInterface startRequest:ALL_URL didUrl:WORK_AWARD([BLTool getKeyCode:@""]) didParam:nil didSuccess:^(id result){
        [self dataFormat:result didClass:NSStringFromClass([PLWorks class]) didSuccess:success didFail:fail];
    }didFail:^(NSString *error){
        fail(REQUEST_ERROR);
    }];
}

-(void) getActivityWorksList:(int)pageSize didCurrentPage:(int)currentPage didActivityId:(NSString *)activityId didType:(int)type didSuccess:(CallBackBlockSuccess)success didFail:(CallBackBlockFail)fail
{
    NSString *code = [BLTool getKeyCode:[NSString stringWithFormat:@"%d%d%@%d",pageSize, currentPage, activityId, type]];
    NSString *url = [NSString stringWithFormat:@"%d/%d/%@/%d/%@",pageSize, currentPage, activityId, type, code];
    
    [PLInterface startRequest:ALL_URL didUrl:ACTIVITY_WORKS(url) didParam:nil didSuccess:^(id result){
        [self dataFormat:result didClass:NSStringFromClass([PLWorks class]) didSuccess:success didFail:fail];
    }didFail:^(NSString *error){
        fail(REQUEST_ERROR);
    }];
}

-(void) submitWorksLookRecord:(NSString *)workId didUser:(NSString *)userId didSuccess:(CallBackBlockSuccess)success didFail:(CallBackBlockFail)fail
{
    userId = [self getUserId];
    NSString *code = [BLTool getKeyCode:[NSString stringWithFormat:@"%@%@%@",workId, userId,@"1"]];
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    [dic setObject:workId forKey:@"courseId"];
    [dic setObject:userId forKey:@"userId"];
    [dic setObject:code forKey:@"code"];
    [dic setObject:@"1" forKey:@"type"];
    [PLInterface startRequest:ALL_URL didUrl:COURSE_SAVE_WATCH didParam:dic didSuccess:^(id result){
        [self dataFormatPost:result didSuccess:success didFail:fail];
    }didFail:^(NSString *error){
        fail(REQUEST_ERROR);
    }];
}

-(void) getWorksLookRecord:(NSString *)userId didSuccess:(CallBackBlockSuccess)success didFail:(CallBackBlockFail)fail
{
    userId = [self getUserId];

    NSString *code = [BLTool getKeyCode:[NSString stringWithFormat:@"%@%@",userId,@"3"]];
    NSString *url = [NSString stringWithFormat:@"%@/%@/%@",userId,@"3",code];
    [PLInterface startRequest:ALL_URL didUrl:COURSE_GET_WATCH(url) didParam:nil didSuccess:^(id result){    
        [self dataFormat:result didClass:NSStringFromClass([PLLookCourse class]) didSuccess:success didFail:fail];
    }didFail:^(NSString *error){
        fail(REQUEST_ERROR);
    }];
}

@end
