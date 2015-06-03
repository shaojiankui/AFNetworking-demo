//
//  Constant.m
//  AFNetworking-demo
//
//  Created by Jakey on 15/6/3.
//  Copyright (c) 2015年 Jakey. All rights reserved.
//

#define SYNTHESIZE_CONSTS
#import "Constant.h"
@implementation Constant
+ (Constant*)shareInstance
{
    static Constant *share = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        share = [[Constant alloc] init];
        
    });
    return share;
}


@end
