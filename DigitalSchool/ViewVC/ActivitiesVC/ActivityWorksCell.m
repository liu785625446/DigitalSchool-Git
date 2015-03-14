//
//  ActivityWorksCell.m
//  DigitalSchool
//
//  Created by 刘军林 on 15/2/5.
//  Copyright (c) 2015年 刘军林. All rights reserved.
//

#import "ActivityWorksCell.h"
#import "PLWorks.h"

@implementation ActivityWorksCell

@synthesize worksImg;
@synthesize worksName;
@synthesize worksWatchNum;
@synthesize worksPraise;
@synthesize userName;

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void) setWorks:(PLWorks *)works
{
    _works = works;
    worksName.text = _works.workTitle;
    [worksImg setImageWithURL:[NSURL URLWithString:_works.workImg] placeholderImage:[UIImage imageNamed:@"MActivityDefault.png"]];
    worksWatchNum.text = [NSString stringWithFormat:@"%@",_works.workWatchNum];
    worksPraise.text = _works.praise;
    userName.text = _works.user.userName;
}

@end
