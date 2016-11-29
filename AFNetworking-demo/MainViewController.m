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
   [[APIManager sharedManager] downloadFileWithURL:@"http://dldir1.qq.com/qqfile/qq/QQ7.6/15742/QQ7.6.exe" parameters:@{@"userid":@"123123"} savedPath:savedPath downloadSuccess:^(NSURLResponse *response, NSURL *filePath) {
       
   } downloadFailure:^(NSError *error) {
       
   } downloadProgress:^(NSProgress *downloadProgress) {
      NSLog(@"总大小：%lld,当前大小:%lld",downloadProgress.totalUnitCount,downloadProgress.completedUnitCount);
   }];

    
 
}
//一个简单的demo
+ (NSURLSessionDataTask *)X_POST:(NSString *)URLString
                        parameters:(id)parameters
                           success:(void (^)(id responseObject))success
                           failure:(void (^)(NSError *error))failure{
    AFHTTPSessionManager *manager =  [AFHTTPSessionManager manager];
    //发送json数据  {"key":"value","key2":"value2"}
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    //响应json数据
    manager.responseSerializer  = [AFJSONResponseSerializer serializer];
    
    ////发送二进制form数据 key=value&key2=value2
    //manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    ////响应二进制form数据
    //manager.responseSerializer  = [AFHTTPResponseSerializer serializer];
    
    //直接发送JSON给服务器端   对应[AFJSONRequestSerializer serializer];
    //实际httpbody中的数据为 {"name":"sky","password":"fox"}
    NSDictionary *parametersDemo = @{@"name":@"sky",@"password":@"fox"};
    

    ////将请求参数转换为JSON后放入key为aJSON的字典中发送请求    对应[AFHTTPRequestSerializer serializer];
    ////实际httpbody中的数据为  {"aJSON":"{"name":"sky","password":"fox"}","key":"value"}
    // NSDictionary *parametersJSON = @{@"name":@"sky",@"password":@"fox"};
    //NSMutableDictionary *parametersDemo = @{@"aJSON":[parametersJSON toJSONString],@"key":@"value"};
   
   
    
    manager.responseSerializer.acceptableContentTypes =  [manager.responseSerializer.acceptableContentTypes setByAddingObjectsFromSet:[NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html", @"text/plain",@"application/atom+xml",@"application/xml",@"text/xml",nil]];
    return  [manager POST:URLString parameters:parametersDemo progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        success(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSString *responseString =  [[NSString alloc] initWithData:(NSData *)error.userInfo[AFNetworkingOperationFailingURLResponseDataErrorKey] encoding:NSUTF8StringEncoding];
        NSLog(@"%@",responseString);
        failure(error);
    }];
}
@end
