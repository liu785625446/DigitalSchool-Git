//
//  MReplyDiscussCell.m
//  DigitalSchool
//
//  Created by rachel on 15/3/16.
//  Copyright (c) 2015年 刘军林. All rights reserved.
//

#import "MReplyDiscussCell.h"

@implementation MReplyDiscussCell

- (void)awakeFromNib
{
    self.iconImg.layer.masksToBounds = YES;
    self.iconImg.layer.cornerRadius = self.iconImg.frame.size.width/2;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    
}

-(void)drawRect:(CGRect)rect
{
    [super drawRect:rect];
    CGContextRef ref = UIGraphicsGetCurrentContext();
    CGContextSetLineWidth(ref, 0.5);
    CGContextSetStrokeColorWithColor(ref, [[UIColor grayColor] CGColor]);
    CGContextMoveToPoint(ref, 0, rect.size.height);
    CGContextAddLineToPoint(ref, rect.size.width, rect.size.height);
    CGContextStrokePath(ref);
}

@end
