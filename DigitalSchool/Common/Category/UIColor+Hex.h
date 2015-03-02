//
//  UIColor+Hex.h
//  DigitalScholl
//
//  Created by rachel on 15/1/8.
//  Copyright (c) 2015年 刘军林. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor(Hex)
//将16进制颜色值转化成RGB
+ (UIColor *)colorWithHexString:(NSString *)color alpha:(CGFloat)alpha;
@end
