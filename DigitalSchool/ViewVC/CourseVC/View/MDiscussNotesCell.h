//
//  MDiscussNotesCell.h
//  DigitalSchool
//
//  Created by rachel on 15/1/22.
//  Copyright (c) 2015年 刘军林. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UrlImageView.h"
@class MDiscussNotesCell;

@protocol MDiscussNotesCellDelegate  <NSObject>

-(void)replyCdiscussOrPraiseNote:(MDiscussNotesCell *)cell otherButton:(UIButton *)button;

@end

@interface MDiscussNotesCell : UITableViewCell
@property(nonatomic,assign)id<MDiscussNotesCellDelegate> delegate;
@property(nonatomic,strong)IBOutlet UrlImageView *iconImage;
@property(nonatomic,strong)IBOutlet UILabel *userName;
@property(nonatomic,strong)IBOutlet UILabel *content;
@property(nonatomic,strong)IBOutlet UIButton *otherBtn;
@property(nonatomic,strong)IBOutlet UILabel *timeLabel;

-(IBAction)replyCdiscussOrPraiseNote:(UIButton *)sender;

@end
