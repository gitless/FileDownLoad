//
//  ViewController.m
//  DownloadFile
//
//  Created by v on 16/4/13.
//  Copyright © 2016年 v. All rights reserved.
//

#import "ViewController.h"
#import "FileDownManger.h"
#import "DownView.h"
#import "AFNetworking.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    FileDownManger *fileDown = [[FileDownManger alloc]init];
    DownView *d = [[DownView alloc]initWithFrame:CGRectMake(100, 100,50, 50)];
    d.backgroundColor = [UIColor clearColor];
    [self.view addSubview:d];
    
    fileDown.haveReceived = ^(float have){
        d.progress = have;
    
    };
    [fileDown downLoadWithUrlString:@"http://dlsw.baidu.com/sw-search-sp/soft/3a/12350/QQ_8.2.17724.0_setup.1459155849.exe"];

    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
