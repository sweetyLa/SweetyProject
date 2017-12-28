//
//  HTDevice.m
//  hotoday
//
//  Created by he15his on 15/11/25.
//  Copyright © 2015年 inveno. All rights reserved.
//

#import "RDevice.h"
 

@interface RDevice()
@property (nonatomic, strong) Reachability *reachability;

@end

@implementation RDevice

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
//重写生成与父类不一样的单例
+ (instancetype)manager {
    static id manager;
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        manager = [[self alloc] init];
    });
    return manager;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        self.reachability = [Reachability reachabilityForInternetConnection];
        self.networkStatus = [_reachability currentReachabilityStatus];
        [_reachability startNotifier];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(networkChange:) name:kReachabilityChangedNotification object:nil];
    }
    return self;
}

 #pragma mark - Notification
- (void)networkChange:(NSNotification *)notification {
    Reachability *noteObject = notification.object;
    self.networkStatus = [noteObject currentReachabilityStatus];
    if (_cNetworkStatus) {
        _cNetworkStatus(self.networkStatus);
    }
}

@end
