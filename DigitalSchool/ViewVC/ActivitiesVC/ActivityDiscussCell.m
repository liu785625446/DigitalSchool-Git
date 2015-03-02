//
//  ActivityDiscussCell.m
//  DigitalSchool
//
//  Created by 刘军林 on 15/2/5.
//  Copyright (c) 2015年 刘军林. All rights reserved.
//

#import "ActivityDiscussCell.h"
#import "PLDiscuss.h"

@implementation ActivityDiscussCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void) setDiscuss:(PLDiscuss *)discuss
{
    _discuss = discuss;
    
    _discussContent.text = _discuss.discussContent;
    _discussCreateTime.text = _discuss.discussCreateTime;
    _discussName.text = _discuss.pluser.userName;
}

@end
