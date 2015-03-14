    //
    //  PLNavsProcess.h
    //  DigitalSchool
    //
    //  Created by 刘军林 on 15/3/11.
    //  Copyright (c) 2015年 刘军林. All rights reserved.
    //

#import "PLBaseProcess.h"

@interface PLNavsProcess : PLBaseProcess

-(void) getNavsList:(CallBackBlockSuccess)success didFail:(CallBackBlockFail)fail;

-(void) getNavsDatails:(int)pageSize didCurrentPage:(int)currentPage didNavId:(NSString *)navId didSuccess:(CallBackBlockSuccess)success didFail:(CallBackBlockFail)fail;
@end
