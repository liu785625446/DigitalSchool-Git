//
//  ViewController.h
//  UploadVideo
//
//  Created by 刘军林 on 15/1/6.
//  Copyright (c) 2015年 刘军林. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BLCourseDownloadProcess.h"
#import "VCustomToolBar.h"

@interface CourseDownloadController: UIViewController<UITableViewDataSource, UITableViewDelegate,VCustomToolBarDelegate,BLCourseDownloadDelegate>

@property (nonatomic, strong)IBOutlet UITableView *table;

@property (nonatomic, strong) VCustomToolBar *toolBar;
@property (nonatomic, strong) IBOutlet NSLayoutConstraint *tableBottom;

@property (nonatomic, strong) BLCourseDownloadProcess *courseProcess;
@property (nonatomic, strong) NSArray *downloadQueue;

@property (nonatomic, strong) NSMutableArray *selectQueue;

@end

