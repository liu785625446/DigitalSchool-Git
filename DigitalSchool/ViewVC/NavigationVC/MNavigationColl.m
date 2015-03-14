//
//  MNavigationColl.m
//  DigitalSchool
//
//  Created by 刘军林 on 15/3/9.
//  Copyright (c) 2015年 刘军林. All rights reserved.
//

#import "MNavigationColl.h"
#import "UrlImageView.h"

@implementation MNavigationColl

-(void) setNavs:(PLNavs *)navs
{
    _navs = navs;
    _navTitle.text = _navs.navTitle;
    [_navImg setImageWithURL:[NSURL URLWithString:_navs.navImg] placeholderImage:nil];
}

-(void) drawRect:(CGRect)rect
{
    [super drawRect:rect];
    CGContextRef ref = UIGraphicsGetCurrentContext();
    if (_index < 3) {
        CGContextSetLineWidth(ref, 0.2);
        CGContextSetStrokeColorWithColor(ref, [[UIColor grayColor] CGColor]);
        CGContextMoveToPoint(ref, 0, 0);
        CGContextAddLineToPoint(ref, rect.size.width, 0);
        CGContextAddLineToPoint(ref, rect.size.width, rect.size.height);
        CGContextAddLineToPoint(ref, 0, rect.size.height);
    }else{
        CGContextSetLineWidth(ref, 0.2);
        CGContextSetStrokeColorWithColor(ref, [[UIColor grayColor] CGColor]);
        CGContextMoveToPoint(ref, rect.size.width, 0);
        CGContextAddLineToPoint(ref, rect.size.width, rect.size.height);
        CGContextAddLineToPoint(ref, 0, rect.size.height);
    }
    CGContextStrokePath(ref);
}

@end
