//
//  PLInterface.h
//  PersistenceLayer
//
//  Created by 刘军林 on 15/1/7.
//  Copyright (c) 2015年 刘军林. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PLURL.h"
#import "BLTool.h"

@interface PLInterface : NSObject

+(void) startRequest:(NSString *)host
              didUrl:(NSString *)url
            didParam:(NSMutableDictionary *)param
          didSuccess:(void (^) (id result))success
             didFail:(void (^) (NSString *error))fail;

@end
