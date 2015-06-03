//
//  Util.m
//  AFNetworking-demo
//
//  Created by Jakey on 14-7-22.
//  Copyright (c) 2014年 Jakey. All rights reserved.
//

#import "Util.h"

@implementation Util
+ (NSDate*)dateWithTimeInterval:(NSNumber *)interval
{
    if (interval != nil) {
        if((NSNull *)interval != [NSNull null])
        {
            long long tmpInterval = [interval longLongValue];
            if (tmpInterval != 0) {
                NSDate* date = [NSDate dateWithTimeIntervalSince1970:(NSTimeInterval)tmpInterval];
                NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
                [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm"];
                date = [dateFormatter dateFromString:[dateFormatter stringFromDate:date]];
                return date;
            } else {
                return 0;
            }
        } else {
            return 0;
        }
    } else {
        return 0;
    }
    
}

+ (NSString*)convertDateToString:(NSDate*)date
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    //    [dateFormatter setTimeZone:[NSTimeZone timeZoneWithAbbreviation:@"UTC"]];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSString *strDate = [dateFormatter stringFromDate:date];
    return strDate;
}


@end
