//
//  PLUserProcess.m
//  DigitalSchool
//
//  Created by 刘军林 on 15/3/8.
//  Copyright (c) 2015年 刘军林. All rights reserved.
//

#import "PLUserProcess.h"
#import "PLUser.h"

@implementation PLUserProcess

-(void) rigesterUserName:(NSString *)userName didPassword:(NSString *)pwd didNickName:(NSString *)nickName didUserType:(NSString *)userType didSuccess:(CallBackBlockSuccess)success didFail:(CallBackBlockFail)fail
{
    NSString * encodePassword = [BLTool md5:[NSString stringWithFormat:@"%@{%@}",userName,pwd]];
    NSString *code = [BLTool getKeyCode:[NSString stringWithFormat:@"%@%@%@%@",userName,pwd,nickName,userType]];
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] initWithCapacity:0];
    [dic setObject:userName forKey:@"username"];
    [dic setObject:pwd forKey:@"password"];
    [dic setObject:nickName forKey:@"nickName"];
    [dic setObject:userType forKey:@"type"];
    [dic setObject:code forKey:@"code"];
    
    [PLInterface startRequest:ALL_URL didUrl:USER_REGISTER didParam:dic didSuccess:^(id result) {
        [self dataFormatPost:result didSuccess:success didFail:fail];
    } didFail:^(NSString *error) {
        fail(REQUEST_ERROR);
    }];
}

-(void) loginUserName:(NSString *)userName didPassword:(NSString *)pwd didSuccess:(CallBackBlockSuccess)success didFail:(CallBackBlockFail)fail
{
    NSString *encodePassword = [BLTool md5:[NSString stringWithFormat:@"%@{%@}",userName,pwd]];
    NSString *code = [BLTool getKeyCode:[NSString stringWithFormat:@"%@%@",userName,pwd]];
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] initWithCapacity:0];
    [dic setObject:userName forKey:@"username"];
    [dic setObject:pwd forKey:@"password"];
    [dic setObject:code forKey:@"code"];
    [PLInterface startRequest:ALL_URL didUrl:USER_LOGIN didParam:dic didSuccess:^(id result) {
        [self dataFormatPost:result didSuccess:success didFail:fail];
    } didFail:^(NSString *error) {
        fail(REQUEST_ERROR);
    }];
}

-(void) modifyNickName:(NSString *)nickName didUserId:(NSString *)userId didSuccess:(CallBackBlockSuccess)success didFail:(CallBackBlockFail)fail
{
    NSString *code = [BLTool getKeyCode:[NSString stringWithFormat:@"%@%@",userId,nickName]];
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] initWithCapacity:0];
    [dic setObject:nickName forKey:@"nickName"];
    [dic setObject:userId forKey:@"id"];
    [dic setObject:code forKey:@"code"];
    [PLInterface startRequest:ALL_URL didUrl:USER_MODIFY didParam:dic didSuccess:^(id result) {
        [self dataFormatPost:result didSuccess:success didFail:fail];
    } didFail:^(NSString *error) {
        fail(REQUEST_ERROR);
    }];
}

-(void) modifyPassword:(NSString *)userId didOldPassword:(NSString *)oldPwd didNewPassword:(NSString *)newPwd didSuccess:(CallBackBlockSuccess)success didFail:(CallBackBlockFail)fail
{
    NSString *code = [BLTool getKeyCode:[NSString stringWithFormat:@"%@%@%@",userId,oldPwd,newPwd]];
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] initWithCapacity:0];
    [dic setObject:userId forKey:@"id"];
    [dic setObject:oldPwd forKey:@"oldPass"];
    [dic setObject:newPwd forKey:@"password"];
    [dic setObject:code forKey:@"code"];
    [PLInterface startRequest:ALL_URL didUrl:USER_MODIFY_PASSWORD didParam:dic didSuccess:^(id result) {
        
    } didFail:^(NSString *error) {
        
    }];
}

-(void) uploadHeadImg:(NSString *)userId didHeadImg:(NSData *)headImg didSuccess:(CallBackBlockSuccess)success didFail:(CallBackBlockFail)fail
{
    NSString *code = [BLTool getKeyCode:userId];
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] initWithCapacity:0];
    [dic setObject:userId forKey:@"id"];
    [dic setObject:headImg forKey:@"file"];
    [dic setObject:code forKey:@"code"];
    
    [PLInterface startRequest:ALL_URL didUrl:USER_UPLOAD_IMG didParam:dic didSuccess:^(id result) {
        
    } didFail:^(NSString *error) {
        
    }];
}

@end
