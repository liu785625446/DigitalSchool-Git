    //
    //  PLNavsProcess.m
    //  DigitalSchool
    //
    //  Created by 刘军林 on 15/3/11.
    //  Copyright (c) 2015年 刘军林. All rights reserved.
    //

#import "PLNavsProcess.h"
#import "PLNavs.h"
#import "PLCourse.h"

@implementation PLNavsProcess

-(void) getNavsList:(CallBackBlockSuccess)success didFail:(CallBackBlockFail)fail
{
    NSString *code = [BLTool getKeyCode:@""];
    NSString *url = code;
    [PLInterface startRequest:ALL_URL didUrl:NAV_NAVS(url) didParam:nil didSuccess:^(id result) {
        [self dataFormat:result didClass:NSStringFromClass([PLNavs class]) didSuccess:success didFail:fail];
    } didFail:^(NSString *error) {
        
    }];
}

-(void) getNavsDatails:(int)pageSize didCurrentPage:(int)currentPage didNavId:(NSString *)navId didSuccess:(CallBackBlockSuccess)success didFail:(CallBackBlockFail)fail
{
    NSString *code = [BLTool getKeyCode:[NSString stringWithFormat:@"%d%d%@",pageSize, currentPage, navId]];
    NSString *url = [NSString stringWithFormat:@"%d/%d/%@/%@",pageSize, currentPage, navId, code];
    [PLInterface startRequest:ALL_URL didUrl:NAV_NAVS_DATA(url) didParam:nil didSuccess:^(id result) {
        [self dataFormat:result didClass:NSStringFromClass([PLCourse class]) didSuccess:success didFail:fail];
    } didFail:^(NSString *error) {
        fail(REQUEST_ERROR);
    }];
}

@end
