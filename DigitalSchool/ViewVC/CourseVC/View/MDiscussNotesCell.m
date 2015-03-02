//
//  MDiscussNotesCell.m
//  DigitalSchool
//
//  Created by rachel on 15/1/22.
//  Copyright (c) 2015年 刘军林. All rights reserved.
//

#import "MDiscussNotesCell.h"

@implementation MDiscussNotesCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
}


-(IBAction)replyCdiscussOrPraiseNote:(UIButton *)sender
{
    if (_delegate && [_delegate respondsToSelector:@selector(replyCdiscussOrPraiseNote:otherButton:)])
    {
        [_delegate replyCdiscussOrPraiseNote:self otherButton:sender];
    }
}

@end
