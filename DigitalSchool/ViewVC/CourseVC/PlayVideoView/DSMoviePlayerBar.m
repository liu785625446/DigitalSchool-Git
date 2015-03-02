//
//  DSMoviePlayerBar.m
//  CustomVideo
//
//  Created by 刘军林 on 15/1/20.
//  Copyright (c) 2015年 刘军林. All rights reserved.
//

#import "DSMoviePlayerBar.h"

#define BUTTON_HEIGHT 30
#define BUTTON_WIDTH 30
#define BUTTON_HORIZONTAL_SPACE 10
#define BUTTON_VERTICAL_SPACE 10

#define SLIDER_HEIGHT 10
#define SLIDER_VERTICAL_SPACE 20

#define LABEL_VERTICAL_SPACE 8
#define LABEL_HEIGHT 10
#define LABEL_WIDTH 50
#define LABEL_FONT 10

@implementation DSMoviePlayerBar

-(id) init
{
    if ([super init]) {
        self.backgroundColor = [UIColor blackColor];
        //        self.alpha = 0.6;
        //        播放暂停按钮
        _playPauseButton = [[UIButton alloc] init];
        [_playPauseButton setImage:[UIImage imageNamed:@"moviePauseButton.png"] forState:UIControlStateNormal];
        [_playPauseButton setImage:[UIImage imageNamed:@"moviePlayButton.png"] forState:UIControlStateSelected];
        _playPauseButton.translatesAutoresizingMaskIntoConstraints = NO;
        [self addSubview:_playPauseButton];
        
        NSLayoutConstraint *playTop = [NSLayoutConstraint constraintWithItem:_playPauseButton attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeTop multiplier:1.0 constant:BUTTON_VERTICAL_SPACE];
        [self addConstraint:playTop];
        
        NSLayoutConstraint *playLeft = [NSLayoutConstraint constraintWithItem:_playPauseButton attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeLeading multiplier:1.0 constant:BUTTON_HORIZONTAL_SPACE];
        [self addConstraint:playLeft];
        
        NSLayoutConstraint *playWidth = [NSLayoutConstraint constraintWithItem:_playPauseButton attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:BUTTON_WIDTH];
        [_playPauseButton addConstraint:playWidth];
        
        NSLayoutConstraint *playHeight = [NSLayoutConstraint constraintWithItem:_playPauseButton attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:BUTTON_HEIGHT];
        [_playPauseButton addConstraint:playHeight];
        
        //        全屏按钮
        _fullScreenButton = [[UIButton alloc] init];
        [_fullScreenButton setImage:[UIImage imageNamed:@"movieFullScreen.png"] forState:UIControlStateNormal];
        [_fullScreenButton setImage:[UIImage  imageNamed:@"movieFullScreen.png"] forState:UIControlStateHighlighted];
        _fullScreenButton.translatesAutoresizingMaskIntoConstraints = NO;
        [self addSubview:_fullScreenButton];
        
        NSLayoutConstraint *fullTop = [NSLayoutConstraint constraintWithItem:_fullScreenButton attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeTop multiplier:1.0 constant:BUTTON_VERTICAL_SPACE];
        [self addConstraint:fullTop];
        
        NSLayoutConstraint *fullRight = [NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeTrailing relatedBy:NSLayoutRelationEqual toItem:_fullScreenButton attribute:NSLayoutAttributeTrailing multiplier:1.0 constant:BUTTON_HORIZONTAL_SPACE];
        [self addConstraint:fullRight];
        
        NSLayoutConstraint *fullWidth = [NSLayoutConstraint constraintWithItem:_fullScreenButton attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:BUTTON_WIDTH];
        [_fullScreenButton addConstraint:fullWidth];
        
        NSLayoutConstraint *fullHeight = [NSLayoutConstraint constraintWithItem:_fullScreenButton attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:BUTTON_HEIGHT];
        [_fullScreenButton addConstraint:fullHeight];
        
        //        进度条按钮
        _durationSlider = [[UISlider alloc] init];
        [_durationSlider setThumbImage:[UIImage imageNamed:@"movieSliderImg.png"] forState:UIControlStateNormal];
        _durationSlider.translatesAutoresizingMaskIntoConstraints = NO;
        [self addSubview:_durationSlider];
        
        NSLayoutConstraint *sliderTop = [NSLayoutConstraint constraintWithItem:_durationSlider attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeTop multiplier:1.0 constant:SLIDER_VERTICAL_SPACE];
        [self addConstraint:sliderTop];
        
        NSLayoutConstraint *sliderLief = [NSLayoutConstraint constraintWithItem:_durationSlider attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeLeading multiplier:1.0 constant:BUTTON_WIDTH + BUTTON_HORIZONTAL_SPACE * 2];
        [self addConstraint:sliderLief];
        
        NSLayoutConstraint *sliderRight = [NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeTrailing relatedBy:NSLayoutRelationEqual toItem:_durationSlider attribute:NSLayoutAttributeTrailing multiplier:1.0 constant:BUTTON_WIDTH + BUTTON_HORIZONTAL_SPACE * 2];
        [self addConstraint:sliderRight];
        
        NSLayoutConstraint *sliderHeight = [NSLayoutConstraint constraintWithItem:_durationSlider attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:SLIDER_HEIGHT];
        [_durationSlider addConstraint:sliderHeight];
        
        _playerTime = [[UILabel alloc] init];
        _playerTime.textColor = [UIColor whiteColor];
        _playerTime.font = [UIFont systemFontOfSize:LABEL_FONT];
        _playerTime.text = @"00:00";
        [self addSubview:_playerTime];
        _playerTime.translatesAutoresizingMaskIntoConstraints = NO;
        
        NSLayoutConstraint *playerTop = [NSLayoutConstraint constraintWithItem:_playerTime attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeTop multiplier:1.0 constant:LABEL_VERTICAL_SPACE];
        [self addConstraint:playerTop];
        
        NSLayoutConstraint *playerlife = [NSLayoutConstraint constraintWithItem:_playerTime attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeLeading multiplier:1.0 constant:BUTTON_WIDTH + BUTTON_HORIZONTAL_SPACE * 2];
        [self addConstraint:playerlife];
        
        NSLayoutConstraint *playerHeight = [NSLayoutConstraint constraintWithItem:_playerTime attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:LABEL_HEIGHT];
        [_playerTime addConstraint:playerHeight];
        
        NSLayoutConstraint *playerWidth = [NSLayoutConstraint constraintWithItem:_playerTime attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:LABEL_WIDTH];
        [_playerTime addConstraint:playerWidth];
        
        _totalTime = [[UILabel alloc] init];
        _totalTime.textColor = [UIColor whiteColor];
        _totalTime.font = [UIFont systemFontOfSize:LABEL_FONT];
        _totalTime.textAlignment = NSTextAlignmentRight;
        _totalTime.text = @"00:00";
        [self addSubview:_totalTime];
        _totalTime.translatesAutoresizingMaskIntoConstraints = NO;
        
        NSLayoutConstraint *totalTop = [NSLayoutConstraint constraintWithItem:_totalTime attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeTop multiplier:1.0 constant:LABEL_VERTICAL_SPACE];
        [self addConstraint:totalTop];
        
        NSLayoutConstraint *totalRight = [NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeTrailing relatedBy:NSLayoutRelationEqual toItem:_totalTime attribute:NSLayoutAttributeTrailing multiplier:1.0 constant:50];
        [self addConstraint:totalRight];
        
        NSLayoutConstraint *totalWidth = [NSLayoutConstraint constraintWithItem:_totalTime attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:LABEL_WIDTH];
        [_totalTime addConstraint:totalWidth];
        
        NSLayoutConstraint *totalHeight = [NSLayoutConstraint constraintWithItem:_totalTime attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:LABEL_HEIGHT];
        [_totalTime addConstraint:totalHeight];
    }
    
    return self;
}


@end
