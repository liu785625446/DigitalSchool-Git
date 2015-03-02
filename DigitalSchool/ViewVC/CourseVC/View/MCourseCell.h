//
//  MCourseCell.h
//  DigitalScholl
//
//  Created by rachel on 15/1/8.
//  Copyright (c) 2015年 刘军林. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UrlImageView.h"
#import "PLCourse.h"

@interface MCourseCell : UITableViewCell

@property(nonatomic,strong)IBOutlet UIView *mBackGroundView;
@property(nonatomic,strong)IBOutlet UrlImageView *iconImage;
@property(nonatomic,strong)IBOutlet UILabel *titleLabel;
@property(nonatomic,strong)IBOutlet UILabel *contentLabel;

@property (nonatomic, strong) PLBaseData *baseModel;

@end
