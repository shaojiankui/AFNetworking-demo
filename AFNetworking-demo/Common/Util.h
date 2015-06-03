//
//  Util.h
//  AFNetworking-demo
//
//  Created by Jakey on 14-7-22.
//  Copyright (c) 2014年 Jakey. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Util : NSObject
+ (NSDate*)dateWithTimeInterval:(NSNumber *)interval;
+ (NSString*)convertDateToString:(NSDate*)date;
@end
