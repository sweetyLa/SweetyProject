//
//  BaseService.m
//  EagleCloud
//
//  Created by    apple on 2017/11/8.
//  Copyright © 2017年 sweety. All rights reserved.
//

#import "BaseService.h"
#import "LoginViewController.h"
#import "RDevice.h"

@implementation BaseService

/**
 *  发送一个POST请求
 */
+ (void)postServiceWithMothedName:(NSString *)mothedName
                           params:(NSDictionary *)params
                          succeed:(void (^)(id response))success
                             fail:(void (^)(void))failure{
    NSString * requestUrl = [NSString stringWithFormat:@"%@",mothedName];
    // NSLog(@"==打印网址==%@",requestUrl);
    AFHTTPSessionManager *session = [AFHTTPSessionManager manager];
    session.requestSerializer =[AFJSONRequestSerializer serializer];
    [session.requestSerializer setTimeoutInterval:50.0];
    session.responseSerializer.acceptableContentTypes=[NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html",@"text/plain",@"multipart/form-data",@"application/octet-stream", nil];
    [session POST:requestUrl parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if ([responseObject objectForKey:@"errorCode"] && [[responseObject objectForKey:@"errorCode"] isEqualToString:@"authError"])
        {
            NSString * account = [[NSUserDefaults standardUserDefaults]objectForKey:@"account"];
            NSString * password = [[NSUserDefaults standardUserDefaults] objectForKey:@"password"];
            
            NSUserDefaults* defs = [NSUserDefaults standardUserDefaults];
            NSDictionary* dict = [defs dictionaryRepresentation];
            for(id key in dict) {
                
                [defs removeObjectForKey:key];
            }
            [defs synchronize];
            
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                //文件路径
                NSString *directoryPath=[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) firstObject];
                NSArray *subpaths = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:directoryPath error:nil];
                for (NSString *subPath in subpaths) {
                    NSString *filePath = [directoryPath stringByAppendingPathComponent:subPath];
                    [[NSFileManager defaultManager] removeItemAtPath:filePath error:nil];
                }
            });
            
            [[NSUserDefaults standardUserDefaults] setObject:account forKey:@"account"];
            [[NSUserDefaults standardUserDefaults] setObject:password forKey:@"password"];
            [[NSUserDefaults standardUserDefaults] synchronize];
            
            
            UIWindow *keyWindow = [UIApplication sharedApplication].keyWindow;
            LoginViewController *login = [[LoginViewController alloc] init];
//            login.type = @"退出登录";
            BaseNavigationViewController *nav = [[BaseNavigationViewController alloc] initWithRootViewController:login];
            keyWindow.rootViewController = nav;
        }
        else
        {
            success(responseObject);
        }
        // [hud removeFromSuperview];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error)
     {
         //  [hud removeFromSuperview];
         failure();
         NSLog(@"网络连接发生错误---%@",error);
         AFNetworkReachabilityManager *manager = [AFNetworkReachabilityManager sharedManager];
         [manager startMonitoring];
         
         [manager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
             [[NSNotificationCenter defaultCenter]postNotificationName:@"NONetWork" object:nil];
             if (status != AFNetworkReachabilityStatusNotReachable) {
                 
                 failure();
                 MBShow(@"服务器连接失败");
             } else {
                 //没网
                 failure();
                 MBShow(@"网络连接异常");
             }
         }];
         [manager stopMonitoring];
     }];
}

@end
