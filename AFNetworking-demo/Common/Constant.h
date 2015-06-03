//
//  Constant.h
//  AFNetworking-demo
//
//  Created by Jakey on 15/6/3.
//  Copyright (c) 2015年 Jakey. All rights reserved.
//

#ifdef SYNTHESIZE_CONSTS
# define CONST(name, value) NSString* const name = @ value
#else
# define CONST(name, value) extern NSString* const name
#endif

#ifndef __OPTIMIZE__
#define NSLog(...) NSLog(__VA_ARGS__)
#else
#define NSLog(...) {}
#endif


#import <Foundation/Foundation.h>


#warning:IOS后台接口应用地址

CONST(URI_BASE_SERVER, "http://api.skyfox.org/project");
CONST(URI_ROOT, "/afndemo/");

CONST(KEY_USER_NAME, "username");
CONST(KEY_KEYCHAIN_SERVICE, "AFNetworking-demo");



@interface Constant : NSObject
@property (strong,nonatomic) NSString *ip;
+ (Constant*)shareInstance;
@end
