//
//  MNavigationColl.h
//  DigitalSchool
//
//  Created by 刘军林 on 15/3/9.
//  Copyright (c) 2015年 刘军林. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PLNavs.h"
#import "UrlImageView.h"

@interface MNavigationColl : UICollectionViewCell

@property (nonatomic, assign) IBOutlet UrlImageView *navImg;
@property (nonatomic, assign) IBOutlet UILabel *navTitle;
@property (assign) int index;
@property (nonatomic, strong) PLNavs *navs;
@end
