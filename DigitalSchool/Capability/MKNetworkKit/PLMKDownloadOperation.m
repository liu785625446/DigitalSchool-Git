//
//  PLMKDownloadOperation.m
//  UploadVideo
//
//  Created by 刘军林 on 15/1/14.
//  Copyright (c) 2015年 刘军林. All rights reserved.
//

#import "PLMKDownloadOperation.h"

@implementation PLMKDownloadOperation

-(void) connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    [super connection:connection didReceiveData:data];
    
    if (!downLoadTimer) {
        downLoadTimer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(perSecondTimerAction) userInfo:nil repeats:YES];
    }
}

-(void) connectionDidFinishLoading:(NSURLConnection *)connection
{
    [super connectionDidFinishLoading:connection];
    
    [self perSecondTimerAction];
    if (downLoadTimer) {
        [downLoadTimer invalidate];
        downLoadTimer = 0;
    }
}

-(void) perSecondTimerAction{
    downloadMbBlock((double)(self.startPosition + [self.response expectedContentLength]), self.downloadedDataSize);
}

-(void) onDownloadMbChanged:(PLMKDownLoadMbBlock)block
{
    downloadMbBlock = block;
}

-(void) cancel{
    [super cancel];
    if (downLoadTimer) {
        [downLoadTimer invalidate];
        downLoadTimer = nil;
    }
}

@end
