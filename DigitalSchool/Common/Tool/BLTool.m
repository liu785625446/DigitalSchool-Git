//
//  Tool.m
//  BusinessLogicLayer
//
//  Created by 刘军林 on 15/1/7.
//  Copyright (c) 2015年 刘军林. All rights reserved.
//

#import "BLTool.h"
#import <CommonCrypto/CommonDigest.h>

@implementation BLTool

+(NSString *)md5:(NSString *)str
{
    const char *cStr = [str UTF8String];
    unsigned char result[16];
    CC_MD5(cStr, strlen(cStr), result); // This is the md5 call
    return [NSString stringWithFormat:
             @"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x",
             result[0], result[1], result[2], result[3],
             result[4], result[5], result[6], result[7],
             result[8], result[9], result[10], result[11],
             result[12], result[13], result[14], result[15]
             ];
}

+(NSString *)getKeyCode:(NSString *)str
{
    static NSString *PRIVATE_KEY = @"900152a83cd84fc0d796af7d28e17f52";
//    NSString *url = [BLTool getEncoding:str];
    
    NSRange range = NSMakeRange(1, 7);
    NSString *first = [NSString stringWithFormat:@"%@%@",[[BLTool md5:[str lowercaseString]] substringWithRange:range], PRIVATE_KEY];
    range = NSMakeRange(0, 10);
    return [[[BLTool md5:first] substringWithRange:range] lowercaseString];
}

+(NSString *)getEncoding:(NSString *)code
{
    return (NSString *)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault, (CFStringRef)code, NULL, CFSTR(":/?#[]@!$ &'()*+,;=\"<>%{}|\\^~`"), kCFStringEncodingUTF8));
}

@end
