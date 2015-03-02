//
//  MWatchRecordCell.h
//  DigitalSchool
//
//  Created by 刘军林 on 15/2/11.
//  Copyright (c) 2015年 刘军林. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UrlImageView.h"

@interface MWatchRecordCell : UITableViewCell

@property (nonatomic, strong) id object;

@property (nonatomic, strong) IBOutlet UrlImageView *image;
@property (nonatomic, strong) IBOutlet UILabel *title;
@property (nonatomic, strong) IBOutlet UILabel *time;

@end
