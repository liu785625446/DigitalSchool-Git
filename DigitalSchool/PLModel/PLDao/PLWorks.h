//
//  PLWorks.h
//  DigitalSchool
//
//  Created by 刘军林 on 15/1/27.
//  Copyright (c) 2015年 刘军林. All rights reserved.
//

#import "PLBaseData.h"
#import "PLUser.h"

//作品表

@interface PLWorks : PLBaseData

@property (nonatomic, strong) NSString *workId;
@property (nonatomic, strong) NSString *workImg;
@property (nonatomic, strong) NSString *workTitle;
@property (nonatomic, strong) NSString *workUpdateTime;
@property (nonatomic, strong) NSString *workURL;
@property (nonatomic, strong) NSString *workWatchNum;
@property (nonatomic, strong) NSString *workIntro;
@property (nonatomic, strong) PLUser *user;

@end
