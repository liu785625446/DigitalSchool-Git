//
//  MCourseDownload.h
//  UploadVideo
//
//  Created by 刘军林 on 15/1/13.
//  Copyright (c) 2015年 刘军林. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PLBaseData.h"

typedef enum : NSUInteger {
    downloadIng = 0,
    downloadPause,
    downloadWait,
    downloadComplete,
}downloadType;

@interface PLCourseDownload : PLBaseData

@property (nonatomic, strong) NSString *downloadName;
@property (nonatomic, strong) NSString *downloadPath;
@property (nonatomic, strong) NSString *downloadURL;
@property (assign) int downloadStatus;

@property (assign) double totalSize;
@property (assign) double downloadSize;

@end
