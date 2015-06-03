//
//  NewsViewController.h
//  AFNetworking-demo
//
//  Created by Jakey on 14-7-22.
//  Copyright (c) 2014年 Jakey. All rights reserved.
//

#import "BaseViewController.h"

@interface NewsViewController : BaseViewController
@property (weak, nonatomic) IBOutlet UITableView *myTableView;
@property (strong, nonatomic)  NSMutableArray *dataArray;

@end
