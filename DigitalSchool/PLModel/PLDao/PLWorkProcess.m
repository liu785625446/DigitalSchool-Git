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
#import "MKNetworkKit.h"
#import "PLActivity.h"

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
    NSString *code = [BLTool getKeyCode:[NSString stringWithFormat:@"%@%@%@",workId, userId,@"3"]];
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    [dic setObject:workId forKey:@"courseId"];
    [dic setObject:userId forKey:@"userId"];
    [dic setObject:code forKey:@"code"];
    [dic setObject:@"3" forKey:@"type"];
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

-(void)uploadWorksWithActivityId:(NSString *)activityId
                      withUserId:(NSString *)userId
                     withMovData:(NSData *)movData
                     withImgData:(NSData *)imgData
                        workName:(NSString *)title
                       workIntro:(NSString *)intro
                  uploadProgress:(UploadAndDownloadProgress)uploadProgress
                      didSuccess:(CallBackBlockSuccess)success
                         didFail:(CallBackBlockFail)fail
{
    MKNetworkEngine *engine = [[MKNetworkEngine alloc] initWithHostName:ALL_URL customHeaderFields:nil];
    
    NSString *code = [BLTool getKeyCode:[NSString stringWithFormat:@"%@%@%@%@",activityId,[self getUserId],title,intro]];
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] initWithCapacity:0];
    [dic setObject:[self getUserId] forKey:@"userId"];
    [dic setObject:title forKey:@"title"];
    [dic setObject:activityId forKey:@"activityId"];
    [dic setObject:intro forKey:@"intro"];
    [dic setObject:code forKey:@"code"];
    
    MKNetworkOperation *operation = [engine operationWithPath:WORK_UPLOAD params:dic httpMethod:@"POST"];
    if (imgData !=nil)
    {
        [operation addData:imgData forKey:@"files" mimeType:@"image/png" fileName:@"image.png"];
    }
    if (movData !=nil)
    {
        [operation addData:movData forKey:@"files" mimeType:@"video/mp4" fileName:@"mov.mp4"];
    }
    
    [operation setFreezable:YES];
    [operation onUploadProgressChanged:^(double progress) {
        //上传进度
        NSLog(@"Upload progress: %f", progress);
        uploadProgress(progress);
        
    }];
    
    operation.MKNetworkKitRequestTimeOutInSeconds = 3600;
    
    [operation addCompletionHandler:^(MKNetworkOperation *op)
    {
        id result = [op responseJSON];
        [self dataFormatPost:result didSuccess:success didFail:fail];
        
    }errorHandler:^(MKNetworkOperation *op, NSError *error)
    {
        fail(REQUEST_ERROR);
    }];
    
    [engine enqueueOperation:operation];
}

-(void)getMyUploadWorkList:(int)pageSize
            didCurrentPage:(int)currentPage
                 didUserId:(NSString *)userId
                didSuccess:(CallBackBlockSuccess)success
                   didFail:(CallBackBlockFail)fail
{
    userId = [self getUserId];
    NSString *code = [BLTool getKeyCode:[NSString stringWithFormat:@"%d%d%@",pageSize,currentPage,userId]];
    NSString *url = [NSString stringWithFormat:@"%d/%d/%@/%@",pageSize,currentPage,userId,code];
    [PLInterface startRequest:ALL_URL
                       didUrl:MyUploadWork(url)
                     didParam:nil
                   didSuccess:^(id result)
     {
    [self dataFormat:result didClass:NSStringFromClass([PLWorks class]) didSuccess:success didFail:fail];
  
     }didFail:^(NSString *error)
     {
        fail(REQUEST_ERROR);
     }];
}

@end
