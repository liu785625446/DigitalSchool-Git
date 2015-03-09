//
//  MUserInfoViewController.h
//  DigitalSchool
//
//  Created by 刘军林 on 15/3/9.
//  Copyright (c) 2015年 刘军林. All rights reserved.
//

#import "MBaseTableViewController.h"

@class PLUser;
@class PLUserProcess;

@interface MUserInfoViewController : MBaseTableViewController <UITableViewDataSource, UITableViewDelegate, UIActionSheetDelegate, UIImagePickerControllerDelegate,UINavigationControllerDelegate, UIAlertViewDelegate>

@property (nonatomic, strong) PLUser *user_info;
@property (nonatomic, strong) PLUserProcess *userProcess;

@end
