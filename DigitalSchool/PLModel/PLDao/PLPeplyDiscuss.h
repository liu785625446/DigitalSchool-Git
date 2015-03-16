//
//  PLPeplyDiscuss.h
//  DigitalSchool
//
//  Created by xiaohj on 15-3-16.
//  Copyright (c) 2015年 刘军林. All rights reserved.
//

#import "PLBaseDao.h"

@interface PLPeplyDiscuss : PLBaseDao
@property (nonatomic, strong) NSString *replyId;
@property (nonatomic, strong) NSString *replyTime;
@property (nonatomic, strong) NSString *replyContent;
@property (nonatomic, strong) NSString *replyUserId;//回复者ID
@property (nonatomic, strong) NSString *replyUserImgUrl;
@property (nonatomic, strong) NSString *replyUserNike;

@end
