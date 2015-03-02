//
//  MScreeningMenu.h
//  DigitalScholl
//
//  Created by rachel on 15/1/14.
//  Copyright (c) 2015年 刘军林. All rights reserved.
//
//  筛选界面菜单view

#import <UIKit/UIKit.h>

#define kMenuHeight 35
#define kSpace 0

@protocol MScreeningMenuDelegate <NSObject>

-(void)didMenuLine:(NSInteger)line row:(NSInteger)row menuObject:(id)menuObject;

@end

@interface MScreeningMenu : UIView

@property(nonatomic,assign)id<MScreeningMenuDelegate>delegate;

-(id)initWithFrame:(CGRect)frame memus:(NSArray *)memus;
-(id)initWithFrame:(CGRect)frame memus:(NSArray *)memus menuSelects:(NSArray *)menuSelects;

@end
