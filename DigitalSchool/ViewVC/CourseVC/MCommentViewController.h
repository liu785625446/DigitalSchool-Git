//
//  MCommentViewController.h
//  DigitalSchool
//
//  Created by luc on 15-2-3.
//  Copyright (c) 2015年 刘军林. All rights reserved.
//

#import "MBaseViewController.h"

#define MCommentTitle @"发讨论"
#define MReplyCommentTitle @"回复讨论"
#define MNoteTitle @"记笔记"


@protocol MCommentDelegate <NSObject>

-(void)didCommentSuccess:(id)object title:(NSString *)title;

@end


@interface MCommentViewController : MBaseViewController
<UITextViewDelegate>
{
    NSInteger textSize;
}
@property(nonatomic,strong)NSString *courseId;
@property(nonatomic,strong)IBOutlet UITextView *comment;
@property(nonatomic,strong)IBOutlet UILabel *sizeLabel;
@property(nonatomic,assign)MPlayVideoType playVideoType;
@property(nonatomic,assign)id<MCommentDelegate>delegate;


-(IBAction)sendComment:(id)sender;
-(IBAction)cancel:(id)sender;
@end
