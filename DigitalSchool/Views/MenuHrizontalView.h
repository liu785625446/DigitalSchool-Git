//
//  MenuHrizontalView.h
//  DigitalScholl
//
//  Created by rachel on 15/1/6.
//  Copyright (c) 2015年 刘军林. All rights reserved.
//

#import <UIKit/UIKit.h>

#define kItemWidth 70

#define KNormalColor @"#6A6B6B"
#define KSelctColor @"#33B4E4"

@class MenuHrizontalView;

@protocol MenuHrizontalViewDelegate <NSObject>

-(void)didMenuHrizontalView:(MenuHrizontalView *)menuHrizontalView itemTag:(NSInteger)itemTag;

@end

@interface MenuHrizontalView : UIView
{
    UIScrollView *mScrollView;
    float mItemWidth;
    UIColor *mItemNormalColor;
    UIColor *mItemSelectColor;
}
@property(nonatomic,assign)id<MenuHrizontalViewDelegate>delegate;

#pragma mark 初始化菜单
- (id)initWithFrame:(CGRect)frame
        ButtonItems:(NSArray *)aItemsArray
          itemWidth:(float)itemWidth
    itemNormalColor:(UIColor *)itemNormalColor
    itemSelectColor:(UIColor *)itemSelectColor;

- (void)createMenuItems:(NSArray *)itemsArray;
- (void)setSelectButton:(NSInteger)tag;
@end
