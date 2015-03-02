//
//  PLBaseDao.h
//  PersistenceLayer
//
//  Created by 刘军林 on 15/1/7.
//  Copyright (c) 2015年 刘军林. All rights reserved.
//

#import <Foundation/Foundation.h>

@class DBHelper;
@class FMResultSet;
@class PLBaseData;

@interface PLBaseDao : NSObject

@property (nonatomic, strong) DBHelper *dbHelper;

-(BOOL) executeUpdate:(NSString *)sql;
-(NSMutableArray *) executeQuery:(NSString *)sql;
-(PLBaseData *) objectForSet:(FMResultSet *)set;

@end
