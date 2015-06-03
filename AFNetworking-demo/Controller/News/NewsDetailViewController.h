//
//  NewsDetailViewController.h
//  AFNetworking-demo
//
//  Created by Jakey on 14-7-22.
//  Copyright (c) 2014年 Jakey. All rights reserved.
//

#import "BaseViewController.h"

@interface NewsDetailViewController : BaseViewController
@property (strong, nonatomic)  NSString *urlString;
@property (weak, nonatomic) IBOutlet UIWebView *myWebView;

@end
