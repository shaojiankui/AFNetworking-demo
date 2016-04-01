//
//  User.h
//  AFNetworking-demo
//
//  Created by Jakey on 14-7-22.
//  Copyright (c) 2014年 Jakey. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseModel.h"

@interface User : BaseModel
@property (strong, nonatomic) NSString *userID;
@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) NSString *password;
@property (strong, nonatomic) NSString *mobile;
@property (strong, nonatomic) NSString *qq;
@property (strong, nonatomic) NSString *email;
@property (strong, nonatomic) NSString *photo;


//登陆
+ (NSURLSessionDataTask*)login:(NSDictionary *)param
                       Success:(void (^)(NSURLSessionDataTask *task,User *user,id responseObject))success
                       Failure:(void (^)(NSURLSessionDataTask *task,NSError *error))failue;

+ (NSURLSessionDataTask *)getSomeTypes:(NSDictionary *)paramDic
                               Success:(void (^)(NSURLSessionDataTask *task,id responseObject))success
                               Failure:(void (^)(NSURLSessionDataTask *task,NSError *error))failue;

//注销
+ (void)logoutAccount;
///获取userdefault中存的用户名 和钥匙串中密码
+ (void)getAccount:(void (^)(NSString *username,NSString *password))block;
//存储用户名userdefault ,密码到钥匙串
+ (void)saveAccount:(NSString *)name andPassword:(NSString *)password;
@end
