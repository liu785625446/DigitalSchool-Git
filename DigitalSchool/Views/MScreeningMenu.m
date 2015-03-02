//
//  MScreeningMenu.m
//  DigitalScholl
//
//  Created by rachel on 15/1/14.
//  Copyright (c) 2015年 刘军林. All rights reserved.
//

#import "MScreeningMenu.h"

#import "MScreenHrizontalView.h"

#define kScrollerViewTag 12

@interface MScreeningMenu()
<MScreenHrizontalViewDelegate>

@end

@implementation MScreeningMenu
-(id)initWithFrame:(CGRect)frame memus:(NSArray *)memus
{
    return [self initWithFrame:frame memus:memus menuSelects:nil];
}

-(id)initWithFrame:(CGRect)frame memus:(NSArray *)memus menuSelects:(NSArray *)menuSelects
{
    if ([super initWithFrame:frame])
    {
        [self initMenu:memus menuSelects:(NSArray *)menuSelects];
    }
    return self;
}

-(void)initMenu:(NSArray *)menus menuSelects:(NSArray *)menuSelects
{
    self.backgroundColor = [UIColor whiteColor];
    
    for (int i=0 ; i<menus.count; i++)
    {
        NSArray *items = [menus objectAtIndex:i];
        NSInteger selectRow = 0;
        
        if (menuSelects && menuSelects.count>0)
        {
            for (id object in menuSelects)
            {
                if ([object isKindOfClass:[NSIndexPath class]])
                {
                    NSIndexPath *indexPath = object;
                    if (indexPath.section == i)
                    {
                        selectRow = indexPath.row;
                    }
                }
                
            }
        }
        
        CGRect rect = CGRectMake(5, i*kMenuHeight+kSpace*i,self.frame.size.width-5,kMenuHeight);
        MScreenHrizontalView *scrollelView =[[MScreenHrizontalView alloc]initWithFrame:rect
                                                                                 items:items
                                                                             selectRow:selectRow];
        scrollelView.showsVerticalScrollIndicator = NO;
        scrollelView.showsHorizontalScrollIndicator = NO;
        scrollelView.tag = i+kScrollerViewTag;
        scrollelView.mDelegate = self;
        [self addSubview:scrollelView];
        
        if (i<menus.count)
        {
            UIView *line = [[UIView alloc]init];
            line.frame = CGRectMake(0, scrollelView.frame.origin.y+scrollelView.frame.size.height+kSpace/2, self.frame.size.width, 0.5);
            line.backgroundColor = [UIColor grayColor];
            [self addSubview:line];
        }
        
        [scrollelView setContentSize:CGSizeMake(0, scrollelView.frame.size.height)];        
    }
}

#pragma mark- MScreenHrizontalViewDelegate
-(void)didButtonIndex:(NSInteger)index menuObject:(id)menuObject hrizontalView:(MScreenHrizontalView *)hrizontalView
{
    if (_delegate && [_delegate respondsToSelector:@selector(didMenuLine:row:menuObject:)])
    {
        NSInteger line = hrizontalView.tag-kScrollerViewTag;
        [_delegate didMenuLine:line row:index menuObject:menuObject];
    }
}

@end
