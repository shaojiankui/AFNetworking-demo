//
//  APIClient.m
//  AFNetworking-demo
//
//  Created by Jakey on 14-7-22.
//  Copyright (c) 2014年 Jakey. All rights reserved.
//

#import "APIClient.h"
#import "AFNetworkActivityIndicatorManager.h"
#import "NSString+DictionaryValue.h"
#import "Constant.h"
static dispatch_once_t onceToken;
static APIClient *_sharedClient = nil;

@implementation APIClient
+ (instancetype)sharedClient {
    
    dispatch_once(&onceToken, ^{

        
        _sharedClient = [[APIClient alloc] initWithBaseURL:[NSURL URLWithString:[URI_BASE_SERVER stringByAppendingString:URI_ROOT]]];
        [_sharedClient setSecurityPolicy:[AFSecurityPolicy policyWithPinningMode:AFSSLPinningModePublicKey]];
        
        [_sharedClient.reachabilityManager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
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
        [_sharedClient.reachabilityManager startMonitoring];
        [[AFNetworkActivityIndicatorManager sharedManager] setEnabled:YES];

#warning:需要设置 很重要
        //TODO:需要设置 很重要
        
        //http://blog.csdn.net/xn4545945/article/details/37945711 详细介绍与其他具体参数
        //http://samwize.com/2012/10/25/simple-get-post-afnetworking/
        //工程中server.php 对应php版本的服务器端
        
        //发送json数据
        _sharedClient.requestSerializer = [AFJSONRequestSerializer serializer];
        //响应json数据
        _sharedClient.responseSerializer  = [AFJSONResponseSerializer serializer];
        
        //发送二进制数据
        //_sharedClient.requestSerializer = [AFHTTPRequestSerializer serializer];
        //响应二进制数据
        //_sharedClient.responseSerializer  = [AFHTTPResponseSerializer serializer];
        
        
#warning:设置响应内容格式  经常因为服务器返回的格式不是标准json而出错 服务器可能返回text/html text/plain 作为json
        
        
       _sharedClient.responseSerializer.acceptableContentTypes =  [_sharedClient.responseSerializer.acceptableContentTypes setByAddingObjectsFromSet:[NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html", @"text/plain",@"application/atom+xml",@"application/xml",@"text/xml",nil]];
        
    });
    

    
    return _sharedClient;
}
+(NSDictionary*)getAllContentTypes{
    NSString *JsonPath = [[NSBundle mainBundle] pathForResource:@"contentTypes" ofType:@"json"];
    NSString *jsonString=[NSString stringWithContentsOfFile:JsonPath encoding:NSUTF8StringEncoding error:nil];
    return [jsonString dictionaryValue];
}
@end
