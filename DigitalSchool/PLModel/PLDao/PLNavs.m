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
        self.navId = @"";
        self.navImg = @"";
        self.navIndex = @"";
        self.navTitle = @"";
        self.navType = @"";
        self.navTypeValue = @"";
    }
    return self;
}

-(void) setValue:(id)value forUndefinedKey:(NSString *)key
{
    if ([key isEqualToString:@"id"]) {
        self.navId = value;
    }
    
    if ([key isEqualToString:@"img"]) {
        self.navImg = [NSString stringWithFormat:@"%@%@%@",@"http://",ALL_URL, value];
    }
    
    if ([key isEqualToString:@"index"]) {
        self.navIndex = value;
    }
    
    if ([key isEqualToString:@"title"]) {
        self.navTitle = value;
    }
    
    if ([key isEqualToString:@"typeValue"]) {
        self.navTypeValue = value;
    }
    
    if ([key isEqualToString:@"type"]) {
        self.navType = value;
    }
}

-(NSString *) description
{
    return [NSString stringWithFormat:@"PLNavs: { \n navId:%@ \n navImg:%@ \n navIndex:%@ \n navType:%@ \n navTypeValue:%@ \n navTitle:%@\n }",self.navId, self.navImg, self.navIndex, self.navType, self.navTypeValue, self.navTitle];
}

@end
