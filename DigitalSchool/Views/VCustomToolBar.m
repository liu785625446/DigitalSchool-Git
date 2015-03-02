//
//  VCustomToolBar.m
//  UploadVideo
//
//  Created by 刘军林 on 15/1/15.
//  Copyright (c) 2015年 刘军林. All rights reserved.
//

#import "VCustomToolBar.h"

#define TOOLBAR_HEIGHT 49
#define VERTICAL_START 10
#define BUTTON_ADD_TAG 1000

@implementation VCustomToolBar

-(id) initWithTitiles:(NSArray *)titleArray
{
    boundRect = [UIScreen mainScreen].bounds;
    if ([super initWithFrame:CGRectMake(0, boundRect.size.height, boundRect.size.width, TOOLBAR_HEIGHT)]) {
    
        isSeparated = YES;
        self.isShow = NO;
        for (int i=0 ; i<[titleArray count] ; i++) {
            
            NSString *title = [titleArray objectAtIndex:i];
            float width = boundRect.size.width / [titleArray count];
            UIButton *but = [[UIButton alloc] initWithFrame:CGRectMake(i*width, 0, width, TOOLBAR_HEIGHT)];
            
            but.tag = i + BUTTON_ADD_TAG;
            [but setTitle:title forState:UIControlStateNormal];
            [but setTitle:title forState:UIControlStateHighlighted];
            [but setTitleColor:[UIColor redColor] forState:UIControlStateHighlighted];
            [but setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
            
            [but addTarget:self action:@selector(clickButtonAction:) forControlEvents:UIControlEventTouchUpInside];
            
            self.backgroundColor = [UIColor whiteColor];
            [self addSubview:but];
        }
    }
    return self;
}

-(void) drawRect:(CGRect)rect
{
    [super drawRect:rect];
    CGContextRef ref = UIGraphicsGetCurrentContext();
    CGContextSetLineWidth(ref, 0.5);
    CGContextSetStrokeColorWithColor(ref, [[UIColor grayColor] CGColor]);
    CGContextMoveToPoint(ref, 0, 0);
    CGContextAddLineToPoint(ref, rect.size.width, 0);
    
    if (isSeparated) {
        NSArray *array = [self subviews];
        for (int i=1 ; i<[array count]; i++) {
            UIButton *but = (UIButton *)[array objectAtIndex:i];
            CGContextMoveToPoint(ref, but.frame.origin.x, VERTICAL_START);
            CGContextAddLineToPoint(ref, but.frame.origin.x, self.frame.size.height-VERTICAL_START);
        }
    }
    
    CGContextStrokePath(ref);
}

-(void) hideToolbarAction
{
    [UIView animateWithDuration:0.5 animations:^{
        CGRect frame = self.frame;
        frame.origin.y = boundRect.size.height;
        self.frame = frame;
    }completion:nil];
    self.isShow = NO;
}

-(void) showToolbarAction
{
    [UIView animateWithDuration:0.5 animations:^{
        CGRect frame = self.frame;
        frame.origin.y = boundRect.size.height - self.frame.size.height;
        self.frame = frame;
    }completion:nil];
    self.isShow = YES;
}

-(void) setTitleMethod:(NSString *)title didIndex:(NSInteger)index
{
    UIButton *but = (UIButton *)[self viewWithTag:index + BUTTON_ADD_TAG];
    [but setTitle:title forState:UIControlStateNormal];
    [but setTitle:title forState:UIControlStateHighlighted];
}

-(void) clickButtonAction:(id)sender
{
    UIButton *but = (UIButton *)sender;
    if ([_delegate respondsToSelector:@selector(customToolBar:didSelectIndex:)]) {
        [_delegate customToolBar:self didSelectIndex:but.tag - BUTTON_ADD_TAG];
    }
}

@end
