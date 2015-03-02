//
//  PLMKDownloadOperation.h
//  UploadVideo
//
//  Created by 刘军林 on 15/1/14.
//  Copyright (c) 2015年 刘军林. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MKNetworkOperation.h"

typedef void (^PLMKDownLoadMbBlock) (double totalSize, double downloadSize);


@interface PLMKDownloadOperation : MKNetworkOperation
{
    PLMKDownLoadMbBlock downloadMbBlock;
    
    NSTimer *downLoadTimer;
}

-(void) onDownloadMbChanged:(PLMKDownLoadMbBlock) block;

@end
