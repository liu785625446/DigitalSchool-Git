//
//  MAdcolumnView.m
//  DigitalScholl
//
//  Created by rachel on 15/1/15.
//  Copyright (c) 2015年 刘军林. All rights reserved.
//

#import "MAdcolumnView.h"
#import "UrlImageView.h"

#import "PLRecommendCourse.h"

@interface MAdcolumnView ()

@property (nonatomic, strong) NSTimer *timer;
@property (nonatomic, strong) UIScrollView *scrollView;

@end

@implementation MAdcolumnView

-(id)initWithFrame:(CGRect)frame adcolumns:(NSArray *)adcolumns
{
    if ([super initWithFrame:frame])
    {
        [self creatAdcolumn:adcolumns];
    }
    return self;
}

-(void)creatAdcolumn:(NSArray *)adcolumns
{
    self.backgroundColor = [UIColor colorWithHexString:MListBarkGroundColor alpha:1];
    
    _scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
    _scrollView.pagingEnabled = YES;
    _scrollView.delegate = self;
    _scrollView.showsVerticalScrollIndicator = NO;
    _scrollView.showsHorizontalScrollIndicator = NO;
    _scrollView.contentSize = CGSizeMake(adcolumns.count*self.frame.size.width, self.frame.size.height);
    [self addSubview:_scrollView];
    
    for (int i=0; i<adcolumns.count; i++)
    {
        UrlImageView *imageView = [[UrlImageView alloc]initWithImage:[UIImage imageNamed:@"MAdcolumnView.png"]];
        imageView.frame = CGRectMake(i*self.frame.size.width, 0, self.frame.size.width, self.frame.size.height);
        PLRecommendCourse *course = [adcolumns objectAtIndex:i];
        [imageView setImageWithURL:[NSURL URLWithString:course.recommendImg]
                  placeholderImage:[UIImage imageNamed:@"MAdcolumnView.png"]];
        
        [_scrollView addSubview:imageView];
    }
    
    pageControl = [[UIPageControl alloc] initWithFrame: CGRectMake(0, self.frame.size.height-20, self.frame.size.width, 20)];
    pageControl.numberOfPages = adcolumns.count;
    pageControl.currentPageIndicatorTintColor = [UIColor colorWithHexString:@"#FF8000" alpha:1];
    pageControl.pageIndicatorTintColor = [UIColor colorWithHexString:@"#00FFFF" alpha:1];
    
    [self addSubview:pageControl];
    
    _timer = [NSTimer scheduledTimerWithTimeInterval:3 target:self selector:@selector(timerAction) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:_timer forMode:NSRunLoopCommonModes];
}

-(void) timerAction
{
    if (pageControl.currentPage == 4) {
        pageControl.currentPage = 0;
        [_scrollView setContentOffset:CGPointMake(pageControl.currentPage * _scrollView.frame.size.width, 0) animated:NO];
    }else{
        pageControl.currentPage +=1;
        [_scrollView setContentOffset:CGPointMake(pageControl.currentPage * _scrollView.frame.size.width, 0) animated:YES];
    }
}

#define mark UiScrollViewDelegate
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    int page = scrollView.contentOffset.x / self.frame.size.width;
    pageControl.currentPage = page;
}

@end
