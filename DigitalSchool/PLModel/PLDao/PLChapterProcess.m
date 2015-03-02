//
//  PLChapterProcess.m
//  DigitalSchool
//
//  Created by 刘军林 on 15/2/5.
//  Copyright (c) 2015年 刘军林. All rights reserved.
//

#import "PLChapterProcess.h"
#import "PLCourse.h"

@implementation PLChapterProcess

-(void) getChapterCorrelationListdGradeId:(NSString *)gradeId didCatalogId:(NSString *)catalogId didVolumes:(NSString *)volumesId didSuccess:(CallBackBlockSuccess)success didFail:(CallBackBlockFail)fail
{
    NSString *code = [BLTool getKeyCode:[NSString stringWithFormat:@"%@%@%@", gradeId, catalogId, volumesId]];
    NSString *url = [NSString stringWithFormat:@"%@/%@/%@/%@" , gradeId, catalogId, volumesId,code];
    [PLInterface startRequest:ALL_URL didUrl:CHAPTER_VOLUMES(url) didParam:nil didSuccess:^(id result) {
        [self dataFormat:result didClass:NSStringFromClass([PLCourse class]) didSuccess:success didFail:fail];
    } didFail:^(NSString *error) {
        
    }];
}

@end
