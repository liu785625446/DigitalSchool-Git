//
//  NSDateExtra.m
//  DigitalSchool
//
//  Created by xiaohj on 15-3-9.
//  Copyright (c) 2015年 刘军林. All rights reserved.
//

#import "NSDateExtra.h"

@implementation NSDateExtra
+(NSString *)getDatetringWithDate:(NSDate *)time withDateFormat:(NSString *)dateFormat
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:8]];
    [dateFormatter setDateFormat:dateFormat];//hh与HH的区别:分别表示12小时制,24小时制
    NSString *confromTimespStr = [dateFormatter stringFromDate:time];
    
    return confromTimespStr;
}
@end
