//
//  News.h
//  AFNetworking-demo
//
//  Created by Jakey on 14-7-22.
//  Copyright (c) 2014年 Jakey. All rights reserved.
//

#import "BaseModel.h"

@interface News : BaseModel
@property (strong, nonatomic) NSString *newsID;
@property (strong, nonatomic) NSString *title;
@property (strong, nonatomic) NSString *descr;
@property (strong, nonatomic) NSString *imgurl;
@property (strong, nonatomic) NSString<Optional> *modelid;

//返回news 实体数组
+ (NSURLSessionDataTask *)getNewsList:(NSDictionary *)paramDic
                              Success:(void (^)(NSURLSessionDataTask *task,NSArray *newList,id responseObject))success
                              Failure:(void (^)(NSURLSessionDataTask *task,NSError *error))failue;

@end
