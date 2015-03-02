//
//  ActivityWorksCell.h
//  DigitalSchool
//
//  Created by 刘军林 on 15/2/5.
//  Copyright (c) 2015年 刘军林. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UrlImageView.h"

@class PLWorks;

@interface ActivityWorksCell : UITableViewCell

@property (nonatomic, strong) IBOutlet UrlImageView *worksImg;
@property (nonatomic, strong) IBOutlet UILabel *worksName;
@property (nonatomic, strong) IBOutlet UILabel *worksWatchNum;
@property (nonatomic, strong) IBOutlet UILabel *userName;

@property (nonatomic, strong) PLWorks *works;
@end
