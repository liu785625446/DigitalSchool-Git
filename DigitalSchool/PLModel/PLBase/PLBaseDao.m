//
//  PLBaseDao.m
//  PersistenceLayer
//
//  Created by 刘军林 on 15/1/7.
//  Copyright (c) 2015年 刘军林. All rights reserved.
//

#import "PLBaseDao.h"
#import "DBHelper.h"
#import "FMDatabase.h"
#import "PLBaseData.h"

@implementation PLBaseDao

-(id) init
{
    if ([super init]) {
        _dbHelper = [DBHelper shareDBHelper];
    }
    return self;
}

-(BOOL) executeUpdate:(NSString *)sql
{
    BOOL isUpdate = [_dbHelper.db executeUpdate:sql];
    [_dbHelper.db close];
    return isUpdate;
}

-(NSMutableArray *) executeQuery:(NSString *)sql
{
    FMResultSet *set = [_dbHelper.db executeQuery:sql];
    NSMutableArray *list = [[NSMutableArray alloc] initWithCapacity:0];
    while ([set next]) {
        [list addObject:[self objectForSet:set]];
    }
    [_dbHelper.db close];
    return list;
}

@end
