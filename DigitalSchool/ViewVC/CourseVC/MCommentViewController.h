//
//  MCommentViewController.h
//  DigitalSchool
//
//  Created by luc on 15-2-3.
//  Copyright (c) 2015年 刘军林. All rights reserved.
//

#import "MBaseViewController.h"


@interface MCommentViewController : MBaseViewController
<UITextViewDelegate>
{
    NSInteger textSize;
}
@property(nonatomic,strong)NSString *courseId;
@property(nonatomic,strong)IBOutlet UITextView *comment;
@property(nonatomic,strong)IBOutlet UILabel *sizeLabel;
@property(nonatomic,assign)MPlayVideoType playVideoType;


-(IBAction)sendComment:(id)sender;
-(IBAction)cancel:(id)sender;
@end
