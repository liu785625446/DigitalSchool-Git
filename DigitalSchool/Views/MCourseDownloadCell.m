//
//  MCourseCell.m
//  UploadVideo
//
//  Created by 刘军林 on 15/1/13.
//  Copyright (c) 2015年 刘军林. All rights reserved.
//

#import "MCourseDownloadCell.h"

@implementation MCourseDownloadCell

@synthesize courseName;
@synthesize courseProgress;
@synthesize downloadInfo;
@synthesize downloadStatus;
@synthesize selectStatus;
@synthesize selectImgWidth;

-(id) initWithCoder:(NSCoder *)aDecoder
{
    if ([super initWithCoder:aDecoder]) {
    
    }
    return self;
}

@end
