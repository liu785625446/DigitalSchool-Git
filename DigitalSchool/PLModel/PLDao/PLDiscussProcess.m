//
//  PLDiscussProcess.m
//  DigitalSchool
//
//  Created by 刘军林 on 15/1/30.
//  Copyright (c) 2015年 刘军林. All rights reserved.
//

#import "PLDiscussProcess.h"
#import "PLDiscuss.h"

@implementation PLDiscussProcess

-(void) getCourseDiscussList:(int)pageSize didCurrentPage:(int)currentPage didCourseId:(NSString *)courseId didSuccess:(CallBackBlockSuccess)success didFail:(CallBackBlockFail)fail
{
    NSString *code = [BLTool getKeyCode:[NSString stringWithFormat:@"%d%d%@%@",pageSize, currentPage, courseId, @"1"]];
    NSString *url = [NSString stringWithFormat:@"%d/%d/%@/%@/%@",pageSize, currentPage, courseId,@"1", code];
    [PLInterface startRequest:ALL_URL didUrl:DISCUSS_GET_LIST(url) didParam:nil didSuccess:^(id result){
        [self dataFormat:result didClass:NSStringFromClass([PLDiscuss class]) didSuccess:success didFail:fail];
    }didFail:^(NSString *error){      
        fail(REQUEST_ERROR);
    }];
}
-(void) getWorksDiscussList:(int)pageSize didCurrentPage:(int)currentPage didCourseId:(NSString *)courseId didSuccess:(CallBackBlockSuccess)success didFail:(CallBackBlockFail)fail
{
    NSString *code = [BLTool getKeyCode:[NSString stringWithFormat:@"%d%d%@%@",pageSize, currentPage, courseId, @"3"]];
    NSString *url = [NSString stringWithFormat:@"%d/%d/%@/%@/%@",pageSize, currentPage, courseId, @"3",code];
    [PLInterface startRequest:ALL_URL didUrl:DISCUSS_GET_LIST(url) didParam:nil didSuccess:^(id result){
        [self dataFormat:result didClass:NSStringFromClass([PLDiscuss class]) didSuccess:success didFail:fail];
    }didFail:^(NSString *error){
        fail(REQUEST_ERROR);
    }];
}
-(void) launchCourseDiscuss:(NSString *)courseId didUserId:(NSString *)userId didContent:(NSString *)discussContent didSuccess:(CallBackBlockSuccess)success didFail:(CallBackBlockFail)fail
{
    userId = [self getUserId];
    NSString *encoderContent = [BLTool getEncoding:discussContent];
    NSString *code = [BLTool getKeyCode:[NSString stringWithFormat:@"%@%@%@%@",courseId, userId, encoderContent,@"1"]];
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] initWithCapacity:0];
    [dic setObject:courseId forKey:@"courseId"];
    [dic setObject:userId forKey:@"userId"];
    [dic setObject:encoderContent forKey:@"content"];
    [dic setObject:code forKey:@"code"];
    [dic setObject:@"1" forKey:@"type"];
    
    [PLInterface startRequest:ALL_URL didUrl:LAUNCH_DISCUSS didParam:dic didSuccess:^(id result){
        [self dataFormatPost:result didSuccess:success didFail:fail];
    }didFail:^(NSString *error){
        fail(REQUEST_ERROR);
    }];
}

-(void) launchWorksDiscuss:(NSString *)workId didUserId:(NSString *)userId didContent:(NSString *)discussContent didSuccess:(CallBackBlockSuccess)success didFail:(CallBackBlockFail)fail
{
    userId = [self getUserId];
    NSString *encoderContent = [BLTool getEncoding:discussContent];
    NSString *code = [BLTool getKeyCode:[NSString stringWithFormat:@"%@%@%@%@",workId, userId, encoderContent,@"3"]];
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] initWithCapacity:0];
    [dic setObject:workId forKey:@"courseId"];
    [dic setObject:userId forKey:@"userId"];
    [dic setObject:encoderContent forKey:@"content"];
    [dic setObject:code forKey:@"code"];
    [dic setObject:@"3" forKey:@"type"];
    
    [PLInterface startRequest:ALL_URL didUrl:LAUNCH_DISCUSS didParam:dic didSuccess:^(id result){
        [self dataFormatPost:result didSuccess:success didFail:fail];
    }didFail:^(NSString *error){
        fail(REQUEST_ERROR);
    }];
}

-(void) replyDiscuss:(NSString *)userId didDiscuss:(NSString *)discussId didContent:(NSString *)content didSuccess:(CallBackBlockSuccess)success didFail:(CallBackBlockFail)fail
{
    userId = [self getUserId];
    NSString *encoderContent = [BLTool getEncoding:content];
    NSString *code = [BLTool getKeyCode:[NSString stringWithFormat:@"%@%@%@%@",userId, discussId, content,@"1"]];
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] initWithCapacity:0];
    [dic setObject:userId forKey:@"userId"];
    [dic setObject:discussId forKey:@"discussId"];
    [dic setObject:encoderContent forKey:@"content"];
    [dic setObject:code forKey:@"code"];
    [dic setObject:@"1" forKey:@"type"];
    
    [PLInterface startRequest:ALL_URL didUrl:REPLY_DISCUSS didParam:dic didSuccess:^(id result){
        [self dataFormatPost:result didSuccess:success didFail:fail];
    }didFail:^(NSString *error){
        fail(REQUEST_ERROR);
    }];
}

-(void) replyWorks:(NSString *)userId didDiscuss:(NSString *)discussId didContent:(NSString *)content didSuccess:(CallBackBlockSuccess)success didFail:(CallBackBlockFail)fail
{
    userId = [self getUserId];
    NSString *encoderContent = [BLTool getEncoding:content];
    NSString *code = [BLTool getKeyCode:[NSString stringWithFormat:@"%@%@%@%@",userId, discussId, content,@"3"]];
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] initWithCapacity:0];
    [dic setObject:userId forKey:@"userId"];
    [dic setObject:discussId forKey:@"discussId"];
    [dic setObject:encoderContent forKey:@"content"];
    [dic setObject:code forKey:@"code"];
    [dic setObject:@"3" forKey:@"type"];
    
    [PLInterface startRequest:ALL_URL didUrl:REPLY_DISCUSS didParam:dic didSuccess:^(id result){
        [self dataFormatPost:result didSuccess:success didFail:fail];
    }didFail:^(NSString *error){
        fail(REQUEST_ERROR);
    }];
}

-(void) commentActivityDiscuss:(NSString *)activityId didUserId:(NSString *)userId didContent:(NSString *)content didSuccess:(CallBackBlockSuccess)success didFail:(CallBackBlockFail)fail
{
    userId = [self getUserId];
    NSString *encoderContent = [BLTool getEncoding:content];
    NSString *code = [BLTool getKeyCode:[NSString stringWithFormat:@"%@%@%@",activityId, userId, encoderContent]];
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] initWithCapacity:0];
    [dic setObject:activityId forKey:@"activityId"];
    [dic setObject:userId forKey:@"userId"];
    [dic setObject:encoderContent forKey:@"content"];
    [dic setObject:code forKey:@"code"];
    
    [PLInterface startRequest:ALL_URL didUrl:ACTIVITY_COMMENT didParam:dic didSuccess:^(id result){
        [self dataFormatPost:result didSuccess:success didFail:fail];
    }didFail:^(NSString *error){
        fail(REQUEST_ERROR);
    }];
}

-(void) getActivityDiscussList:(int)pageSize didCurrentPage:(int)currentPage didActivityId:(NSString *)activityId didSuccess:(CallBackBlockSuccess)success didFail:(CallBackBlockFail)fail
{
    NSString *code = [BLTool getKeyCode:[NSString stringWithFormat:@"%d%d%@",pageSize, currentPage, activityId]];
    NSString *url = [NSString stringWithFormat:@"%d/%d/%@/%@",pageSize, currentPage, activityId,code];
    [PLInterface startRequest:ALL_URL didUrl:GET_ACTIVITY_COMMENT(url) didParam:nil didSuccess:^(id result){
        [self dataFormat:result didClass:NSStringFromClass([PLDiscuss class]) didSuccess:success didFail:fail];
    }didFail:^(NSString *error){
        fail(REQUEST_ERROR);
    }];

}

@end
