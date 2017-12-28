//
//  AppDelegate+Bugly.m
//  EagleCloud
//
//  Created by    apple on 2017/11/8.
//  Copyright © 2017年 sweety. All rights reserved.
//

#import "AppDelegate+Bugly.h"
#import <Bugly/Bugly.h>

@implementation AppDelegate (Bugly)

///注册Bugly
- (void)registeredBugly
{
    //bugly
    BuglyConfig * config = [[BuglyConfig alloc] init];
    config.reportLogLevel = BuglyLogLevelWarn;
    config.debugMode = YES;
    config.deviceIdentifier = [UIDevice currentDevice].name;
    config.blockMonitorEnable = YES;
    config.blockMonitorTimeout = 3;
    config.unexpectedTerminatingDetectionEnable = YES;
    config.reportLogLevel = BuglyLogLevelWarn;
    [Bugly startWithAppId:@"cd014b9ee5" config:config];

}

@end
