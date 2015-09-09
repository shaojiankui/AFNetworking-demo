//
//  MainViewController.m
//  AFNetworking-demo
//
//  Created by Jakey on 14-7-22.
//  Copyright (c) 2014年 Jakey. All rights reserved.
//

#import "MainViewController.h"
#import "User.h"
#import "UIImageView+AFNetworking.h"
#import "NewsViewController.h"
#import "NSDictionary+JSONString.h"
#import "LoginViewController.h"
#import "AFHTTPRequestOperationManager.h"
#import "AppDelegate.h"


#import <SystemConfiguration/SystemConfiguration.h>
#import <MobileCoreServices/MobileCoreServices.h>

#import "AFURLRequestSerialization.h"
#define AFNETWORKING_ALLOW_INVALID_SSL_CERTIFICATES

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
    [User getSomeTypes:nil withBlock:^(NSDictionary *types, NSError *error) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];

        if (error) {
            [JKAlert showMessage:@"提示" message:@"网络请求失败"];
            return;
        }
        [JKAlert showMessage:@"提示" message:[types JSONString]];
        
        NSDictionary *dic = [types objectForKey:@"object"];    
        NSArray *array = [types objectForKey:@"array"];
        NSString *string = [types objectForKey:@"string"];
        NSString *dateSting = [types objectForKey:@"dateSting"];
        NSDate *date = [Util dateWithTimeInterval:[types objectForKey:@"date"]];
        NSNumber *number = [types objectForKey:@"number"];
        NSNull *null = [types objectForKey:@"null"];
        
        
    }];
}

#warning:直接请求接口 只是为了演示直接使用afnetworking请求求数据,但是不建议直接在veiwcontroler中请求数据,会增加程序耦合度
- (IBAction)commonTouched:(id)sender {
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    //发送json数据
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    //响应json数据
    manager.responseSerializer  = [AFJSONResponseSerializer serializer];
    
    //发送二进制数据/表单
    //_sharedClient.requestSerializer = [AFHTTPRequestSerializer serializer];
    //响应二进制数据/表单
    //_sharedClient.responseSerializer  = [AFHTTPResponseSerializer serializer];
    
    //设置响应内容格式  经常因为服务器返回的格式不是标准json而出错 服务器可能返回text/html text/plain 作为json
    manager.responseSerializer.acceptableContentTypes =[manager.responseSerializer.acceptableContentTypes setByAddingObjectsFromSet:[NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html", @"text/plain",@"application/atom+xml",@"application/xml",@"text/xml",nil]];

    AFSecurityPolicy *securityPolicy = [AFSecurityPolicy defaultPolicy];
    securityPolicy.allowInvalidCertificates = YES;
    manager.securityPolicy = securityPolicy;
    
    
   NSDictionary *param = @{@"key":@"value"};
    
   [MBProgressHUD showHUDAddedTo:self.view animated:YES];
   [manager POST:@"https://uokqkwj.dsyszl.com:8134/20140301/accounts/calls/advertising.json" parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
       [MBProgressHUD hideHUDForView:self.view animated:YES];

       //operation.responseString 为接口返回的未解析原始数据
       NSLog(@"server respones:%@",operation.responseString);
       
       [JKAlert showMessage:@"提示" message:[responseObject JSONString]];
       
       NSDictionary *dic = [responseObject objectForKey:@"object"];
       NSArray *array = [responseObject objectForKey:@"array"];
       NSString *string = [responseObject objectForKey:@"string"];
       NSString *dateSting = [responseObject objectForKey:@"dateSting"];
       NSDate *date = [Util dateWithTimeInterval:[responseObject objectForKey:@"date"]];
       NSNumber *number = [responseObject objectForKey:@"number"];
       NSNull *null = [responseObject objectForKey:@"null"];
       
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
         [JKAlert showMessage:@"提示" message:@"网络请求失败"];
        [MBProgressHUD hideHUDForView:self.view animated:YES];

    }];
}

- (IBAction)downloadTouched:(id)sender {
    NSString *savedPath = [NSHomeDirectory() stringByAppendingString:@"/Documents/QQ7.6.exe"];
    //    NSDictionary *paramaterDic= @{@"jsonString":[@{@"userid":@"2332"} JSONString]?:@""};
    [self downloadFileWithOption:@{@"userid":@"123123"}
                   withInferface:@"http://dldir1.qq.com/qqfile/qq/QQ7.6/15742/QQ7.6.exe"
                       savedPath:savedPath
                 downloadSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        
    } downloadFailure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
    } progress:^(float progress) {
        
    }];
}
/**
 *  @author Jakey
 *
 *  @brief  下载文件
 *
 *  @param paramDic   附加post参数
 *  @param requestURL 请求地址
 *  @param savedPath  保存 在磁盘的位置
 *  @param success    下载成功回调
 *  @param failure    下载失败回调
 *  @param progress   实时下载进度回调
 */
- (void)downloadFileWithOption:(NSDictionary *)paramDic
                 withInferface:(NSString*)requestURL
                     savedPath:(NSString*)savedPath
               downloadSuccess:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
               downloadFailure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure
                      progress:(void (^)(float progress))progress

{
    
    //沙盒路径    //NSString *savedPath = [NSHomeDirectory() stringByAppendingString:@"/Documents/xxx.zip"];
    AFHTTPRequestSerializer *serializer = [AFHTTPRequestSerializer serializer];
    NSMutableURLRequest *request =[serializer requestWithMethod:@"POST" URLString:requestURL parameters:paramDic error:nil];
    
//以下是手动创建request方法 AFQueryStringFromParametersWithEncoding有时候会保存
//    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:requestURL]];
//   NSMutableURLRequest *request =[[[AFHTTPRequestOperationManager manager]requestSerializer]requestWithMethod:@"POST" URLString:requestURL parameters:paramaterDic error:nil];
//
//    NSString *charset = (__bridge NSString *)CFStringConvertEncodingToIANACharSetName(CFStringConvertNSStringEncodingToEncoding(NSUTF8StringEncoding));
//    
//    [request setValue:[NSString stringWithFormat:@"application/x-www-form-urlencoded; charset=%@", charset] forHTTPHeaderField:@"Content-Type"];
//    [request setHTTPMethod:@"POST"];
//
//    [request setHTTPBody:[AFQueryStringFromParametersWithEncoding(paramaterDic, NSASCIIStringEncoding) dataUsingEncoding:NSUTF8StringEncoding]];
    
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc]initWithRequest:request];
    [operation setOutputStream:[NSOutputStream outputStreamToFileAtPath:savedPath append:NO]];
    [operation setDownloadProgressBlock:^(NSUInteger bytesRead, long long totalBytesRead, long long totalBytesExpectedToRead) {
        float p = (float)totalBytesRead / totalBytesExpectedToRead;
        progress(p);
        NSLog(@"download：%f", (float)totalBytesRead / totalBytesExpectedToRead);
        
    }];
    
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        success(operation,responseObject);
        NSLog(@"下载成功");
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        success(operation,error);

        NSLog(@"下载失败");
        
    }];
    
    [operation start];

}
@end
