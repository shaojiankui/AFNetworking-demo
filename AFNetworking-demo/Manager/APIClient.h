//
//  APIClient.h
//  AFNetworking-demo
//
//  Created by Jakey on 14-7-22.
//  Copyright (c) 2014年 Jakey. All rights reserved.
//
#import "AFHTTPRequestOperationManager.h"
#import <Foundation/Foundation.h>

@interface APIClient : AFHTTPRequestOperationManager
+ (instancetype)sharedClient;
@end
