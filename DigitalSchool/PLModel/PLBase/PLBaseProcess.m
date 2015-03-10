//
//  PLBaseProcess.m
//  DigitalSchool
//
//  Created by 刘军林 on 15/1/27.
//  Copyright (c) 2015年 刘军林. All rights reserved.
//

#import "PLBaseProcess.h"
#import "PLBaseData.h"
#import "PLUser.h"

@implementation PLBaseProcess

-(void) dataFormat:(NSDictionary *)dic didClass:(NSString *)classStr didSuccess:(CallBackBlockSuccess)success didFail:(CallBackBlockFail)fail
{
    if ([dic isKindOfClass:[NSDictionary class]]) {
        if ([[dic objectForKey:@"ret"] isEqualToNumber:[NSNumber numberWithInt:0]]) {
            NSMutableArray *tempArray = [dic objectForKey:@"data"];
            NSMutableArray *list = [[NSMutableArray alloc] initWithCapacity:0];
            for (id dic in tempArray) {
                if ([dic isKindOfClass:[NSDictionary class]]) {
                    PLBaseData *baseData = [[NSClassFromString(classStr) alloc] init];
                    [baseData setValuesForKeysWithDictionary:dic];
                    [list addObject:baseData];
                }
            }
            success(list);
        }else{
            fail(REQUEST_ERROR);
        }
    }else{
        fail(REQUEST_ERROR);
    }
}

-(void) dataFormatPost:(NSDictionary *)dic didSuccess:(CallBackBlockSuccess)success didFail:(CallBackBlockFail)fail
{
    if ([dic isKindOfClass:[NSDictionary class]]) {
        if ([[dic objectForKey:@"ret"] isEqualToNumber:[NSNumber numberWithInt:0]]) {
            id data = [dic objectForKey:@"data"];
            if (data) {
                NSMutableArray *array = [[NSMutableArray alloc] initWithObjects:data, nil];
                success(array);
            }else{
                success(nil);
            }
            
        }else if ([[dic objectForKey:@"ret"] isEqualToNumber:[NSNumber numberWithInt:4]])
        {
            fail(@"已关注");
        }else if ([[dic objectForKey:@"ret"] isEqualToNumber:[NSNumber numberWithInt:5]]){
            fail(@"已经赞了");
        }else if ([[dic objectForKey:@"ret"] isEqualToNumber:[NSNumber numberWithInt:6]]){
            fail(@"用户名或密码错误");
        }else if ([[dic objectForKey:@"ret"] isEqualToNumber:[NSNumber numberWithInt:7]]){
            fail(@"用户名重复");
        }else{
            fail(REQUEST_ERROR);
        }
    }else{
        fail(REQUEST_ERROR);
    }

}

-(NSString *)getUserId
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSData *userData = [userDefaults objectForKey:CURRENT_USER];
    if (userData) {
        PLUser *user = [NSKeyedUnarchiver unarchiveObjectWithData:userData];
        return user.userId;
    }
    return @"";
}


@end
