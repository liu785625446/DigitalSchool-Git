//
//  DSMoviePlayerBar.h
//  CustomVideo
//
//  Created by 刘军林 on 15/1/20.
//  Copyright (c) 2015年 刘军林. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DSMoviePlayerBar : UIView

@property (nonatomic, strong) UIButton *playPauseButton;
@property (nonatomic, strong) UIButton *fullScreenButton;
@property (nonatomic, strong) UISlider *durationSlider;

@property (nonatomic, strong) UILabel *playerTime;
@property (nonatomic, strong) UILabel *totalTime;

@end
