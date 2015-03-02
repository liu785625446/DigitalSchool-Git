//
//  MTool.m
//  DigitalScholl
//
//  Created by rachel on 15/1/14.
//  Copyright (c) 2015年 刘军林. All rights reserved.
//

#import "MTool.h"

@implementation MTool
+(CGSize)boundingRectWithSizeWithText:(NSString *)text MaxSize:(CGSize)maxSize textFont:(UIFont*)textFont
{
    
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc]init];
    paragraphStyle.lineBreakMode = NSLineBreakByWordWrapping;
    NSDictionary *attributes = @{NSFontAttributeName:textFont};
    
    CGSize textSize = [text boundingRectWithSize:maxSize
                                         options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading
                                               attributes:attributes        // 文字的属性
                                                  context:nil].size;
    // context上下文。包括一些信息，例如如何调整字间距以及缩放。该对象包含的信息将用于文本绘制。该参数可为nil
    
    return textSize;
}
@end
