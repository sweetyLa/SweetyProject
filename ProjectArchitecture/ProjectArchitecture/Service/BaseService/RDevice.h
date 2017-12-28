//
//  HTDevice.h
//  hotoday
//
//  Created by he15his on 15/11/25.
//  Copyright © 2015年 inveno. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "Reachability.h"

#define Device [HTDevice manager]

@interface RDevice : NSObject

typedef void (^ChangeNetworkStatus) (NetworkStatus networkStatus);

@property (nonatomic, assign) NetworkStatus networkStatus;
@property (nonatomic, strong) ChangeNetworkStatus cNetworkStatus;

+ (instancetype)manager;

@end
