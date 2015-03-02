//
//  VCustomToolBar.h
//  UploadVideo
//
//  Created by 刘军林 on 15/1/15.
//  Copyright (c) 2015年 刘军林. All rights reserved.
//

#import <UIKit/UIKit.h>

@class VCustomToolBar;
@protocol VCustomToolBarDelegate <NSObject>

-(void) customToolBar:(VCustomToolBar *)customToolBar didSelectIndex:(NSInteger)index;

@end

@interface VCustomToolBar : UIView
{
    BOOL isSeparated;
    BOOL isShow;
    CGRect boundRect;
}

@property (nonatomic, strong) id<VCustomToolBarDelegate> delegate;
@property (assign) BOOL isShow;

-(id) initWithTitiles:(NSArray *)titleArray;
-(void) setTitleMethod:(NSString *)title didIndex:(NSInteger)index;

-(void) showToolbarAction;
-(void) hideToolbarAction;
@end
