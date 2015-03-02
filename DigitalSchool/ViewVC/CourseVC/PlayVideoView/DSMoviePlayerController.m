//
//  DSMoviePlayerController.m
//  CustomVideo
//
//  Created by 刘军林 on 15/1/20.
//  Copyright (c) 2015年 刘军林. All rights reserved.
//

#import "DSMoviePlayerController.h"

#define MOVIEPLAYER_BAR_HEIGHT 50

@interface DSMoviePlayerController ()

@property (nonatomic,strong) NSTimer *durationTimer;

@end

@implementation DSMoviePlayerController
@synthesize moviePlayerBottomBar;

-(id) init
{
    if ([super init]) {
        _isOnce = YES;
        self.view.backgroundColor = [UIColor blackColor];
        self.view.translatesAutoresizingMaskIntoConstraints = NO;
        [self setControlStyle:MPMovieControlStyleNone];
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(moviePlayerClickAction:)];
        tap.numberOfTouchesRequired = 1;
        tap.numberOfTapsRequired = 1;
        self.view.userInteractionEnabled = YES;
        [self.view addGestureRecognizer:tap];
        
        _isScreen = NO;
        _isShowBottomBar = NO;
        
        self.moviePlayerBottomBar = [[DSMoviePlayerBar alloc] init];
        self.moviePlayerBottomBar.translatesAutoresizingMaskIntoConstraints = NO;
        [self.view addSubview:self.moviePlayerBottomBar];
        
        [self.moviePlayerBottomBar.fullScreenButton addTarget:self action:@selector(clickScreenAction:) forControlEvents:UIControlEventTouchUpInside];
        [self.moviePlayerBottomBar.playPauseButton addTarget:self action:@selector(moviePlayPauseAction:) forControlEvents:UIControlEventTouchUpInside];
        
        NSLayoutConstraint *barBottom = [NSLayoutConstraint constraintWithItem:self.view attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.moviePlayerBottomBar attribute:NSLayoutAttributeBottom multiplier:1.0 constant:0];
        [self.view addConstraint:barBottom];
        
        NSLayoutConstraint *barLeft = [NSLayoutConstraint constraintWithItem:self.moviePlayerBottomBar attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeLeading multiplier:1.0 constant:0];
        [self.view addConstraint:barLeft];
        
        NSLayoutConstraint *barRight = [NSLayoutConstraint constraintWithItem:self.view attribute:NSLayoutAttributeTrailing  relatedBy:NSLayoutRelationEqual toItem:self.moviePlayerBottomBar attribute:NSLayoutAttributeTrailing multiplier:1.0 constant:0];
        [self.view addConstraint:barRight];
        
        NSLayoutConstraint *barHeight = [NSLayoutConstraint constraintWithItem:self.moviePlayerBottomBar attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:MOVIEPLAYER_BAR_HEIGHT];
        [self.moviePlayerBottomBar addConstraint:barHeight];
        
        [self.moviePlayerBottomBar.durationSlider addTarget:self action:@selector(sliderChangeAction:) forControlEvents:UIControlEventValueChanged];
        [self.moviePlayerBottomBar.durationSlider addTarget:self action:@selector(sliderTouchBegan:) forControlEvents:UIControlEventTouchDown];
        [self.moviePlayerBottomBar.durationSlider addTarget:self action:@selector(sliderTouchEnded:) forControlEvents:UIControlEventTouchUpInside];
        [self.moviePlayerBottomBar.durationSlider addTarget:self action:@selector(sliderTouchEnded:) forControlEvents:UIControlEventTouchUpOutside];
    }
    
    [self startDurationTimer];
    _isPlayer = YES;
    return self;
}

-(void) addConstraintSupview:(UIView *)supview
{
    CGRect rect = [UIScreen mainScreen].bounds;
    _dsTop = [NSLayoutConstraint constraintWithItem:self.view attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:supview attribute:NSLayoutAttributeTop multiplier:1.0 constant:0];
    [supview addConstraint:_dsTop];
    
    _dsBottom = [NSLayoutConstraint constraintWithItem:supview attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeBottom multiplier:1.0 constant:rect.size.height - MOVIEPLAYER_HEIGHT];
    [supview addConstraint:_dsBottom];
    
    _dsLeft = [NSLayoutConstraint constraintWithItem:self.view attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:supview attribute:NSLayoutAttributeLeading multiplier:1.0 constant:0];
    [supview addConstraint:_dsLeft];
    
    _dsRight = [NSLayoutConstraint constraintWithItem:supview attribute:NSLayoutAttributeTrailing  relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeTrailing multiplier:1.0 constant:0];
    [supview addConstraint:_dsRight];
}

-(void) moviePlayerClickAction:(id)sender
{
//    self.moviePlayerBottomBar.hidden = !self.moviePlayerBottomBar.hidden;
}

-(void) clickScreenAction:(id)sender
{
    CGRect rect = [UIScreen mainScreen].bounds;
    float offx = (rect.size.height - rect.size.width) /2;
    
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0) {
//        [UIView animateWithDuration:0.5 animations:^{
            if (_isScreen) {
                _dsTop.constant = 0;
                _dsBottom.constant = rect.size.height - MOVIEPLAYER_HEIGHT;
                _dsLeft.constant = 0;
                _dsRight.constant = 0;
                _isScreen = NO;
                self.view.transform = CGAffineTransformMakeRotation(0);
            }else{
                
                _dsTop.constant = offx;
                _dsBottom.constant = offx;
                _dsLeft.constant = -offx;
                _dsRight.constant = -offx;
                _isScreen = YES;
                self.view.transform = CGAffineTransformMakeRotation(M_PI / 2);
            }
//        }completion:nil];
    }else{
//        [UIView animateWithDuration:0.5 animations:^{
            if (_isScreen) {
                //            _dsBottom.constant = rect.size.height - MOVIEPLAYER_HEIGHT;
                _dsBottom.constant = rect.size.height - MOVIEPLAYER_HEIGHT;
                _isScreen = NO;
                self.view.transform = CGAffineTransformMakeRotation(0);
            }else{
                
                _dsBottom.constant = 0;
                _isScreen = YES;
                self.view.transform = CGAffineTransformMakeRotation(M_PI / 2);
            }
//        }completion:nil];
    }
    
    if ([_delegate respondsToSelector:@selector(moviePlayerClickScreen:)]) {
        [_delegate moviePlayerClickScreen:self];
    }
}

-(void) startDurationTimer
{
    _durationTimer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(monitorMoviePlayBack) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:self.durationTimer forMode:NSDefaultRunLoopMode];
}

-(void) monitorMoviePlayBack
{
    double currentTime = floor(self.currentPlaybackTime);
    double totalTime = floor(self.duration);
    [self setTimeLabelValues:currentTime totalTime:totalTime];
}

-(void) sliderChangeAction:(id)sender
{
    UISlider *slider = (UISlider *)sender;
    double currentTime = floor(slider.value);
    double totalTime = floor(self.duration);
    [self setTimeLabelValues:currentTime totalTime:totalTime];
}

-(void) sliderTouchBegan:(id)sender
{
    [self pause];
}

-(void) sliderTouchEnded:(id)sender
{
    UISlider *slider = (UISlider *)sender;
    [self setCurrentPlaybackTime:floor(slider.value)];
    [self play];
}

-(void) moviePlayPauseAction:(id)sender
{
    UIButton *but = (UIButton *)sender;
    if (_isPlayer) {
        but.selected = YES;
        _isPlayer = NO;
        [self pause];
    }else{
        but.selected = NO;
        _isPlayer = YES;
        [self play];
    }
}

-(void) setTimeLabelValues:(double)currentTime totalTime:(double)totalTime {
    
    if (self.duration > 0 && _isOnce) {
        CGFloat duration = self.duration;
        self.moviePlayerBottomBar.durationSlider.minimumValue = 0.f;
        self.moviePlayerBottomBar.durationSlider.maximumValue = duration;
        _isOnce = NO;
    }
    
    if (!(currentTime >= 0)) {
        return;
    }
    
    double minutesElapsed = floor(currentTime / 60.0);
    double secondsElapsed = fmod(currentTime, 60.0);
    self.moviePlayerBottomBar.playerTime.text = [NSString stringWithFormat:@"%02.0f:%02.0f", minutesElapsed, secondsElapsed];
    
    double minutesRemaining = floor(totalTime / 60.0);
    double secondsRemaining = floor(fmod(totalTime, 60.0));
    self.moviePlayerBottomBar.totalTime.text = [NSString stringWithFormat:@"%02.0f:%02.0f", minutesRemaining, secondsRemaining];
    
    self.moviePlayerBottomBar.durationSlider.value = ceil(currentTime);
}

@end
