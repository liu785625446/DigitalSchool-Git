//
//  MDetailsCell.h
//  DigitalSchool
//
//  Created by rachel on 15/1/20.
//  Copyright (c) 2015年 刘军林. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UrlImageView.h"

@interface MDetailsCell : UITableViewCell
@property(nonatomic,strong)IBOutlet UILabel *titleLabel;
@property(nonatomic,strong)IBOutlet UILabel *nameLabel;
@property(nonatomic,strong)IBOutlet UrlImageView *iconImageView;
@property(nonatomic,strong)IBOutlet UILabel *detailLabel;

@end
