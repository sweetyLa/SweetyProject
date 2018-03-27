//
//  BaseService.h
//  EagleCloud
//
//  Created by    apple on 2017/11/8.
//  Copyright © 2017年 sweety. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YSSAFHTTPSessionManager.h"

@interface BaseService : NSObject
//post请求
+ (void)postServiceWithMothedName:(NSString *)mothedName
                           params:(NSDictionary *)params
                          succeed:(void (^)(id response))success
                             fail:(void (^)(void))failure;
//上传文件
+(void)uploadFileWithUrl:(NSString *)url params :(NSDictionary *)params succeed:(void (^)(id response))success fail:(void (^)(void))failure;

//下载文件
+(void)downloadFileWithMotherName:(NSString *)motherName params:(NSDictionary *)params
                          succeed:(void (^)(id response))success
                             fail:(void (^)(void))failure;
//下载文件，URL后面直接跟path
+ (void)downLoadFileWithUrl:(NSString *)url
                    succeed:(void (^)(id response))success
                       fail:(void (^)(void))failure;


@end

