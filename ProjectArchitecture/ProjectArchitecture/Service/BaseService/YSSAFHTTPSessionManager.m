
//
//  YSSAFHTTPSessionManager.m
//  StudentMobile
//
//  Created by    apple on 2017/3/20.
//  Copyright © 2017年 panyuejia. All rights reserved.
//

#import "YSSAFHTTPSessionManager.h"
static AFHTTPSessionManager *manager;

@implementation YSSAFHTTPSessionManager

+ (AFHTTPSessionManager *)sharedManager {
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        // 初始化请求管理类
        manager = [AFHTTPSessionManager manager];
        manager.requestSerializer = [AFJSONRequestSerializer serializer];
//        // 设置15秒超时 - 取消请求
        manager.requestSerializer.timeoutInterval = 60;
//        // 编码
//        manager.requestSerializer.stringEncoding = NSUTF8StringEncoding;
//        // 缓存策略
//        manager.requestSerializer.cachePolicy = NSURLRequestReloadIgnoringLocalCacheData;
        
        manager.responseSerializer = [AFJSONResponseSerializer serializer];
        // 支持内容格式
        manager.responseSerializer.acceptableContentTypes=[NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html",@"application/octet-stream",@"multipart/form-data",@"text/plain", nil];
    });
    return manager;
}

@end
