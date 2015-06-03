//
//  LoginViewController.h
//  AFNetworking-demo
//
//  Created by Jakey on 15/3/26.
//  Copyright (c) 2015年 Jakey. All rights reserved.
//

#import "BaseViewController.h"
#import "User.h"
typedef void (^FinishedLogin)(User *user);

@interface LoginViewController : BaseViewController
{
    FinishedLogin _finished;
}
@property (weak, nonatomic) IBOutlet UITextField *username;
@property (weak, nonatomic) IBOutlet UITextField *password;
-(void)finished:(FinishedLogin)finished;

- (IBAction)loginTouched:(id)sender;
@end
