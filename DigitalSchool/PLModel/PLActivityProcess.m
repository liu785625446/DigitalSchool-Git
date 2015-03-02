//
//  PLActivityProcess.m
//  DigitalSchool
//
//  Created by 刘军林 on 15/2/3.
//  Copyright (c) 2015年 刘军林. All rights reserved.
//

#import "PLActivityProcess.h"
#import "PLActivity.h"

@implementation PLActivityProcess

-(void) getActivityList:(int)pageSize didCurrentPage:(int)currentPage didSuccess:(CallBackBlockSuccess)success didFail:(CallBackBlockFail)fail
{
    NSString *code = [BLTool getKeyCode:[NSString stringWithFormat:@"%d%d",pageSize, currentPage]];
    NSString *url = [NSString stringWithFormat:@"%d/%d/%@",pageSize, currentPage, code];
    [PLInterface startRequest:ALL_URL didUrl:ACTIVITY_GET_LIST(url) didParam:nil didSuccess:^(id result){
        [self dataFormat:result didClass:NSStringFromClass([PLActivity class]) didSuccess:success didFail:fail];
    }didFail:^(NSString *error){
        fail(REQUEST_ERROR);
    }];
}

-(void)activityCollect:(NSString *)activityId didUserID:(NSString *)userId didSuccess:(CallBackBlockSuccess)success didFail:(CallBackBlockFail)fail
{
    NSString *code = [BLTool getKeyCode:[NSString stringWithFormat:@"%@%@",activityId,userId]];
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    [dic setObject:activityId forKey:@"activityId"];
    [dic setObject:userId forKey:@"userId"];
    [dic setObject:code forKey:@"code"];
    [PLInterface startRequest:ALL_URL didUrl:ACTIVITY_COOLECT didParam:dic didSuccess:^(id result){
        [self dataFormatPost:result didSuccess:success didFail:fail];
    }didFail:^(NSString *error){
        fail(REQUEST_ERROR);
    }];
}

-(void) activityCancelCollect:(NSString *)Id didUserId:(NSString *)userId didSuccess:(CallBackBlockSuccess)success didFail:(CallBackBlockFail)fail
{
    NSString *code = [BLTool getKeyCode:[NSString stringWithFormat:@"%@%@",Id, userId]];
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    [dic setObject:Id forKey:@"id"];
    [dic setObject:userId forKey:@"userId"];
    [dic setObject:code forKey:@"code"];
    [PLInterface startRequest:ALL_URL didUrl:ACTIVITY_CANCEL_COOLECT didParam:dic didSuccess:^(id result){
        [self dataFormatPost:result didSuccess:success didFail:fail];
    }didFail:^(NSString *error){
        fail(REQUEST_ERROR);
    }];
}

-(void) activityAttentions:(int )pageSize didCurrentPage:(int )currentPage didUserId:(NSString *)userId didSuccess:(CallBackBlockSuccess)success didFail:(CallBackBlockFail)fail
{
    NSString *code = [BLTool getKeyCode:[NSString stringWithFormat:@"%d%d%@",pageSize, currentPage, userId]];
    NSString *url = [NSString stringWithFormat:@"%d/%d/%@/%@",pageSize, currentPage, userId, code];
    [PLInterface startRequest:ALL_URL didUrl:ACTIVITY_GET_ATTENTIONS_LIST(url) didParam:nil didSuccess:^(id result){
        [self dataFormatPost:result didSuccess:success didFail:fail];
    }didFail:^(NSString *error){
        fail(REQUEST_ERROR);
    }];
}

@end
