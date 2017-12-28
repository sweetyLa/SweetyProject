//
//  BaseViewController.m
//  EagleCloud
//
//  Created by    apple on 2017/11/7.
//  Copyright © 2017年 sweety. All rights reserved.
//

#import "BaseViewController.h"

@interface BaseViewController ()

@end

@implementation BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];

    kWeakSelf;
    if ([RDevice manager].networkStatus == NotReachable) {
        [ReadStatusView showReadStatusWithStatus:ReadStatusNoNetWork inView:weakSelf.view WithFrame:CGRectZero];
    }else{
        [ReadStatusView showReadStatusWithStatus:readStatusFinish inView:weakSelf.view WithFrame:CGRectZero];
    }

    [RDevice manager].cNetworkStatus = ^(NetworkStatus networkStatus){
        if (networkStatus == NotReachable) {
            MBShow(@"失去网络了");
        }else{
            [ReadStatusView showReadStatusWithStatus:readStatusFinish inView:weakSelf.view WithFrame:CGRectZero];
        }
        [weakSelf networkChange:networkStatus];
    };
}

- (void)networkChange:(NetworkStatus)networkStatus
{
    if ([RDevice manager].networkStatus == NotReachable) {
        [ReadStatusView showReadStatusWithStatus:ReadStatusNoNetWork inView:self.view WithFrame:CGRectZero];
    }else{
        [ReadStatusView showReadStatusWithStatus:readStatusFinish inView:self.view WithFrame:CGRectZero];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
