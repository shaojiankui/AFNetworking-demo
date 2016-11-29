//
//  User.m
//  AFNetworking-demo
//
//  Created by Jakey on 14-7-22.
//  Copyright (c) 2014年 Jakey. All rights reserved.
//

#import "User.h"
#import "APIManager.h"
#import "SSKeychain.h"
@implementation User

+ (NSURLSessionDataTask*)login:(NSDictionary *)param
                         Success:(void (^)(NSURLSessionDataTask *task,User *user,id responseObject))success
                         Failure:(void (^)(NSURLSessionDataTask *task,NSError *error))failue{

    NSLog(@"paramDic%@",param);
    //直接发送json给服务器端   对应[AFJSONRequestSerializer serializer];
    
    //将请求参数转换为json后放入key为jsonString的字典中发送请求    对应[AFHTTPRequestSerializer serializer];
   // NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    //[parameters setObject:[param dictionaryToJson] forKey:@"jsonString"];
    
    //服务器端写法见工程目录的server.php
    
    return [APIManager SafePOST:@"getUser.do" parameters:param success:^(NSURLSessionDataTask *task, id responseObject) {
        User *user =  [[User alloc] initWithDictionary:responseObject error:nil];
        
        success(task,user,responseObject);
        
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
         failue(task,error);
    }];
}

+ (NSURLSessionDataTask *)getSomeTypes:(NSDictionary *)paramDic
                               Success:(void (^)(NSURLSessionDataTask *task,id responseObject))success
                               Failure:(void (^)(NSURLSessionDataTask *task,NSError *error))failue{
    
    return [APIManager SafePOST:@"getTypes.do" parameters:nil success:^(NSURLSessionDataTask *task, id responseObject) {
//        task.respons
        
        success(task,responseObject);
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        failue(task,error);
    }];
};

//注销
+ (void)logoutAccount{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults removeObjectForKey:KEY_USER_NAME];
    [userDefaults synchronize];
}
//获取userdefault用户名 和钥匙串中密码
+ (void)getAccount:(void (^)(NSString *username,NSString *password))block{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSString *username = [userDefaults objectForKey:KEY_USER_NAME];
    NSString *password = [SSKeychain passwordForService:KEY_KEYCHAIN_SERVICE account:username];
    block(username?:@"",password?:@"");
}
//存储用户名userdefault ,密码到钥匙串
+ (void)saveAccount:(NSString *)name andPassword:(NSString *)password {
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setObject:name forKey:KEY_USER_NAME];
    [userDefaults synchronize];
    [SSKeychain setPassword:password forService:KEY_KEYCHAIN_SERVICE account:name];
}
@end
