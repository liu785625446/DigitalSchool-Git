//
//  MCourseDownLoadDao.m
//  UploadVideo
//
//  Created by 刘军林 on 15/1/13.
//  Copyright (c) 2015年 刘军林. All rights reserved.
//

#import "PLCourseDownLoadDao.h"
#import "PLCourseDownload.h"
#import "PLMKDownloadOperation.h"
#import "MKNetworkEngine.h"
#import "FMDatabase.h"

static PLCourseDownLoadDao *shareCourse = nil;

@implementation PLCourseDownLoadDao

+(PLCourseDownLoadDao *) shareCourseDownloadDao
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (!shareCourse) {
            shareCourse = [[PLCourseDownLoadDao alloc] init];
            [PLCourseDownLoadDao createTable];
        }
    });
    return shareCourse;
}

+(BOOL) createTable
{
    NSString *sql = @"create table if not exists courseDownload (tableid INTEGER PRIMARY KEY, downloadName TEXT, downloadPath TEXT, downloadURL TEXT, downloadStatus INTEGER)";
    return [shareCourse executeUpdate:sql];
}

-(NSArray *) findAllCourseDownload
{
    NSString *sql = [NSString stringWithFormat:@"select * from courseDownload"];
    return [self executeQuery:sql];
}

-(NSArray *)findCourseDownloading
{
    NSString *sql = [NSString stringWithFormat:@"select * from courseDownload where downloadStatus = %d",downloadIng];
    return [self executeQuery:sql];
}

-(BOOL) addCourseDownload:(PLCourseDownload *)course
{
    NSString *sql = [NSString stringWithFormat:@"insert into courseDownload(downloadName, downloadPath, downloadURL, downloadStatus) VALUES ('%@', '%@', '%@', %d)",course.downloadName, course.downloadPath, course.downloadURL, course.downloadStatus];
    return [self executeUpdate:sql];
}

-(BOOL) updateCourseDownload:(PLCourseDownload *)course
{
    NSString *sql = [NSString stringWithFormat:@"update courseDownload set downloadName = '%@', downloadPath = '%@', downloadURL = '%@', downloadStatus = %d where downloadPath = '%@'", course.downloadName, course.downloadPath, course.downloadURL, course.downloadStatus, course.downloadPath];
    return [self executeUpdate:sql];
}

-(BOOL) removeCourseDownload:(PLCourseDownload *)course
{
    NSString *sql = [NSString stringWithFormat:@"delete from courseDownload where downloadPath = '%@'",course.downloadPath];
    return [self executeUpdate:sql];
}

-(void) startRequestDownload:(PLCourseDownload *)course didDownload:(DownloadMbBlock)downloadBlock didSuccess:(DownloadSuccessBlock)successBLock disFail:(DownloadFailBlock)failBlock
{
    _currentCourse = course;
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSMutableDictionary *newHeadersDict = [[NSMutableDictionary alloc] init];
    
    NSString *userAgentString = [NSString stringWithFormat:@"%@/%@",[[[NSBundle mainBundle] infoDictionary] objectForKey:(NSString *)kCFBundleNameKey],[[[NSBundle mainBundle] infoDictionary] objectForKey:(NSString *)kCFBundleVersionKey]];
    [newHeadersDict setObject:userAgentString forKey:@"User-Agent"];
    
    if ([fileManager fileExistsAtPath:course.downloadPath]) {
        NSError *error = nil;
        unsigned long long fileSize = [[fileManager attributesOfItemAtPath:course.downloadPath error:&error] fileSize];
        if (error) {
            NSLog(@"get %@ fileSize failed!\n Error:%@", course.downloadPath, error);
        }
        
        NSString *headerRange = [NSString stringWithFormat:@"bytes=%llu-", fileSize];
        [newHeadersDict setObject:headerRange forKey:@"Range"];
    }
    _operation = [[PLMKDownloadOperation alloc] initWithURLString:course.downloadURL params:nil httpMethod:@"GET"];
    [_operation addDownloadStream:[NSOutputStream outputStreamToFileAtPath:course.downloadPath append:YES]];
    [_operation addHeaders:newHeadersDict];
    
    MKNetworkEngine *engine = [[MKNetworkEngine alloc] init];
    [engine enqueueOperation:_operation];
    
    [_operation onDownloadMbChanged:^(double totalSize, double downloadSize){
        
        downloadBlock(course,totalSize, downloadSize);
    }];
    
    [_operation addCompletionHandler:^(MKNetworkOperation *completedOperation) {
        course.downloadStatus = downloadComplete;
        [self updateCourseDownload:course];
        successBLock([completedOperation responseData]);
    }errorHandler:^(MKNetworkOperation *errorOperation, NSError *error){
        failBlock(@"下载失败!");
    }];
}

-(void) pauseRequestDownload:(void (^)(NSString *))pauseBlock
{
    [_operation cancel];
    if (pauseBlock) {
        pauseBlock(_currentCourse.downloadPath);
    }
}

-(void) deleteDownloadTaskInQueue:(PLCourseDownload *)course
{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if ([fileManager fileExistsAtPath:course.downloadPath]) {
        [fileManager removeItemAtPath:course.downloadPath error:nil];
    }
}

-(PLBaseData *) objectForSet:(FMResultSet *)set
{
    PLCourseDownload *course = [[PLCourseDownload alloc] init];
    course.downloadName = [set stringForColumn:@"downloadName"];
    course.downloadPath = [set stringForColumn:@"downloadPath"];
    course.downloadURL = [set stringForColumn:@"downloadURL"];
    course.downloadStatus = [set intForColumn:@"downloadStatus"];
    
    return course;
}

@end
