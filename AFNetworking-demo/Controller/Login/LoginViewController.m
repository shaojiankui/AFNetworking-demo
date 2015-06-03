//
//  LoginViewController.m
//  AFNetworking-demo
//
//  Created by Jakey on 15/3/26.
//  Copyright (c) 2015年 Jakey. All rights reserved.
//

#import "LoginViewController.h"
#import "User.h"
#import "AppDelegate.h"
@interface LoginViewController ()

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

-(void)finished:(FinishedLogin)finished{
    _finished = finished;
}

- (IBAction)loginTouched:(id)sender {
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];

    NSDictionary *param = @{@"username": self.username.text,@"password":self.password.text};
    [User getUser:param success:^(User *user) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
#warning: 把登陆后的用户存入单例中   参照博客 http://www.skyfox.org/ios-login-info-save.html
        [AppDelegate APP].user = user;
        if (_finished) {
            [self dismissViewControllerAnimated:YES completion:^{
                _finished(user);
            }];
        }
    } failed:^(NSError *error) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
         [JKAlert showMessage:@"提示" message:@"登陆失败"];
    }];
}
@end
