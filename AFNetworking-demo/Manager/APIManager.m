//
//  APIManager.m
//  AFNetworking-demo
//
//  Created by Jakey on 16/4/1.
//  Copyright © 2016年 www.skyfox.org. All rights reserved.
//

#import "APIManager.h"
#import "AFSecurityPolicy.h"
#import "AFNetworkActivityIndicatorManager.h"
#import "Constant.h"

static dispatch_once_t onceToken;
static APIManager *_sharedManager = nil;

@implementation APIManager
+ (instancetype)sharedManager {
    
    dispatch_once(&onceToken, ^{
        //设置服务器根地址
        _sharedManager = [[APIManager alloc] initWithBaseURL:[NSURL URLWithString:[URI_BASE_SERVER stringByAppendingString:URI_ROOT]]];
        [_sharedManager setSecurityPolicy:[AFSecurityPolicy policyWithPinningMode:AFSSLPinningModePublicKey]];
        
        [_sharedManager.reachabilityManager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
            switch (status) {
                case AFNetworkReachabilityStatusReachableViaWWAN:
                    NSLog(@"3G网络已连接");
                    break;
                    
                case AFNetworkReachabilityStatusReachableViaWiFi:
                    NSLog(@"WiFi网络已连接");
                    break;
                case AFNetworkReachabilityStatusNotReachable:
                    NSLog(@"网络连接失败");
                    break;
                    
                default:
                    break;
            }
        }];
        [_sharedManager.reachabilityManager startMonitoring];
        [[AFNetworkActivityIndicatorManager sharedManager] setEnabled:YES];
        
#warning:需要设置 很重要
        //TODO:需要设置 很重要
        
        //http://blog.csdn.net/xn4545945/article/details/37945711 详细介绍与其他具体参数
        //http://samwize.com/2012/10/25/simple-get-post-afnetworking/
        //工程中server.php 对应php版本的服务器端
        
        //发送json数据
        _sharedManager.requestSerializer = [AFJSONRequestSerializer serializer];
        //响应json数据
        _sharedManager.responseSerializer  = [AFJSONResponseSerializer serializer];
        
        //发送二进制form数据
        //_sharedClient.requestSerializer = [AFHTTPRequestSerializer serializer];
        //响应二进制form数据
        //_sharedClient.responseSerializer  = [AFHTTPResponseSerializer serializer];
#warning:设置响应内容格式  经常因为服务器返回的格式不是标准json而出错 服务器可能返回text/html text/plain 作为json
        
        _sharedManager.responseSerializer.acceptableContentTypes =  [_sharedManager.responseSerializer.acceptableContentTypes setByAddingObjectsFromSet:[NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html", @"text/plain",@"application/atom+xml",@"application/xml",@"text/xml",nil]];
        
    });
    
    return _sharedManager;
}

+ (NSURLSessionDataTask *)SafePOST:(NSString *)URLString
                      parameters:(id)parameters
                         success:(void (^)(NSURLSessionDataTask * task, id responseObject))success
                         failure:(void (^)(NSURLSessionDataTask * task, NSError *error))failure{
    APIManager *manager = [APIManager sharedManager];
    //todo 统一封装请求参数

    return [manager POST:URLString parameters:parameters success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
        //todo 统一处理响应数据
        success(task,responseObject);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        //todo 统一处理错误
        failure(task,error);
    }];
}
+ (NSURLSessionDataTask *)SafeGET:(NSString *)URLString
                        parameters:(id)parameters
                           success:(void (^)(NSURLSessionDataTask * task, id responseObject))success
                           failure:(void (^)(NSURLSessionDataTask * task, NSError *error))failure{
    APIManager *manager = [APIManager sharedManager];
    
    return [manager GET:URLString parameters:parameters success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
        //todo
        success(task,responseObject);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        //todo
        failure(task,error);
    }];
}

//设置ip要重置单例 生效
+ (void)reset {
    _sharedManager = nil;
    onceToken = 0;
}
@end
