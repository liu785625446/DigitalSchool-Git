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

#define KIMGDefaultWH 60
#define KINFODefaultWH 40

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
        
        
        float imgX = (frame.size.width - imgWH)/2;
        float imgY = (frame.size.height - imgWH)/2;
        imageView = [[UIImageView alloc] initWithFrame:CGRectMake(imgX,imgY,imgWH,imgWH)];
        [imageView setImage:[UIImage imageNamed:@"MLoadImg.png"]];
        imageView.hidden = YES;
        [self addSubview:imageView];
        
        Infolabel = [[UILabel alloc]initWithFrame:CGRectMake(20,(frame.size.height - KINFODefaultWH)/2,frame.size.width-40, KINFODefaultWH)];
        Infolabel.backgroundColor = [UIColor clearColor];
        Infolabel.textAlignment = NSTextAlignmentCenter;
        Infolabel.textColor = [UIColor grayColor];
        Infolabel.numberOfLines = 0;
        Infolabel.font = [UIFont fontWithName:@"ChalkboardSE-Bold" size:16.0f];
        Infolabel.hidden = YES;
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
    float imgY = (frame.size.height - imageView.frame.size.height)/2;
    imageView.frame = CGRectMake(imgX, imgY, imageView.frame.size.width, imageView.frame.size.height);;
    Infolabel.frame = CGRectMake(Infolabel.frame.origin.x,(frame.size.height - Infolabel.frame.size.height)/2,Infolabel.frame.size.width, Infolabel.frame.size.height);
    [super setFrame:frame];
}


- (void)startAnimation
{
    if (imageView.hidden)
    {
        _mLoadType = MLoadTypeDefault;
        self.layer.hidden = NO;
        Infolabel.hidden = YES;
        [self doAnimation];
    }
    
}

-(void)doAnimation
{
    
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform"];
    animation.delegate = self;
    animation.toValue = [NSValue valueWithCATransform3D:CATransform3DMakeRotation(M_PI/2, 0, 0, 1.0)];
    animation.duration = 0.3;
    animation.cumulative = YES;
    animation.repeatCount = INT_MAX;
    
    [imageView.layer addAnimation:animation forKey:@"animation"];
    imageView.hidden = NO;
}

- (void)stopAnimationWithLoadText:(NSString *)text withType:(BOOL)type
{
    [self stopAnimationWithLoadText:text withType:type loadType:MLoadTypeDefault];
    
}
- (void)stopAnimationWithLoadText:(NSString *)text
                         withType:(BOOL)type
                         loadType:(MLoadType)loadType
{
    self.layer.hidden = type;
    [imageView.layer removeAllAnimations];
    imageView.hidden = YES;
    Infolabel.text = text;
    _mLoadType = loadType;
    Infolabel.hidden = type;
    
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
