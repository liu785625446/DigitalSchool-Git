//
//  MCourseDownload.m
//  UploadVideo
//
//  Created by 刘军林 on 15/1/13.
//  Copyright (c) 2015年 刘军林. All rights reserved.
//

#import "PLCourseDownload.h"

@implementation PLCourseDownload

-(id)init
{
    if ([super init]) {
        _downloadName = @"";
        _downloadPath = @"";
        _downloadURL = @"";
        _downloadStatus = downloadWait;
        _downloadSize = 0.f;
        _totalSize = 0.f;
    }
    return self;
}

-(NSString *) description
{
    return [NSString stringWithFormat:@"name:%@   path:%@    URL:%@    status:%d", _downloadName, _downloadPath, _downloadURL,_downloadStatus];
}

@end
