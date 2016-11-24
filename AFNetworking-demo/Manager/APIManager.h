//
//  APIManager.h
//  AFNetworking-demo
//
//  Created by Jakey on 16/4/1.
//  Copyright © 2016年 www.skyfox.org. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFHTTPSessionManager.h"

@interface APIManager : AFHTTPSessionManager
+ (instancetype)sharedManager;

+ (NSURLSessionDataTask *)SafePOST:(NSString *)URLString
                        parameters:(id)parameters
                           success:(void (^)(NSURLSessionDataTask * task, id responseObject))success
                           failure:(void (^)(NSURLSessionDataTask * task, NSError *error))failure;

+ (NSURLSessionDataTask *)SafeGET:(NSString *)URLString
                       parameters:(id)parameters
                          success:(void (^)(NSURLSessionDataTask * task, id responseObject))success
                          failure:(void (^)(NSURLSessionDataTask * task, NSError *error))failure;

- (void)downloadFileWithURL:(NSString*)requestURLString
                 parameters:(NSDictionary *)parameters
                  savedPath:(NSString*)savedPath
            downloadSuccess:(void (^)(NSURLResponse *response, NSURL *filePath))success
            downloadFailure:(void (^)(NSError *error))failure
           downloadProgress:(void (^)(NSProgress *downloadProgress))progress;
+ (void)reset;
@end
