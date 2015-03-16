//
//  PLPeplyDiscuss.m
//  DigitalSchool
//
//  Created by xiaohj on 15-3-16.
//  Copyright (c) 2015年 刘军林. All rights reserved.
//

#import "PLPeplyDiscuss.h"

@implementation PLPeplyDiscuss
@synthesize replyContent;
@synthesize replyId;
@synthesize replyTime;
@synthesize replyUserId;
@synthesize replyUserImgUrl;
@synthesize replyUserNike;

-(id)init
{
    self = [super init];
    if (self) {
        replyUserNike = @"";
        replyUserImgUrl = @"";
        replyTime = @"";
        replyId = @"";
        replyContent = @"";
        replyUserId = @"";
    }
    return self;
}

-(void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    
}

@end
