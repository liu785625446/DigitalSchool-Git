//
//  MScreenHrizontalView.m
//  DigitalScholl
//
//  Created by rachel on 15/1/14.
//  Copyright (c) 2015年 刘军林. All rights reserved.
//

#import "MScreenHrizontalView.h"

#define kButtonTag 99

@implementation MScreenHrizontalView
-(id)initWithFrame:(CGRect)frame items:(NSArray *)items
{
    return [self initWithFrame:frame items:items selectRow:0];
}
-(id)initWithFrame:(CGRect)frame items:(NSArray *)items selectRow:(NSInteger)selectRow
{
    self = [super initWithFrame:frame];
    if (self)
    {
        [self initItems:items selectRow:selectRow];
    }
    return self;
}
-(void)initItems:(NSArray *)items selectRow:(NSInteger)selectRow
{
    if (!mArray)
    {
        mArray = [[NSMutableArray alloc]init];
    }
    [mArray addObjectsFromArray:items];
    
    
    for (int i=0; i<items.count; i++)
    {
        NSString *title = @"";
        
        id object = [items objectAtIndex:i];
        if ([object isKindOfClass:[NSDictionary class]])
        {
           title =  [object objectForKey:@"name"];
            if (title.length<=0)
            {
                [object objectForKey:@"title"];
            }
            
        }else
        {
            title = object;
        }
        
        CGSize max = [MTool boundingRectWithSizeWithText:title
                                                 MaxSize:CGSizeMake(100, self.frame.size.height)
                                                textFont:[UIFont systemFontOfSize:14]];
        UIButton *nextButton = nil;
        if (i!=0)
        {
            nextButton = (UIButton *)[self viewWithTag:i-1+kButtonTag];
        }
        UIButton *itemButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [itemButton setTitle:title forState:UIControlStateNormal];
        itemButton.titleLabel.font = [UIFont systemFontOfSize:14];
        [itemButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
        [itemButton setTitleColor:[UIColor orangeColor] forState:UIControlStateHighlighted];
        [itemButton setTitleColor:[UIColor colorWithHexString:MNavBarBarkGroundColor alpha:1] forState:UIControlStateSelected];
        float btnX = (i!=0?(nextButton.frame.size.width+nextButton.frame.origin.x+MSpace):(i*max.width+i*MSpace));
        itemButton.frame = CGRectMake(btnX, 0, max.width+5, self.frame.size.height);
        itemButton.tag = i+kButtonTag;
        [itemButton addTarget:self action:@selector(screenMenuButton:) forControlEvents:UIControlEventTouchUpInside];
        if (i==selectRow)
        {
            itemButton.selected = YES;
            currentIndex = selectRow;
        }
        
        [self addSubview:itemButton];
        
        contentSizeWidth +=(max.width+5);
    }
    contentSizeWidth +=items.count*MSpace;
    
    
}
-(void)setContentSize:(CGSize)contentSize
{
    [super setContentSize:CGSizeMake(contentSizeWidth, contentSize.height)];
}

-(void)screenMenuButton:(UIButton *)button
{
    NSInteger index = button.tag-kButtonTag;
    if (currentIndex != index)
    {
        for (UIView *view in self.subviews)
        {
            if ([view isKindOfClass:[UIButton class]])
            {
                UIButton *mbtn = (UIButton *)view;
                if (mbtn.tag != button.tag)
                {
                    mbtn.selected = NO;
                }
            }
        }
        button.selected = YES;
        
        if (_mDelegate && [_mDelegate respondsToSelector:@selector(didButtonIndex:menuObject:hrizontalView:)])
        {
            NSInteger index = button.tag-kButtonTag;
            [_mDelegate didButtonIndex:index
                            menuObject:[mArray objectAtIndex:index]
                         hrizontalView:self];
        }
        currentIndex = index;
    }
    
}

@end
