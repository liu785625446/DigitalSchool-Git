//
//  MCourseCell.h
//  UploadVideo
//
//  Created by 刘军林 on 15/1/13.
//  Copyright (c) 2015年 刘军林. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MCourseDownloadCell : UITableViewCell

@property (nonatomic, strong) IBOutlet UILabel *courseName;
@property (nonatomic, strong) IBOutlet UIProgressView *courseProgress;
@property (nonatomic, strong) IBOutlet UILabel *downloadInfo;
@property (nonatomic, strong) IBOutlet UIImageView *downloadStatus;
@property (nonatomic, strong) IBOutlet UIImageView *selectStatus;
@property (nonatomic, strong) IBOutlet NSLayoutConstraint *selectImgWidth;

@end
