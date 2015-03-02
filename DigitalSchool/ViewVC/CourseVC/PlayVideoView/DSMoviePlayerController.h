//
//  DSMoviePlayerController.h
//  CustomVideo
//
//  Created by 刘军林 on 15/1/20.
//  Copyright (c) 2015年 刘军林. All rights reserved.
//

#import <MediaPlayer/MediaPlayer.h>
#import "DSMoviePlayerBar.h"

#define MOVIEPLAYER_HEIGHT [UIScreen mainScreen].bounds.size.width / 3 * 2

@class DSMoviePlayerController;
@protocol DSMoviePlayerDelegate <NSObject>

-(void) moviePlayerClickScreen:(DSMoviePlayerController *)moviePlayer;

@end

@interface DSMoviePlayerController : MPMoviePlayerController

@property (nonatomic, strong) DSMoviePlayerBar *moviePlayerBottomBar;
@property (nonatomic, strong) id<DSMoviePlayerDelegate> delegate;

@property (assign)BOOL isScreen;
@property (assign)BOOL isShowBottomBar;

@property (assign)BOOL isPlayer;

@property (assign) BOOL isOnce;

@property (nonatomic, strong) NSLayoutConstraint *dsTop;
@property (nonatomic, strong) NSLayoutConstraint *dsBottom;
@property (nonatomic, strong) NSLayoutConstraint *dsLeft;
@property (nonatomic, strong) NSLayoutConstraint *dsRight;

-(void) addConstraintSupview:(UIView *)supview;

@end
