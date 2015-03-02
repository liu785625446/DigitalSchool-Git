//
//  MScreenHrizontalView.h
//  DigitalScholl
//
//  Created by rachel on 15/1/14.
//  Copyright (c) 2015年 刘军林. All rights reserved.
//

#import <UIKit/UIKit.h>
@class MScreenHrizontalView;

@protocol MScreenHrizontalViewDelegate <NSObject>

-(void)didButtonIndex:(NSInteger)index menuObject:(id)menuObject hrizontalView:(MScreenHrizontalView *)hrizontalView;

@end

#define MSpace 4

@interface MScreenHrizontalView : UIScrollView
{
    CGFloat contentSizeWidth;
    NSMutableArray *mArray;
    NSInteger currentIndex;
}
@property(nonatomic,assign)id<MScreenHrizontalViewDelegate> mDelegate;
-(id)initWithFrame:(CGRect)frame items:(NSArray*)items;
-(id)initWithFrame:(CGRect)frame items:(NSArray *)items selectRow:(NSInteger)selectRow;

-(void)initItems:(NSArray *)items selectRow:(NSInteger)selectRow;
@end
