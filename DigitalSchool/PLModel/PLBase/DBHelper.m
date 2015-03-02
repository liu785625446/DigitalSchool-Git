//
//  DBHelper.m
//  Home
//
//  Created by 刘军林 on 14/11/17.
//  Copyright (c) 2014年 刘军林. All rights reserved.
//

#import "DBHelper.h"
#import "FMDatabase.h"

#define DB_FILE_NAME @"digitalschool.db"

static DBHelper *shareDBHelper = nil;

@implementation DBHelper

@synthesize db;

+(DBHelper *) shareDBHelper
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        shareDBHelper = [[DBHelper alloc] init];
        [shareDBHelper initDB];
    });
    return shareDBHelper;
}

-(void) initDB
{
    NSString *configTablePath = [[NSBundle mainBundle] pathForResource:@"DBConfig" ofType:@"plist"];
    NSDictionary *configTable = [[NSDictionary alloc] initWithContentsOfFile:configTablePath];
    NSNumber *dbConfigVersion = [configTable objectForKey:@"DB_VERSION"];
    
    if (dbConfigVersion == nil) {
        dbConfigVersion = [NSNumber numberWithInt:0];
    }
    
    int versionNumber = [self dbVersionNumber];
    if ([dbConfigVersion intValue] != versionNumber) {
        NSString *usql = [NSString stringWithFormat:@"update DBVersionInfo set version_number = %d",[dbConfigVersion intValue]];
        [db executeUpdate:usql];
    }
}

-(FMDatabase *) db
{
    NSString *dbFilePath = [DBHelper applicationDocumentsDirectoryFile:DB_FILE_NAME];
    db = [FMDatabase databaseWithPath:dbFilePath];
    if (![db open]) {
        NSLog(@"数据库打开失败!");
    }
    return db;
}

-(int) dbVersionNumber
{
    int versionNumber = -1;
    
    NSString *sql = @"create table if not exists DBVersionInfo (version_number int);";
    if ([db executeUpdate:sql]) {
        NSString *selectSql = @"select version_number from DBVersionInfo";
        FMResultSet *set = [db executeQuery:selectSql];
        while ([set next]) {
            versionNumber = [set intForColumn:@"version_number"];
        }
    }
    return versionNumber;
}

+(NSString *) applicationDocumentsDirectoryFile:(NSString *)fileName
{
    NSString *documentDirectory = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    NSString *path = [documentDirectory stringByAppendingPathComponent:fileName];
    return path;
}

@end
