//
//  MUserInfoCell.h
//  DigitalSchool
//
//  Created by 刘军林 on 15/3/9.
//  Copyright (c) 2015年 刘军林. All rights reserved.
//

#import <UIKit/UIKit.h>
@class UrlImageView;

@interface MUserInfoCell : UITableViewCell

@property (nonatomic, assign) IBOutlet UILabel *mUserCellName;
@property (nonatomic, assign) IBOutlet UILabel *mUserCellValue;

@property (nonatomic, assign) IBOutlet NSLayoutConstraint *right;

@end

@interface MUserInfoImgCell : UITableViewCell

@property (nonatomic, assign) IBOutlet UrlImageView *mUserInfoImg;

@end
