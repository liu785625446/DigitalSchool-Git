//
//  MPlayVideoViewController.h
//  DigitalSchool
//
//  Created by rachel on 15/1/20.
//  Copyright (c) 2015年 刘军林. All rights reserved.
//

#import "MBaseViewController.h"
#import "DSMoviePlayerController.h"
#import "PLCourse.h"
#import "PLWorks.h"
@interface MPlayVideoViewController : MBaseViewController<DSMoviePlayerDelegate>
{
    NSInteger currentIndex;
    NSMutableArray *datas;
    
    int discussCurrentPage; // 讨论当前页数（从1开始，下同）
    int noteCurrentPage;    //笔记当前页数（从1开始，下同）
    int correlationCurrentPage; //章节当前页数（从1开始，下同）
}

@property (nonatomic, assign) BOOL statusBarHidden;
@property (nonatomic, strong) DSMoviePlayerController *moviePlayer;
@property (nonatomic, strong) id objectModel;
@property (nonatomic, assign) MPlayVideoType mPlayVideoType;

@end
