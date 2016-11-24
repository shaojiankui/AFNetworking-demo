//
//  MainViewController.m
//  AFNetworking-demo
//
//  Created by Jakey on 14-7-22.
//  Copyright (c) 2014年 www.skyfox.org. All rights reserved.
//

#import "MainViewController.h"
#import "User.h"
#import "UIImageView+AFNetworking.h"
#import "NewsViewController.h"
#import "NSDictionary+JSONString.h"
#import "LoginViewController.h"
#import "AppDelegate.h"


#import <SystemConfiguration/SystemConfiguration.h>
#import <MobileCoreServices/MobileCoreServices.h>

#import "AFURLSessionManager.h"
#import "AFHTTPSessionManager.h"
#import "APIManager.h"
@interface MainViewController ()

@end

@implementation MainViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"主页";
    self.headPhoto.layer.cornerRadius = self.headPhoto.frame.size.width/2;
    self.headPhoto.layer.masksToBounds = YES;
}
-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
    if (![AppDelegate APP].user) {
        
        LoginViewController *login = [[LoginViewController alloc]init];
        [login finished:^(User *user) {
            self.userName.text = user.name?:@"";
            self.qq.text = user.qq?:@"";
            self.email.text = user.email?:@"";
            [self.headPhoto setImageWithURL:[NSURL URLWithString:user.photo]];
        }];
        
        [self presentViewController:login animated:YES completion:nil];
    }
}



- (IBAction)newsTouched:(id)sender {
    NewsViewController *news = [[NewsViewController alloc]init];
    [self.navigationController pushViewController:news animated:YES];
}

//json 中各种类型的取法  model请求接口
- (IBAction)typeTouched:(id)sender {
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [User getSomeTypes:nil Success:^(NSURLSessionDataTask *task, id responseObject) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        
        NSLog(@"respone %@",responseObject);
        
        NSDictionary *dic = [responseObject objectForKey:@"object"];
        NSArray *array = [responseObject objectForKey:@"array"];
        NSString *string = [responseObject objectForKey:@"string"];
        NSString *dateSting = [responseObject objectForKey:@"dateSting"];
        //        NSDate *date = [XXX dateWithTimeInterval:[types objectForKey:@"date"]];
        NSNumber *number = [responseObject objectForKey:@"number"];
        NSNull *null = [responseObject objectForKey:@"null"];
        
    } Failure:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"网络请求失败");
        [MBProgressHUD hideHUDForView:self.view animated:YES];

    }];
}
- (IBAction)downloadTouched:(id)sender {
    NSString *savedPath = [NSHomeDirectory() stringByAppendingString:@"/Documents/QQ7.6.exe"];
   [self downloadFileWithURL:@"http://dldir1.qq.com/qqfile/qq/QQ7.6/15742/QQ7.6.exe" parameters:@{@"userid":@"123123"} savedPath:savedPath downloadSuccess:^(NSURLResponse *response, NSURL *filePath) {
       
   } downloadFailure:^(NSError *error) {
       
   } downloadProgress:^(NSProgress *downloadProgress) {
      NSLog(@"总大小：%lld,当前大小:%lld",downloadProgress.totalUnitCount,downloadProgress.completedUnitCount);
   }];

}

@end
