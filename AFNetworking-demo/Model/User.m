//
//  User.m
//  AFNetworking-demo
//
//  Created by Jakey on 14-7-22.
//  Copyright (c) 2014年 Jakey. All rights reserved.
//

#import "User.h"
#import "APIClient.h"
#import "SSKeychain.h"
@implementation User
+(BOOL)propertyIsOptional:(NSString*)propertyName
{
    return YES;
}


+ (AFHTTPRequestOperation *)getUser:(NSDictionary *)paramDic
                          success:(void (^)(User *user))success
                            failed:(void (^)(NSError *error))failed{

    NSLog(@"paramDic%@",paramDic);
    //直接发送json给服务器端   对应[AFJSONRequestSerializer serializer];
    NSDictionary *param = paramDic;
    
    //将请求参数转换为json后放入key为jsonString的字典中发送请求    对应[AFHTTPRequestSerializer serializer];
   // NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    //[parameters setObject:[param dictionaryToJson] forKey:@"jsonString"];
    
    //服务器端写法见工程目录的server.php
    
    return [[APIClient sharedClient] POST:@"getUser.do" parameters:param success:^(AFHTTPRequestOperation *operation, id responseObject) {
        User *user =  [[User alloc] initWithDictionary:responseObject error:nil];
        
        success(user);
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
         failed(error);
    }];
}

+ (AFHTTPRequestOperation *)getSomeTypes:(NSDictionary *)paramDic
                             withBlock:(void (^)(NSDictionary *types, NSError *error))block{
    
    return [[APIClient sharedClient] POST:@"getTypes.do" parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        block(responseObject, nil);
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (block) {
            block(nil, error);
        }
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
