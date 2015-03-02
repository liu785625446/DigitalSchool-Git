//
//  PLNotes.h
//  PersistenceLayer
//
//  Created by 刘军林 on 15/1/8.
//  Copyright (c) 2015年 刘军林. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PLBaseData.h"
#import "PLUser.h"
//笔记表

@interface PLNotes : PLBaseData

@property (nonatomic, strong) NSString *noteCollect;
@property (nonatomic, strong) NSString *noteContent;
@property (nonatomic, strong) NSString *courseId;
@property (nonatomic, strong) NSString *noteCreateTime;
@property (nonatomic, strong) NSString *noteId;
@property (nonatomic, strong) NSString *notePraise;
@property (nonatomic, strong) PLUser *user;

@end
