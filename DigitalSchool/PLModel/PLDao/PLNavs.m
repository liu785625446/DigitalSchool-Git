//
//  PLNavs.m
//  DigitalSchool
//
//  Created by 刘军林 on 15/3/12.
//  Copyright (c) 2015年 刘军林. All rights reserved.
//

#import "PLNavs.h"

@implementation PLNavs

@synthesize navId;
@synthesize navImg;
@synthesize navIndex;
@synthesize navTitle;
@synthesize navType;
@synthesize navTypeValue;

-(id) init
{
    if ([super init]) {
        
    }
    return self;
}

-(void) setValue:(id)value forUndefinedKey:(NSString *)key
{
    if ([key isEqualToString:@"id"]) {
        self.navId = value;
    }
    
    if ([key isEqualToString:@"img"]) {
        self.navImg = value;
    }
    
    if ([key isEqualToString:@"index"]) {
        self.navIndex = value;
    }
    
    if ([key isEqualToString:@"title"]) {
        self.navType = value;
    }
    
    if ([key isEqualToString:@"typeValue"]) {
        self.navTypeValue = value;
    }
}

@end
