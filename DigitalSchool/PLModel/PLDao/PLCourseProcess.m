//
//  PLCourseProcess.m
//  DigitalSchool
//
//  Created by 刘军林 on 15/1/27.
//  Copyright (c) 2015年 刘军林. All rights reserved.
//

#import "PLCourseProcess.h"
#import "PLInterface.h"
#import "BLTool.h"
#import "PLCourse.h"
#import "PLLookCourse.h"
#import "PLActivity.h"
#import "PLWorks.h"
#import "PLRecommendCourse.h"
#import "PLCollect.h"

@implementation PLCourseProcess

-(void) getCourseMainImg:(CallBackBlockSuccess)success didFail:(CallBackBlockFail)fail
{
    NSLog(@"aa");
    [PLInterface startRequest:ALL_URL didUrl:COURSE_MAIN([BLTool getKeyCode:@""]) didParam:nil didSuccess:^(id result){
        NSLog(@"bb");
        [self dataFormat:result didClass:NSStringFromClass([PLRecommendCourse class]) didSuccess:success didFail:fail];
    }didFail:^(NSString *error){
        fail(REQUEST_ERROR);
    }];
}

-(void) getMainColumnsTitleList:(CallBackBlockSuccess)success didFail:(CallBackBlockFail)fail
{
    [PLInterface startRequest:ALL_URL didUrl:COLUMNS_TITLE_LIST([BLTool getKeyCode:@""]) didParam:nil didSuccess:^(id result) {
        if ([[result objectForKey:@"ret"] isEqualToNumber:[NSNumber numberWithInt:0]]) {
            success([result objectForKey:@"data"]);
        }else{
            fail(REQUEST_ERROR);
        }
    } didFail:^(NSString *error) {
        fail(REQUEST_ERROR);
    }];
}

-(void) getMainColumnsList:(int)pageSize didCurrentPage:(int)currentPage didColumnsId:(NSString *)columnsId didColumnsType:(NSString *)columnsType didSuccess:(CallBackBlockSuccess)success didFail:(CallBackBlockFail)fail
{
    NSString *code = [BLTool getKeyCode:[NSString stringWithFormat:@"%d%d%@%@",pageSize, currentPage, columnsId, columnsType]];
    NSString *url = [NSString stringWithFormat:@"%d/%d/%@/%@/%@",pageSize, currentPage, columnsId, columnsType, code];
    [PLInterface startRequest:ALL_URL didUrl:COLUMNS_PAGE_LIST(url) didParam:nil didSuccess:^(id result) {
        NSLog(@"result:%@",result);
        if ([columnsType intValue] == 1) {
            [self dataFormat:result didClass:NSStringFromClass([PLCourse class]) didSuccess:success didFail:fail];
        }else if ([columnsType intValue] == 2){
            [self dataFormat:result didClass:NSStringFromClass([PLActivity class]) didSuccess:success didFail:fail];
        }else if ([columnsType intValue] == 3) {
            [self dataFormat:result didClass:NSStringFromClass([PLWorks class]) didSuccess:success didFail:fail];
        }else{
            fail(REQUEST_ERROR);
        }
    } didFail:^(NSString *error) {
        fail(REQUEST_ERROR);
    }];
}

-(void) getCourseHostList:(CallBackBlockSuccess)success didFail:(CallBackBlockFail)fail
{
    [PLInterface startRequest:ALL_URL didUrl:COURSE_HOTS([BLTool getKeyCode:@""]) didParam:nil didSuccess:^(id result){
        [self dataFormat:result didClass:NSStringFromClass([PLCourse class]) didSuccess:success didFail:fail];
    }didFail:^(NSString *error){
        fail(REQUEST_ERROR);
    }];
}

-(void) getCourseMainParents:(CallBackBlockSuccess)success didFail:(CallBackBlockFail)fail
{
    NSString *url = [NSString stringWithFormat:@"2/%@",[BLTool getKeyCode:@"2"]];
    
    [PLInterface startRequest:ALL_URL didUrl:COURSE_TYPE(url) didParam:nil didSuccess:^(id result){
        [self dataFormat:result didClass:NSStringFromClass([PLCourse class]) didSuccess:success didFail:fail];
    }didFail:^(NSString *error){
        fail(REQUEST_ERROR);
    }];
}

-(void) getCourseMainMicroCourses:(CallBackBlockSuccess)success didFail:(CallBackBlockFail)fail
{
    NSString *url = [NSString stringWithFormat:@"3/%@",[BLTool getKeyCode:@"3"]];
    
    [PLInterface startRequest:ALL_URL didUrl:COURSE_TYPE(url) didParam:nil didSuccess:^(id result){
        [self dataFormat:result didClass:NSStringFromClass([PLCourse class]) didSuccess:success didFail:fail];
    }didFail:^(NSString *error){
        fail(REQUEST_ERROR);
    }];
}

-(void) getCourseFilter:(int)pageSize didCurrentPage:(int)currentPage didGrade:(int)grade didSubject:(int)subject didTeacher:(int)teacher didType:(int)type didSuccess:(CallBackBlockSuccess)success didFail:(CallBackBlockFail)fail
{
    NSString *code = [NSString stringWithFormat:@"%d%d%d%d%d",pageSize, currentPage, grade, subject, teacher];
    NSString *url = [NSString stringWithFormat:@"%d/%d/%d/%d/%d/%@",pageSize, currentPage, grade, subject, teacher, [BLTool getKeyCode:code]];
    NSLog(@"%@",[NSString stringWithFormat:@"%@%@",ALL_URL, COURSE_FILTER(url)]);
    [PLInterface startRequest:ALL_URL didUrl:COURSE_FILTER(url)  didParam:nil didSuccess:^(id result){
        [self dataFormat:result didClass:NSStringFromClass([PLCourse class]) didSuccess:success didFail:fail];
    }didFail:^(NSString *error){
        fail(REQUEST_ERROR);
    }];
}

-(void) getCourseSearch:(int)pageSize didCurrentPage:(int)currentPage didSearch:(NSString *)searchStr didSuccess:(CallBackBlockSuccess)success didFail:(CallBackBlockFail)fail
{
    NSString *code = [NSString stringWithFormat:@"%d%d%@",pageSize, currentPage, [BLTool getEncoding:searchStr]];
    NSString *url = [NSString stringWithFormat:@"%d/%d/%@/%@",pageSize, currentPage, [BLTool getEncoding:searchStr], [BLTool getKeyCode:code]];
    
    [PLInterface startRequest:ALL_URL didUrl:COURSE_SEARCH(url) didParam:nil didSuccess:^(id result){
        [self dataFormat:result didClass:NSStringFromClass([PLCourse class]) didSuccess:success didFail:fail];
    }didFail:^(NSString *error){
        fail(REQUEST_ERROR);
    }];
}

-(void) getCourseConditionList:(CallBackBlockSuccess )success didFail:(CallBackBlockFail)fail
{
    [PLInterface startRequest:ALL_URL didUrl:COURSE_CONDITION([BLTool getKeyCode:@""]) didParam:nil didSuccess:^(id result){
        
        NSMutableArray *list = [[NSMutableArray alloc] init];
        if ([[result objectForKey:@"ret"] isEqualToNumber:[NSNumber numberWithInt:0]]) {
            NSArray *dataArray = [result objectForKey:@"data"];
            for (NSDictionary *dataDic in dataArray) {
                if (dataDic) {
                    NSArray *allKey = [dataDic allKeys];
                    for (NSString *key in allKey) {
                        NSMutableArray *tempArray = [NSMutableArray arrayWithArray:[dataDic objectForKey:key]];
                        [tempArray insertObject:@{@"id":@"0", @"name":@"全部"} atIndex:0];
                        [list addObject:tempArray];
                    }
                }
            }
        }
        success(list);
    }didFail:^(NSString *error){
        fail(REQUEST_ERROR);
    }];
}

-(void) submitCourseLookRecord:(NSString *)courseId didUser:(NSString *)userId didSuccess:(CallBackBlockSuccess)success didFail:(CallBackBlockFail)fail
{
    userId = [self getUserId];
    NSString *code = [BLTool getKeyCode:[NSString stringWithFormat:@"%@%@%@",courseId, userId,@"1"]];
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    [dic setObject:courseId forKey:@"courseId"];
    [dic setObject:userId forKey:@"userId"];
    [dic setObject:code forKey:@"code"];
    [dic setObject:@"1" forKey:@"type"];
    [PLInterface startRequest:ALL_URL didUrl:COURSE_SAVE_WATCH didParam:dic didSuccess:^(id result){
        [self dataFormatPost:result didSuccess:success didFail:fail];
    }didFail:^(NSString *error){
        fail(REQUEST_ERROR);
    }];
}

-(void) getCourseLookRecord:(NSString *)userId didSuccess:(CallBackBlockSuccess)success didFail:(CallBackBlockFail)fail
{
    userId = [self getUserId];
    NSString *code = [BLTool getKeyCode:[NSString stringWithFormat:@"%@%@",userId,@"1"]];
    NSString *url = [NSString stringWithFormat:@"%@/%@/%@",userId,@"1",code];
    [PLInterface startRequest:ALL_URL didUrl:COURSE_GET_WATCH(url) didParam:nil didSuccess:^(id result){
        [self dataFormat:result didClass:NSStringFromClass([PLLookCourse class]) didSuccess:success didFail:fail];
    }didFail:^(NSString *error){
        fail(REQUEST_ERROR);
    }];
}

-(void) attentionCourse:(NSString *)courseId didUser:(NSString *)userId didSuccess:(CallBackBlockSuccess)success didFail:(CallBackBlockFail)fail
{
    userId = [self getUserId];
    NSString *code = [BLTool getKeyCode:[NSString stringWithFormat:@"%@%@",courseId, userId]];
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    [dic setObject:courseId forKey:@"courseId"];
    [dic setObject:userId forKey:@"userId"];
    [dic setObject:code forKey:@"code"];
    [PLInterface startRequest:ALL_URL didUrl:COURSE_ATTENTION didParam:dic didSuccess:^(id result){
        [self dataFormatPost:result didSuccess:success didFail:fail];
    }didFail:^(NSString *error){
        fail(REQUEST_ERROR);
    }];
}

-(void) cancelAttentionCourse:(NSString *)courseId didUser:(NSString *)userId didSuccess:(CallBackBlockSuccess)success didFail:(CallBackBlockFail)fail
{
    userId = [self getUserId];
    NSString *code = [BLTool getKeyCode:[NSString stringWithFormat:@"%@%@",courseId, userId]];
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    [dic setObject:courseId forKey:@"courseId"];
    [dic setObject:userId forKey:@"userId"];
    [dic setObject:code forKey:@"code"];
    [PLInterface startRequest:ALL_URL didUrl:COURSE_CANCEL_ATTENTION didParam:dic didSuccess:^(id result){
        [self dataFormatPost:result didSuccess:success didFail:fail];
    }didFail:^(NSString *error){
        fail(REQUEST_ERROR);
    }];
}

-(void) getAttentionCourse:(int)pageSize didCurrentPage:(int)currentPage diduserId:(NSString *)userId didSuccess:(CallBackBlockSuccess)success didFail:(CallBackBlockFail)fail
{
    userId = [self getUserId];

    NSString *code = [BLTool getKeyCode:[NSString stringWithFormat:@"%d%d%@",pageSize, currentPage, userId]];
    NSString *url = [NSString stringWithFormat:@"%d/%d/%@/%@",pageSize, currentPage, userId, code];
    [PLInterface startRequest:ALL_URL didUrl:COURSE_GET_ATTENTIONS(url) didParam:nil didSuccess:^(id result){
    
        [self dataFormat:result didClass:NSStringFromClass([PLCollect class]) didSuccess:success didFail:fail];
    }didFail:^(NSString *error){
        fail(REQUEST_ERROR);
    }];
}

-(void) getChapterCorrelationListdGradeId:(NSString *)gradeId didCatalogId:(NSString *)catalogId didVolumes:(NSString *)volumesId didSuccess:(CallBackBlockSuccess)success didFail:(CallBackBlockFail)fail
{
    NSString *code = [BLTool getKeyCode:[NSString stringWithFormat:@"%@%@%@", gradeId, catalogId, volumesId]];
    NSString *url = [NSString stringWithFormat:@"%@/%@/%@/%@" , gradeId, catalogId, volumesId,code];
    [PLInterface startRequest:ALL_URL didUrl:CHAPTER_VOLUMES(url) didParam:nil didSuccess:^(id result) {
        [self dataFormat:result didClass:NSStringFromClass([PLCourse class]) didSuccess:success didFail:fail];
    } didFail:^(NSString *error) {
        
    }];
}

-(void)praiseDidCourseId:(NSString *)courseId
               didUserId:(NSString *)userId
                 didType:(int)type
              didSuccess:(CallBackBlockSuccess)success
                 didFail:(CallBackBlockFail)fail
{
    NSString *code = [BLTool getKeyCode:[NSString stringWithFormat:@"%@%@%d", courseId, userId, type]];
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    [dic setObject:courseId forKey:@"courseId"];
    [dic setObject:userId forKey:@"userId"];
    [dic setObject:[NSString stringWithFormat:@"%d",type] forKey:@"type"];
    [dic setObject:code forKey:@"code"];
    [PLInterface startRequest:ALL_URL didUrl:Praise didParam:dic didSuccess:^(id result) {
        [self dataFormatPost:result didSuccess:success didFail:fail];
    } didFail:^(NSString *error) {
        fail(REQUEST_ERROR);
    }];
    
}


@end
