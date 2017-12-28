//
//  BaseService.h
//  EagleCloud
//
//  Created by    apple on 2017/11/8.
//  Copyright © 2017年 sweety. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BaseService : NSObject
+ (void)postServiceWithMothedName:(NSString *)mothedName
                           params:(NSDictionary *)params
                          succeed:(void (^)(id response))success
                             fail:(void (^)(void))failure;

@end
