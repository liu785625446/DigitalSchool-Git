//
//  MBottomView.m
//  DigitalSchool
//
//  Created by rachel on 15/1/20.
//  Copyright (c) 2015年 刘军林. All rights reserved.
//

#import "MBottomView.h"

@implementation MBottomView

-(id)initWithFrame:(CGRect)frame
{
    if ([super initWithFrame:frame])
    {
        [self creatButton];
    }
    return self;
}
-(void)creatButton
{
    float buttonW = self.frame.size.width/6;
    self.backgroundColor = [UIColor whiteColor];
        
    for (int i =0 ; i<6; i++)
    {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(i*buttonW, 0, buttonW, self.frame.size.height);
        NSString *imageNormal = [NSString stringWithFormat:@"BtnBottomNormal%d.png",i];
        NSString *imageHighlighted = [NSString stringWithFormat:@"BtnBottomPressed%d.png",i];
        [button setImage:[UIImage imageNamed:imageNormal]
                forState:UIControlStateNormal];
        [button setImage:[UIImage imageNamed:imageHighlighted]
                forState:UIControlStateHighlighted];
        button.tag = i;
        [button addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
        
        [self addSubview:button];
    }
}

-(void)buttonAction:(UIButton *)btn
{
    if (_delegate && [_delegate respondsToSelector:@selector(didButtonIndex:)])
    {
        [_delegate didButtonIndex:btn.tag];
    }
}

@end
