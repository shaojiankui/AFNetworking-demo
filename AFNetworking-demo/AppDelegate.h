//
//  AppDelegate.h
//  AFNetworking-demo
//
//  Created by Jakey on 15/6/3.
//  Copyright (c) 2015年 Jakey. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "User.h"
@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) UINavigationController *navigationController;


@property (strong, nonatomic) User *user;
+(AppDelegate*)APP;
@end
