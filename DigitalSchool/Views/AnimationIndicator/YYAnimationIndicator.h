//
//  YYAnimationIndicator.h
//  AnimationIndicator
//
//  Created by 王园园 on 14-8-26.
//  Copyright (c) 2014年 王园园. All rights reserved.
//

// 版权属于原作者
// http://code4app.com (cn) http://code4app.net (en)
// 发布代码于最专业的源码分享网站: Code4App.com

#import <UIKit/UIKit.h>

#define YYFailReloadText @"加载失败,点击屏幕重新加载"

@class YYAnimationIndicator;

@protocol YYAnimationDelegate <NSObject>

-(void)didReloadData:(YYAnimationIndicator *)animationView;

@end


typedef NS_ENUM(NSInteger, MLoadType)
{
    MLoadTypeDefault = 0,
    MLoadTypeSuccess,
    MLoadTypeFail
};


@interface YYAnimationIndicator : UIView

{
    UIImageView *imageView;
    UILabel *Infolabel;
}
@property (nonatomic, readonly) MLoadType mLoadType;
@property (nonatomic, assign) NSString *loadtext;
@property (nonatomic, readonly) BOOL isAnimating;
@property (nonatomic, assign)id <YYAnimationDelegate> delegate;


//use this to init
- (id)initWithFrame:(CGRect)frame;
- (id)initWithFrame:(CGRect)frame withIMGWH:(CGFloat)imgWH;
- (void)setLoadText:(NSString *)text;

- (void)startAnimation;
- (void)stopAnimationWithLoadText:(NSString *)text withType:(BOOL)type;
- (void)stopAnimationWithLoadText:(NSString *)text withType:(BOOL)type loadType:(MLoadType)loadType;


@end
