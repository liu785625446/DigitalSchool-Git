//
//  ActivityWorksCell.m
//  DigitalSchool
//
//  Created by 刘军林 on 15/2/5.
//  Copyright (c) 2015年 刘军林. All rights reserved.
//

#import "ActivityWorksCell.h"
#import "PLWorks.h"
#import "PLActivity.h"

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

-(void) setObjectModel:(id)objectModel
{
    if ([objectModel isKindOfClass:[PLWorks class]]) {
        PLWorks *works = (PLWorks *) objectModel;
        worksName.text = works.workTitle;
        [worksImg setImageWithURL:[NSURL URLWithString:works.workImg] placeholderImage:[UIImage imageNamed:@"MActivityDefault.png"]];
        worksWatchNum.text = [NSString stringWithFormat:@"%d",[works.workWatchNum intValue]];
        worksPraise.text =  [NSString stringWithFormat:@"%d",[works.praise intValue]];
        userName.text = works.user.userName;
        
        
    }else if ([objectModel isKindOfClass:[PLActivity class]]) {
        PLActivity *activity = (PLActivity * ) objectModel;
        worksName.text = activity.activityName;
        [worksImg setImageWithURL:[NSURL URLWithString:activity.activityImg] placeholderImage:[UIImage imageNamed:@"MActivityDefault.png"]];
        worksWatchNum.text = activity.activityCollectNum;
        worksPraise.text = activity.activityJoinNum;
        userName.text = activity.plUser.userName;
    }
}

@end
