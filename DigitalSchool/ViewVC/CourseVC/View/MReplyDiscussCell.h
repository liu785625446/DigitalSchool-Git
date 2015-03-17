//
//  MReplyDiscussCell.h
//  DigitalSchool
//
//  Created by rachel on 15/3/16.
//  Copyright (c) 2015年 刘军林. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UrlImageView.h"

@interface MReplyDiscussCell : UITableViewCell
@property(nonatomic,strong)IBOutlet UrlImageView *iconImg;
@property(nonatomic,strong)IBOutlet UILabel *nikeLabel;
@property(nonatomic,strong)IBOutlet UILabel *timeLabel;
@property(nonatomic,strong)IBOutlet UILabel *contentLabel;
@end
