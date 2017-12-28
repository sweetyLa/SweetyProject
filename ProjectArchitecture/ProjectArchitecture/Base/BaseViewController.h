//
//  BaseViewController.h
//  EagleCloud
//
//  Created by    apple on 2017/11/7.
//  Copyright © 2017年 sweety. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Reachability.h"
#import "RDevice.h"
#import "ReadStatusView.h"

@interface BaseViewController : UIViewController

- (void)networkChange:(NetworkStatus)networkStatus;//当网络状态改变是，会调用该方法，子类可覆盖实现自己所需功能。

@end
