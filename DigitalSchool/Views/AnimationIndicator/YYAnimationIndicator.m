//
//  YYAnimationIndicator.m
//  AnimationIndicator
//
//  Created by 王园园 on 14-8-26.
//  Copyright (c) 2014年 王园园. All rights reserved.
//

// 版权属于原作者
// http://code4app.com (cn) http://code4app.net (en)
// 发布代码于最专业的源码分享网站: Code4App.com

#import "YYAnimationIndicator.h"

#define KIMGDefaultWH 100
#define KINFODefaultWH 20

@implementation YYAnimationIndicator

- (id)initWithFrame:(CGRect)frame
{
    return [self initWithFrame:frame withIMGWH:KIMGDefaultWH];
}

- (id)initWithFrame:(CGRect)frame withIMGWH:(CGFloat)imgWH
{
    self = [super initWithFrame:frame];
    if (self)
    {
        
        self.backgroundColor = [UIColor clearColor];
        
        _isAnimating = NO;
        
        float imgX = (frame.size.width - imgWH)/2;
        float imgY = (frame.size.height - imgWH-KINFODefaultWH)/2;
        imageView = [[UIImageView alloc] initWithFrame:CGRectMake(imgX,imgY,imgWH,imgWH)];
        
        [imageView setImage:[UIImage imageNamed:@"MLoadImg.png"]];
        imageView.hidden = NO;
        CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform"];
        animation.delegate = self;
        animation.toValue = [NSValue valueWithCATransform3D:CATransform3DMakeRotation(M_PI/2, 0, 0, 1.0)];
        animation.duration = 0.3;
        animation.cumulative = YES;
        animation.repeatCount = INT_MAX;
        
        [imageView.layer addAnimation:animation forKey:@"animation"];
//        //设置动画帧
//        imageView.animationImages=[NSArray arrayWithObjects:
//                                   [UIImage imageNamed:@"1"],
//                                   [UIImage imageNamed:@"2"],
//                                   [UIImage imageNamed:@"3"],
//                                   [UIImage imageNamed:@"4"],
//                                   [UIImage imageNamed:@"5"],
//                                   [UIImage imageNamed:@"6"],nil ];
        
        [self addSubview:imageView];
//        
//        
//        
        Infolabel = [[UILabel alloc]initWithFrame:CGRectMake(0,imgWH+imgY,frame.size.width, KINFODefaultWH)];
        Infolabel.backgroundColor = [UIColor clearColor];
        Infolabel.textAlignment = NSTextAlignmentCenter;
        Infolabel.textColor = [UIColor colorWithRed:84.0/255 green:86./255 blue:212./255 alpha:1];
        Infolabel.font = [UIFont fontWithName:@"ChalkboardSE-Bold" size:14.0f];
        [self addSubview:Infolabel];
        
        self.layer.hidden = YES;
        
        UITapGestureRecognizer *tapGest = [[UITapGestureRecognizer alloc]initWithTarget:self
                                                                                 action:@selector(loadData:)];
        [self addGestureRecognizer:tapGest];
    }
    return self;
}
-(void)setFrame:(CGRect)frame
{
    float imgX = (frame.size.width - imageView.frame.size.width)/2;
    float imgY = (frame.size.height - imageView.frame.size.height-KINFODefaultWH)/2;
    imageView.frame = CGRectMake(imgX, imgY, imageView.frame.size.width, imageView.frame.size.height);;
    Infolabel.frame = CGRectMake(0,imageView.frame.size.height+imgY,Infolabel.frame.size.width, Infolabel.frame.size.height);
    [super setFrame:frame];
}


- (void)startAnimation
{
    _isAnimating = YES;
    _mLoadType = MLoadTypeDefault;
    self.layer.hidden = NO;
    [self doAnimation];
}

-(void)doAnimation
{
    
    Infolabel.text = _loadtext;
    //设置动画总时间
//    imageView.animationDuration=1.0;
    //设置重复次数,0表示不重复
    imageView.animationRepeatCount=0;
    //开始动画
    [imageView startAnimating];
}

- (void)stopAnimationWithLoadText:(NSString *)text withType:(BOOL)type
{
    [self stopAnimationWithLoadText:text withType:type loadType:MLoadTypeDefault];
    
}
- (void)stopAnimationWithLoadText:(NSString *)text
                         withType:(BOOL)type
                         loadType:(MLoadType)loadType
{
    [imageView.layer removeAllAnimations];
    imageView.hidden = YES;
//    _isAnimating = NO;
//    Infolabel.text = text;
//    _mLoadType = loadType;
//    if(type)
//    {
//        [imageView stopAnimating];
//        self.layer.hidden = type;
//        
//    }else
//    {
//        self.layer.hidden = type;
//        [imageView stopAnimating];
//        if (loadType == MLoadTypeFail)
//        {
//            [imageView setImage:[UIImage imageNamed:@"6"]];
//            
//        }else
//        {
//            [imageView setImage:[UIImage imageNamed:@"3"]];
//        }
//        
//    }
}

-(void)setLoadText:(NSString *)text;
{
    if(text)
    {
        _loadtext = text;
    }
}

-(void)loadData:(UITapGestureRecognizer *)tapGest
{
    if (self.mLoadType == MLoadTypeFail)
    {
        if (self.delegate && [self.delegate respondsToSelector:@selector(didReloadData:)])
        {
            [self.delegate didReloadData:self];
        }
    }
}

@end
