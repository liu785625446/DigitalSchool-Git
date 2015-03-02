//
//  PCourseProcess.h
//  UploadVideo
//
//  Created by 刘军林 on 15/1/13.
//  Copyright (c) 2015年 刘军林. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PLCourseDownLoadDao.h"

@class PLCourseDownload;

@protocol BLCourseDownloadDelegate <NSObject>

-(void)courseDownload:(PLCourseDownload *)courseDownload didTotalSize:(double)totalSize didDownloadSize:(double) downloadSize;
@end

@interface BLCourseDownloadProcess : NSObject

@property (nonatomic, strong) NSArray *download_list;
@property (nonatomic, strong) PLCourseDownLoadDao *courseDao;
@property (assign) BOOL isRequesting;
@property (nonatomic, weak) id<BLCourseDownloadDelegate> delegate;

+(BLCourseDownloadProcess *)shareCourseDownload;

-(NSArray *) findAllCourseDownload;
-(BOOL) addCourseDownload:(PLCourseDownload *)course;
-(BOOL) removeCourseDownload:(PLCourseDownload *)course;

-(void)pauseRequestDownloadTaskQueue:(PLCourseDownload *)course;
-(void)priorityRequestDownloadTaskQueue:(PLCourseDownload *)cource;
-(void)deleteCourseDownloadTaskQueue:(NSArray *)deleteArray;
-(void)startRequestData;
//-(void) addDownloadBlockStatus:(PLCourseDownload *)course didDownloadBlock:(DownloadMbBlock)downloadBlock;
//-(void) requestDownloadTaskQueueNext:(PLCourseDownload *)course;
///**
// *  启动队列中的下载
// *
// *  @param course        下载实体类
// *  @param downloadBlock
// */
//-(void) startRequestDownload:(PLCourseDownload *)course;
//
///**
// *  网下载队列中添加下载队列
// *
// *  @param course        下载实体类
// *  @param downloadBlock
// */
//-(void) addRequestDownloadToTaskQueue:(PLCourseDownload *)course didDownload:(DownloadMbBlock)downloadBlock;
//
///**
// *  暂停下载
// *
// *  @param course 当前实体下载类
// */
//-(void) pauseRequestDownloadTaskQueue:(PLCourseDownload *)course;
//
///**
// *  删除下载队列
// *
// *  @param course 删除的实体下载类
// */
//-(void) deleteDownloadTaskInQueue:(PLCourseDownload *)course;
//
//-(void) priorityRequestDownloadTaskQueue:(PLCourseDownload *)cource;

@end
