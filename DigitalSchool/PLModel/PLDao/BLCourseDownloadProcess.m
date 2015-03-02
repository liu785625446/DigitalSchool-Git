//
//  PCourseProcess.m
//  UploadVideo
//
//  Created by 刘军林 on 15/1/13.
//  Copyright (c) 2015年 刘军林. All rights reserved.
//

#import "BLCourseDownloadProcess.h"
#import "PLCourseDownload.h"
#import "PLCourseDownLoadDao.h"

static BLCourseDownloadProcess *shareCourseDownlad;

@implementation BLCourseDownloadProcess

@synthesize courseDao;
@synthesize download_list;

+(BLCourseDownloadProcess *) shareCourseDownload
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (!shareCourseDownlad) {
            shareCourseDownlad = [[BLCourseDownloadProcess alloc] init];
            shareCourseDownlad.courseDao = [PLCourseDownLoadDao shareCourseDownloadDao];
        }
    });
    return shareCourseDownlad;
}

-(NSArray *) findAllCourseDownload
{
    return [self.courseDao findAllCourseDownload];
}

-(BOOL) addCourseDownload:(PLCourseDownload *)course
{
    if ([[self.courseDao findCourseDownloading] count] == 0) {
        course.downloadStatus = downloadIng;
    }else{
        course.downloadStatus = downloadWait;
    }
    return [self.courseDao addCourseDownload:course];
}

-(BOOL) removeCourseDownload:(PLCourseDownload *)course
{
    return [self.courseDao removeCourseDownload:course];
}

-(void) startRequestDownloadTaskQueue:(PLCourseDownload *)course
{
    _isRequesting = YES;
    [self.courseDao startRequestDownload:course didDownload:^(PLCourseDownload *courseParam, double totalSize, double downloadSize){
        
        if ([_delegate respondsToSelector:@selector(courseDownload:didTotalSize:didDownloadSize:)]) {
            
            courseParam.downloadStatus = downloadIng;
            [_delegate courseDownload:courseParam didTotalSize:totalSize didDownloadSize:downloadSize];
        }
    }didSuccess:^(id result){
        course.downloadStatus = downloadComplete;
        [courseDao updateCourseDownload:course];
        [_delegate courseDownload:course didTotalSize:0 didDownloadSize:0];
        
        _isRequesting = NO;
        [self requestDownloadTaskQueueNext:course];
        
    }disFail:^(NSString *error){
        
    }];
}

-(void) startRequestData
{
    download_list = [courseDao findAllCourseDownload];
    [self requestDownloadTaskQueueNext:nil];
}

-(void) requestDownloadTaskQueueNext:(PLCourseDownload *)course
{
//    是否正在下载中
    if (_isRequesting) {
        return;
    }
    PLCourseDownload *currentCourse = nil;
//    course 没值表示第一次，有值表示顺序下载，下一个
    if (course) {
        
        int currentIndex;
        for (int i=0 ; i<[download_list count]; i++) {
            PLCourseDownload *temp = [download_list objectAtIndex:i];
            if ([course.downloadPath isEqualToString:temp.downloadPath]) {
                currentIndex = i;
                break;
            }
        }
        
        for (int i = currentIndex; i<[download_list count]; i++) {
            PLCourseDownload *temp = [download_list objectAtIndex:i];
            if (temp.downloadStatus == downloadWait) {
                currentCourse = temp;
                break;
            }
        }
        
//        从下载后面开始找起没有的话，再从头找一边
        if (!currentCourse) {
            for (PLCourseDownload *temp in download_list) {
                if (temp.downloadStatus == downloadWait) {
                    currentCourse = temp;
                    break;
                }
            }
        }
        
    }else{
        for (PLCourseDownload *temp in download_list) {
            if (temp.downloadStatus == downloadIng) {
                currentCourse = temp;
                break;
            }
        }
    }
    if (currentCourse) {
        currentCourse.downloadStatus = downloadIng;
        [self startRequestDownloadTaskQueue:currentCourse];
    }
}

//暂停，主要是针对下载状态
-(void)pauseRequestDownloadTaskQueue:(PLCourseDownload *)course
{
    if (course.downloadStatus == downloadIng) {
        [courseDao pauseRequestDownload:nil];
        
        course.downloadStatus = downloadPause;
        [courseDao updateCourseDownload:course];
        download_list = [courseDao findAllCourseDownload];

        _isRequesting = NO;
        [self requestDownloadTaskQueueNext:course];
        if ([_delegate respondsToSelector:@selector(courseDownload:didTotalSize:didDownloadSize:)]) {
            [_delegate courseDownload:course didTotalSize:course.totalSize didDownloadSize:course.downloadSize];
        }
    }
}

//优先下载，主要是针对 等待和赞停
-(void) priorityRequestDownloadTaskQueue:(PLCourseDownload *)cource
{
    if (_isRequesting) {
        [courseDao pauseRequestDownload:^(NSString *downloadPath){
            PLCourseDownload *currentCourse = nil;
            for (PLCourseDownload *temp in download_list) {
                if ([temp.downloadPath isEqualToString:downloadPath]) {
                    currentCourse = temp;
                    break;
                }
            }
            
            if (currentCourse) {
                currentCourse.downloadStatus = downloadWait;
                [courseDao updateCourseDownload:currentCourse];
                download_list = [courseDao findAllCourseDownload];
                
                if ([_delegate respondsToSelector:@selector(courseDownload:didTotalSize:didDownloadSize:)]) {
                    [_delegate courseDownload:currentCourse didTotalSize:currentCourse.totalSize didDownloadSize:currentCourse.downloadSize];
                }
            }
        }];
    }
    
    _isRequesting = NO;
    cource.downloadStatus = downloadIng;
    [courseDao updateCourseDownload:cource];
    download_list = [courseDao findAllCourseDownload];
    [self requestDownloadTaskQueueNext:nil];
}

-(void) deleteCourseDownloadTaskQueue:(NSArray *)deleteArray
{
    for (PLCourseDownload *delete in deleteArray) {
        if (delete.downloadStatus == downloadIng) {
            
            _isRequesting = NO;
            [self requestDownloadTaskQueueNext:delete];
            [courseDao deleteDownloadTaskInQueue:delete];
            [courseDao removeCourseDownload:delete];
            download_list = [courseDao findAllCourseDownload];
            
        }else{
            [courseDao deleteDownloadTaskInQueue:delete];
            [courseDao removeCourseDownload:delete];
            download_list = [courseDao findAllCourseDownload];
        }
    }
}

///**
// *  为每一个课程下载实体返回状态回调
// *
// *  @param course        下载实体
// *  @param downloadBlock 状态回调
// */
//-(void) addDownloadBlockStatus:(PLCourseDownload *)course didDownloadBlock:(DownloadMbBlock)downloadBlock
//{
//    NSDictionary *blockDic = @{course.downloadPath: downloadBlock};
//    if (![_downloadBlock_list containsObject:blockDic]) { //每个下载实体只能获得一个回调
//        [_downloadBlock_list addObject:blockDic];
//    }
//}
//
//-(void) requestDownloadTaskQueueNext:(PLCourseDownload *)course
//{
//    NSUInteger i = 0;
//    downloadType type = downloadIng;
//    if (course) {
//        type = downloadWait;
//        i = [_download_list indexOfObject:course];
//    }
//    
//    for (; i < [_download_list count];  i++) {
//        PLCourseDownload *course = [_download_list objectAtIndex:i];
//        if (course.downloadStatus == type) {
//            _currentCourseDownload = course;
//            [self startRequestDownload:course];
//        }
//    }
//}
//
//-(void) startRequestDownload:(PLCourseDownload *)course
//{
//    [_courseDao startRequestDownload:course didDownload:^(PLCourseDownload *courseParam, double totalSize, double downloadSize){
//            
//            course.downloadStatus = downloadIng;
//            DownloadMbBlock backBlock = [self getBlockForCourseDownload:courseParam];
//            backBlock(course, totalSize, downloadSize);
//            
//        }didSuccess:^(id result){
//            
//            course.downloadStatus = downloadComplete;
//            DownloadMbBlock backBlock = [self getBlockForCourseDownload:course];
//            backBlock(course, 0, 0);
//            [_courseDao updateCourseDownload:course];
//            _download_list = [_courseDao findAllCourseDownload];
//            [self requestDownloadTaskQueueNext:course];
//            
//        }disFail:^(NSString *error){
//            
//        }];
//}
//
//-(DownloadMbBlock) getBlockForCourseDownload:(PLCourseDownload *)course
//{
//    for (NSDictionary *dic in _downloadBlock_list) {
//        NSString *path = [[dic allKeys] objectAtIndex:0];
//        if ([course.downloadPath isEqualToString:path]) {
//            return [dic objectForKey:path];
//        }
//    }
//    return nil;
//}

//下载完成下载队列下一个
//-(void) downloadCompleteNext:(PLCourseDownload *)courseParam
//{
//    if (courseParam) {
//        NSDictionary *blockDic;
//        for (NSDictionary *dic in _downloadBlock_list) {
//            NSString *path = [[dic allKeys] objectAtIndex:0];
//            if ([courseParam.downloadPath isEqualToString:path]) {
//                
//                courseParam.downloadStatus = downloadIng;
//                [_courseDao updateCourseDownload:courseParam];
//                [self startRequestDownload:courseParam];
//                currentBlock = [dic objectForKey:path];
//                blockDic = dic;
//                break;
//            }
//        }
//        [_downloadBlock_list removeObject:blockDic];
//    }else{
//        if ([_downloadBlock_list count] > 0) {
//            NSDictionary *dic = [_downloadBlock_list objectAtIndex:0];
//            NSString *path = [[dic allKeys] objectAtIndex:0];
//            
//            for (PLCourseDownload *tempCourse in _download_list) {
//                if ([tempCourse.downloadPath isEqualToString:path] && tempCourse.downloadStatus != downloadPause) {
//                    
//                    tempCourse.downloadStatus = downloadIng;
//                    [_courseDao updateCourseDownload:tempCourse];
//                    [self startRequestDownload:tempCourse];
//                    currentBlock = [dic objectForKey:path];
//                    [_downloadBlock_list removeObject:dic];
//                    break;
//                }
//            }
//        }
//    }
//}

//-(void) addRequestDownloadToTaskQueue:(PLCourseDownload *)course didDownload:(DownloadMbBlock)downloadBlock
//{
////    下载中的实体类
//    PLCourseDownload *downloadIngCourse = nil;
//    for (PLCourseDownload *tempCourse in _download_list) {
//        if (tempCourse.downloadStatus == downloadIng) {
//            downloadIngCourse = tempCourse;
//        }
//    }
//    
////    有实体类正在下载
//    if (downloadIngCourse) {
//        
////        判断是否已存在
//        if ([_download_list containsObject:course]) {
//            return;
//        }
//        
////        设置为等待状态
//        course.downloadStatus = downloadWait;
//        [_courseDao updateCourseDownload:course];
//        [_download_list addObject:course];
//        
//        [_downloadBlock_list addObject:@{course.downloadPath : downloadBlock}];
//        downloadBlock(course, 0, 0);
//    }else{
//        
////        设置为下载状态
//        course.downloadStatus = downloadIng;
//        [_courseDao updateCourseDownload:course];
//        [_download_list addObject:course];
//        
//        currentBlock = downloadBlock;
//        [self startRequestDownload:course];
//    }
//}

//-(void) deleteDownloadTaskInQueue:(PLCourseDownload *)course
//{
//    PLCourseDownload *deleteCourse = nil;
//    for (PLCourseDownload *tempCourse in _download_list) {
//        if ([course.downloadPath isEqualToString:tempCourse.downloadPath]) {
//            deleteCourse = tempCourse;
//        }
//    }
//    
//    if (deleteCourse.downloadStatus == downloadComplete) {
//        [_download_list removeObject:deleteCourse];
//    }else if (deleteCourse.downloadStatus == downloadIng) {
//        [_courseDao pauseRequestDownload:deleteCourse];
//        [self downloadCompleteNext:nil];
//        [_download_list removeObject:deleteCourse];
//    }else if (deleteCourse.downloadStatus == downloadPause || deleteCourse.downloadStatus == downloadWait) {
//        [self removeBlockForDownloadQueue:deleteCourse];
//        [_download_list removeObject:deleteCourse];
//    }
//    [_courseDao deleteDownloadTaskInQueue:course];
//}
//
//-(void) removeBlockForDownloadQueue:(PLCourseDownload *)course
//{
//    NSDictionary *blockDic = nil;
//    for (NSDictionary *dic in _downloadBlock_list) {
//        NSString *path = [[dic allKeys] objectAtIndex:0];
//        if ([course.downloadPath isEqualToString:path]) {
//            blockDic = dic;
//            break;
//        }
//    }
//    
//    if (blockDic) {
//        [_downloadBlock_list removeObject:blockDic];
//    }
//}
//
//-(void) pauseRequestDownloadTaskQueue:(PLCourseDownload *)course
//{
//    [_courseDao pauseRequestDownload:course];
//    course.downloadStatus = downloadPause;
//    [_courseDao updateCourseDownload:course];
//    currentBlock(course, 0, 0);
//    DownloadMbBlock tempBlock = currentBlock;
//    [self downloadCompleteNext:nil];
//    [_downloadBlock_list addObject:@{ course.downloadPath : tempBlock }];
//}
//
//-(void) priorityRequestDownloadTaskQueue:(PLCourseDownload *)cource
//{
//    NSString *path = @"";
//    for (PLCourseDownload *tmepCourse in _download_list) {
//        if (tmepCourse.downloadStatus == downloadIng) {
//            
//            path = tmepCourse.downloadPath;
//            tmepCourse.downloadStatus = downloadWait;
//            [_courseDao updateCourseDownload:tmepCourse];
//            currentBlock(tmepCourse, 0, 0);
//            [_courseDao pauseRequestDownload:tmepCourse];
//            break;
//        }
//    }
//    DownloadMbBlock tempBlock = currentBlock;
//    [self downloadCompleteNext:cource];
//    if (![path isEqualToString:@""]) {
//        [_downloadBlock_list addObject:@{path : tempBlock}];
//    }
//}
//
//-(void) pauseTopriorityDownloadTaskQueue:(PLCourseDownload *)course
//{
//    NSString *path;
//    for (PLCourseDownload *tmepCourse in _download_list) {
//        if (tmepCourse.downloadStatus == downloadIng) {
//            
//            path = tmepCourse.downloadPath;
//            tmepCourse.downloadStatus = downloadWait;
//            [_courseDao updateCourseDownload:tmepCourse];
//            currentBlock(tmepCourse, 0, 0);
//            [_courseDao pauseRequestDownload:tmepCourse];
//            break;
//        }
//    }
//    
//    DownloadMbBlock tempBlock = currentBlock;
//    [self downloadCompleteNext:course];
//    [_downloadBlock_list addObject:@{path : tempBlock}];
//}

@end
