//
//  MPwdModifyView.m
//  DigitalSchool
//
//  Created by 刘军林 on 15/3/9.
//  Copyright (c) 2015年 刘军林. All rights reserved.
//

#import "MPwdModifyView.h"

@implementation MPwdModifyView

-(id) initWithTitle:(NSString *)title message:(NSString *)message delegate:(id)delegate cancelButtonTitle:(NSString *)cancelButtonTitle otherButtonTitles:(NSString *)otherButtonTitles, ...
{
    self = [super initWithTitle:title message:message delegate:delegate cancelButtonTitle:cancelButtonTitle otherButtonTitles:otherButtonTitles, nil];
    if (self) {
        
        _pwd1 = [self createTextField:@"请输入原密码" withFrame:CGRectMake(20, 45, self.frame.size.width - 20, 36)];
        [self addSubview:_pwd1];
        
        _pwd2 = [self createTextField:@"请输入新密码" withFrame:CGRectMake(20, 90, self.frame.size.width - 20, 36)];
        [self addSubview:_pwd2];

        _pwd3 = [self createTextField:@"请确认新密码" withFrame:CGRectMake(20, 135, self.frame.size.width - 20, 36)];
        [self addSubview:_pwd3];

        CGRect bounds = self.frame;
        bounds.size.height = 260;
        self.frame = bounds;
    }
    
    return self;
}

-(void) layoutSubviews
{
    [super layoutSubviews];
    
    for (UIView *view in self.subviews) {
        if ([view isKindOfClass:[UIButton class]] ||
            [view isKindOfClass:NSClassFromString(@"UIThreePartButton")]) {
            CGRect btnBounds = view.frame;
            btnBounds.origin.y = self.pwd3.frame.origin.y + self.pwd3.frame.size.height + 7;
            view.frame = btnBounds;
        }
    }
    
    // 定义AlertView的大小
    CGRect bounds = self.frame;
    bounds.size.height = 260;
    self.frame = bounds;
}

-(UITextField *) createTextField:(NSString *)placeholder withFrame:(CGRect)frame {
    UITextField *field = [[UITextField alloc] initWithFrame:frame ];
    field.placeholder = placeholder;
    field.secureTextEntry = YES;
    field.backgroundColor = [UIColor whiteColor];
    field.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    return field;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
