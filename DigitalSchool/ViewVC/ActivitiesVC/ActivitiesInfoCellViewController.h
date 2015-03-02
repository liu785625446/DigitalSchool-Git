//
//  ActivitiesInfoCellViewController.h
//  DigitalSchool
//
//  Created by 刘军林 on 15/1/19.
//  Copyright (c) 2015年 刘军林. All rights reserved.
//

#import "MBaseTableViewController.h"
#import "PLWorkProcess.h"
#import "PLDiscussProcess.h"

typedef enum {
    WINNERWORKS = 0,
    ALLWORKS,
    ALLCOMMENT,
}CellStyle;

@interface ActivitiesInfoCellViewController : MBaseTableViewController

@property (assign) CellStyle cellStyle;
@property (nonatomic, strong) NSString *styleId;

@property (nonatomic, strong) NSArray *array;
@property (nonatomic, strong) PLWorkProcess *workProcess;
@property (nonatomic, strong) PLDiscussProcess *discussProcess;

@end
