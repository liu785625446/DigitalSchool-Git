//
//  PLChapterProcess.h
//  DigitalSchool
//
//  Created by 刘军林 on 15/2/5.
//  Copyright (c) 2015年 刘军林. All rights reserved.
//

#import "PLBaseProcess.h"

@interface PLChapterProcess : PLBaseProcess

/**
 *  获取相关章节列表
 *
 *  @param gradeId     年纪ID
 *  @param catalogId   目录ID
 *  @param volumesId   册ID
 *  @param success
 *  @param fail        
 */
-(void) getChapterCorrelationListdGradeId:(NSString *)gradeId didCatalogId:(NSString *)catalogId didVolumes:(NSString *)volumesId didSuccess:(CallBackBlockSuccess)success didFail:(CallBackBlockFail)fail;

@end
