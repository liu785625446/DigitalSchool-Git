//
//  PLNotes.m
//  PersistenceLayer
//
//  Created by 刘军林 on 15/1/8.
//  Copyright (c) 2015年 刘军林. All rights reserved.
//

#import "PLNotes.h"

@implementation PLNotes

@synthesize noteId;
@synthesize noteCreateTime;
@synthesize noteContent;
@synthesize noteCollect;
@synthesize notePraise;
@synthesize courseId;
@synthesize user;

-(id) init
{
    if ([super init]) {
        user = [[PLUser alloc] init];
    }
    return self;
}

-(void) setValue:(id)value forUndefinedKey:(NSString *)key
{
    if ([key isEqualToString:@"collect"]) {
        self.noteCollect = value;
    }
    
    if ([key isEqualToString:@"content"]) {
        self.noteContent = value;
    }
    
    if ([key isEqualToString:@"createTime"]) {
        self.noteCreateTime = value;
    }
    
    if ([key isEqualToString:@"id"]) {
        self.noteId = value;
    }
    
    if ([key isEqualToString:@"praise"]) {
        self.notePraise = value;
    }
    
    if ([key isEqualToString:@"admin"]) {
        [self.user setValuesForKeysWithDictionary:value];
    }
}

-(NSString *) description
{
    return [NSString stringWithFormat:@"PLNotes: { \n noteId:%@ \n noteCreateTime:%@ \n noteContent:%@ \n noteCollect:%@ \n notePraise:%@ \n courseId:%@ \n user:%@ \n} \n",self.noteId, self.noteCreateTime, self.noteContent, self.noteCollect, self.notePraise, self.courseId, self.user];
}

@end
