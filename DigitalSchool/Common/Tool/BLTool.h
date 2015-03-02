//
//  Tool.h
//  BusinessLogicLayer
//
//  Created by 刘军林 on 15/1/7.
//  Copyright (c) 2015年 刘军林. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BLTool : NSObject

+(NSString *)md5:(NSString *)str;

/**
 *  加密传递给服务器的密钥
 *
 *  @return 加密后的密钥
 */
+(NSString *)getKeyCode:(NSString *)str;

+(NSString *)getEncoding:(NSString *)code;

@end
