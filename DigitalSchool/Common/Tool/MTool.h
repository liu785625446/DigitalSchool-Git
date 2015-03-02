//
//  MTool.h
//  DigitalScholl
//
//  Created by rachel on 15/1/14.
//  Copyright (c) 2015年 刘军林. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MTool : NSObject

+(CGSize)boundingRectWithSizeWithText:(NSString *)text MaxSize:(CGSize)maxSize textFont:(UIFont*)textFont;

@end
