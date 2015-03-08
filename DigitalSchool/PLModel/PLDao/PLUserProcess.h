//
//  PLUserProcess.h
//  DigitalSchool
//
//  Created by 刘军林 on 15/3/8.
//  Copyright (c) 2015年 刘军林. All rights reserved.
//

#import "PLBaseProcess.h"

@interface PLUserProcess : PLBaseProcess

-(void) rigesterUserName:(NSString *)userName didPassword:(NSString *)pwd didNickName:(NSString *)nickName didUserType:(NSString *)userType didSuccess:(CallBackBlockSuccess)success didFail:(CallBackBlockFail)fail;

-(void) loginUserName:(NSString *)userName didPassword:(NSString *)pwd didSuccess:(CallBackBlockSuccess)success didFail:(CallBackBlockFail)fail;

@end
