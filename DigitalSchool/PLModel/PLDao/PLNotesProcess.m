    //
    //  PLNotesProcess.m
    //  DigitalSchool
    //
    //  Created by 刘军林 on 15/2/2.
    //  Copyright (c) 2015年 刘军林. All rights reserved.
    //

#import "PLNotesProcess.h"
#import "PLNotes.h"

@implementation PLNotesProcess

-(void) getCourseNotesList:(int)pageSize didCurrentPage:(int)currentPage didCourseId:(NSString *)courseId didSuccess:(CallBackBlockSuccess)success didFail:(CallBackBlockFail)fail
{
    NSString *code = [NSString stringWithFormat:@"%d%d%@",pageSize, currentPage, courseId];
    NSString *url = [NSString stringWithFormat:@"%d/%d/%@/%@",pageSize, currentPage, courseId, [BLTool getKeyCode:code]];
    
    [PLInterface startRequest:ALL_URL didUrl:NOTE_GET_LIST(url) didParam:nil didSuccess:^(id result){
        [self dataFormat:result didClass:NSStringFromClass([PLNotes class]) didSuccess:success didFail:fail];
    }didFail:^(NSString *error){
        fail(REQUEST_ERROR);
    }];
}

-(void) praiseNotes:(NSString *)noteId didUser:(NSString *)userId didPlayVideoType:(int)playVideoType didSuccess:(CallBackBlockSuccess)success didFail:(CallBackBlockFail)fail
{
    userId = [self getUserId];
    NSString *code = [BLTool getKeyCode:[NSString stringWithFormat:@"%@%@%d",noteId, userId,playVideoType]];
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] initWithCapacity:0];
    [dic setObject:noteId forKey:@"noteId"];
    [dic setObject:userId forKey:@"userId"];
    [dic setObject:[NSString stringWithFormat:@"%d",playVideoType] forKey:@"type"];
    [dic setObject:code forKey:@"code"];
    
    [PLInterface startRequest:ALL_URL didUrl:NOTE_PRAISE didParam:dic didSuccess:^(id result){
        [self dataFormatPost:result didSuccess:success didFail:fail];
    }didFail:^(NSString *error){
        fail(REQUEST_ERROR);
    }];
}

-(void) noteWrite:(NSString *)userId didCourseId:(NSString *)courseId didContent:(NSString *)contentId didType:(int)type didSuccess:(CallBackBlockSuccess)success didFail:(CallBackBlockFail)fail
{
    userId = [self getUserId];
    NSString *encoderContent = [BLTool getEncoding:contentId];
    NSString *code = [BLTool getKeyCode:[NSString stringWithFormat:@"%@%@%@%d",userId, courseId, encoderContent,type]];
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] initWithCapacity:0];
    [dic setObject:userId forKey:@"userId"];
    [dic setObject:courseId forKey:@"courseId"];
    [dic setObject:encoderContent forKey:@"content"];
    [dic setObject:[NSString stringWithFormat:@"%d",type] forKey:@"type"];
    [dic setObject:code forKey:@"code"];
    
    [PLInterface startRequest:ALL_URL didUrl:WRITE_NOTE didParam:dic didSuccess:^(id result){
        [self dataFormatPost:result didSuccess:success didFail:fail];
    }didFail:^(NSString *error){
        fail(REQUEST_ERROR);
    }];
}

@end