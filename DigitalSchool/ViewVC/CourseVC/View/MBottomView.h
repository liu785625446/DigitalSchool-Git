//
//  MBottomView.h
//  DigitalSchool
//
//  Created by rachel on 15/1/20.
//  Copyright (c) 2015年 刘军林. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol MBottomViewDelegate <NSObject>

-(void)didButtonIndex:(NSInteger)index;

@end

@interface MBottomView : UIView
{
    
}
@property(nonatomic,assign)id<MBottomViewDelegate> delegate;
-(id)initWithFrame:(CGRect)frame;
@end
