//
//  PLBaseProcess.h
//  DigitalSchool
//
//  Created by 刘军林 on 15/1/27.
//  Copyright (c) 2015年 刘军林. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PLInterface.h"

typedef void (^CallBackBlockSuccess) (NSMutableArray *array);
typedef void (^CallBackBlockFail) (NSString *error);

@interface PLBaseProcess : NSObject

-(void) dataFormat:(NSDictionary *)dic didClass:(NSString *)classStr didSuccess:(CallBackBlockSuccess)success didFail:(CallBackBlockFail)fail;
-(void) dataFormatPost:(NSDictionary *)dic didSuccess:(CallBackBlockSuccess)success didFail:(CallBackBlockFail)fail;
@end
