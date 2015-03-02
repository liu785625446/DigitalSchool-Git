//
//  MenuHrizontalView.m
//  DigitalScholl
//
//  Created by rachel on 15/1/6.
//  Copyright (c) 2015年 刘军林. All rights reserved.
//

#import "MenuHrizontalView.h"

#define kButtonTag 99
#define kLineTag 520

@implementation MenuHrizontalView

- (id)initWithFrame:(CGRect)frame
        ButtonItems:(NSArray *)aItemsArray
          itemWidth:(float)itemWidth
    itemNormalColor:(UIColor *)itemNormalColor
    itemSelectColor:(UIColor *)itemSelectColor
{
    self = [super initWithFrame:frame];
    mItemWidth = itemWidth;
    mItemNormalColor = itemNormalColor;
    mItemSelectColor = itemSelectColor;
    
    if (self)
    {
        [self createMenuItems:aItemsArray];
    }
    return self;
}

-(void)createMenuItems:(NSArray *)itemsArray
{
    if (mScrollView == nil)
    {
        mScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height-2)];
        mScrollView .showsHorizontalScrollIndicator = NO;
        [self addSubview:mScrollView];
    }
    
    
    for (int i=0; i<itemsArray.count; i++)
    {
        NSString *title = @"";
        id object = [itemsArray objectAtIndex:i];
        if ([object isKindOfClass:[NSDictionary class]])
        {
            
            title = [object objectForKey:@"title"];
            
        }else
        {
            title = object;
        }
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setTitleColor:mItemNormalColor forState:UIControlStateNormal];
        [button setTitleColor:mItemSelectColor forState:UIControlStateSelected];
        if (i == 0)
        {
            button.selected = YES;
        }
        [button addTarget:self action:@selector(menuButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
        button.tag = i+kButtonTag;
        button.titleLabel.font = [UIFont systemFontOfSize:15];
        [button setTitle:title forState:UIControlStateNormal];
        [button setFrame:CGRectMake(i*mItemWidth, 1, mItemWidth, mScrollView.frame.size.height)];
        [mScrollView addSubview:button];
    }
    
    UIView *line = [[UIView alloc]initWithFrame:CGRectMake(0, mScrollView.frame.size.height-4, mItemWidth, 4)];
    line.backgroundColor = mItemSelectColor;
    line.tag = kLineTag;
    [mScrollView addSubview:line];
    
    UIView *backLine = [[UIView alloc]initWithFrame:CGRectMake(0, self.frame.size.height-2, self.frame.size.width, 2)];
    backLine.backgroundColor = mItemSelectColor;
    [self addSubview:backLine];
    
    [mScrollView setContentSize:CGSizeMake(itemsArray.count*mItemWidth, mScrollView.frame.size.height)];
    
}
#pragma mark - 点击事件
-(void)menuButtonClicked:(UIButton *)aButton
{
    for (UIView *view in mScrollView.subviews)
    {
        if ([view isKindOfClass:[UIButton class]])
        {
            if (aButton != view)
            {
                UIButton *button = (UIButton *)view;
                button.selected = NO;
            }
        }else if ([view isKindOfClass:[UIView class]])
        {
            [UIView animateWithDuration:0.3 animations:^{
                
                view.frame = CGRectMake(aButton.frame.origin.x, view.frame.origin.y,
                                        view.frame.size.width, view.frame.size.height);
                
            }];
            
        }
    }
    aButton.selected = YES;
    [self movoButtonToVisual:aButton];
    
    if (_delegate && [_delegate respondsToSelector:@selector(didMenuHrizontalView:itemTag:)])
    {
        [_delegate didMenuHrizontalView:self itemTag:aButton.tag - kButtonTag];
    }
}
-(void)setSelectButton:(NSInteger)tag
{
    for (UIView *view in mScrollView.subviews)
    {
        if ([view isKindOfClass:[UIButton class]])
        {
            UIButton *button = (UIButton *)view;
            if (view.tag == tag+kButtonTag)
            {
                button.selected = YES;
                UIView *line = [mScrollView viewWithTag:kLineTag];
                [UIView animateWithDuration:0.3 animations:^{
                    
                    line.frame = CGRectMake(button.frame.origin.x, line.frame.origin.y,
                                            line.frame.size.width, line.frame.size.height);
                    
                }];
                [self movoButtonToVisual:button];
                
            }else
            {
                button.selected = NO;
            }
        }
    }
}

-(void)movoButtonToVisual:(UIButton*)button
{
    if (button.frame.origin.x >= self.frame.size.width-20)
    {
        if ((button.frame.origin.x + 180) >= mScrollView.contentSize.width)
        {
            [mScrollView setContentOffset:CGPointMake(mScrollView.contentSize.width - self.frame.size.width, mScrollView.contentOffset.y)
                                 animated:YES];
            return;
        }
        
        float moveToContentOffset = button.frame.origin.x - 180;
        if (moveToContentOffset > 0)
        {
            [mScrollView setContentOffset:CGPointMake(moveToContentOffset, mScrollView.contentOffset.y)
                                 animated:YES];
        }
        
    }else
    {
        [mScrollView setContentOffset:CGPointMake(0, mScrollView.contentOffset.y)
                             animated:YES];
    }
    
}

@end
