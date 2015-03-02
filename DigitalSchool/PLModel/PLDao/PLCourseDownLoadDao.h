//
//  MCourseDownLoadDao.h
//  UploadVideo
//
//  Created by 刘军林 on 15/1/13.
//  Copyright (c) 2015年 刘军林. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PLBaseDao.h"
@class PLCourseDownload;
@class PLMKDownloadOperation;

typedef void (^DownloadMbBlock)(PLCourseDownload *course, double totalSize, double downloadSize);
typedef void (^DownloadSuccessBlock)(id result);
typedef void (^DownloadFailBlock)(NSString *error);

@interface PLCourseDownLoadDao : PLBaseDao

@property (nonatomic, strong) PLMKDownloadOperation *operation;
@property (nonatomic, strong) PLCourseDownload *currentCourse;

+(PLCourseDownLoadDao *) shareCourseDownloadDao;

-(NSArray *) findAllCourseDownload;
-(BOOL) addCourseDownload:(PLCourseDownload *)course;
-(BOOL) removeCourseDownload:(PLCourseDownload *)course;
-(BOOL) updateCourseDownload:(PLCourseDownload *)course;

-(NSArray *)findCourseDownloading;

-(void) startRequestDownload:(PLCourseDownload *)course didDownload:(DownloadMbBlock)downloadBlock didSuccess:(DownloadSuccessBlock)successBLock disFail:(DownloadFailBlock)failBlock;

-(void) pauseRequestDownload:(void (^)(NSString *downloadURL))pauseBlock;
//-(void) pauseRequestDownload:(PLCourseDownload *)course;


-(void) deleteDownloadTaskInQueue:(PLCourseDownload *)course;

@end
