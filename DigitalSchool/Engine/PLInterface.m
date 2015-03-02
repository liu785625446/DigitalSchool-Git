//
//  PLInterface.m
//  PersistenceLayer
//
//  Created by 刘军林 on 15/1/7.
//  Copyright (c) 2015年 刘军林. All rights reserved.
//

#import "PLInterface.h"
#import "MKNetworkEngine.h"
#import "MKNetworkOperation.h"

@implementation PLInterface

+(void) startRequest:(NSString *)host didUrl:(NSString *)url didParam:(NSMutableDictionary *)param didSuccess:(void (^)(id))success didFail:(void (^)(NSString *))fail
{
    MKNetworkEngine *engine = [[MKNetworkEngine alloc] initWithHostName:host customHeaderFields:nil];
    MKNetworkOperation *operation = nil;
    if (param) {
        operation = [engine operationWithPath:url params:param httpMethod:@"POST"];
    }else{
        operation = [engine operationWithPath:url];
    }
    
    [operation onCompletion:^(MKNetworkOperation *response){
        success([response responseJSON]);
    }onError:^(NSError *error){
        fail([error description]);
    }];
    
    [engine enqueueOperation:operation];
}

@end
