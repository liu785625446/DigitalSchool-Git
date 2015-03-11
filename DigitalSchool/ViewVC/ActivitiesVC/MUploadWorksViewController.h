//
//  MUploadWorksViewController.h
//  DigitalSchool
//
//  Created by 刘军林 on 15/1/19.
//  Copyright (c) 2015年 刘军林. All rights reserved.
//

#import "MBaseViewController.h"
#import "UIKeyboardViewController.h"

@interface MUploadWorksViewController : MBaseViewController
@property (nonatomic,strong)NSURL *vidoUrl;
@property (nonatomic,strong)NSString *mp4Path;
@property (nonatomic,strong)UIImage *mImage;


@property (nonatomic, strong) IBOutlet UITextField *worksName;
@property (nonatomic, strong) IBOutlet UITextView *infoTextView;
@property (nonatomic, strong) IBOutlet UIButton *uploadVideo;
@property (nonatomic, strong) IBOutlet UIButton *uploadImage;
@property (nonatomic, strong) UIKeyboardViewController *keyboard;
@property (nonatomic,strong) NSString *activityId;

-(IBAction)uploadComplete:(id)sender;
-(IBAction)uploadImage:(id)sender;
-(IBAction)uploadVido:(id)sender;

@end
