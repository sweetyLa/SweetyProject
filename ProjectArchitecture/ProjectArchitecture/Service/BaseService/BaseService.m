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
    //GCD异步操作
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSString * requestUrl = [NSString stringWithFormat:@"%@",mothedName];
        // NSLog(@"==打印网址==%@",requestUrl);
        AFHTTPSessionManager *session = [YSSAFHTTPSessionManager sharedManager];
        //    AFHTTPSessionManager *session = [AFHTTPSessionManager manager];
        //    session.requestSerializer =[AFJSONRequestSerializer serializer];
        //    [session.requestSerializer setTimeoutInterval:50.0];
        //    session.responseSerializer.acceptableContentTypes=[NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html",@"text/plain",@"multipart/form-data",@"application/octet-stream", nil];
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
                
                //文件路径
                NSString *directoryPath=[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) firstObject];
                NSArray *subpaths = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:directoryPath error:nil];
                for (NSString *subPath in subpaths) {
                    NSString *filePath = [directoryPath stringByAppendingPathComponent:subPath];
                    [[NSFileManager defaultManager] removeItemAtPath:filePath error:nil];
                }
                
                
                [[NSUserDefaults standardUserDefaults] setObject:account forKey:@"account"];
                [[NSUserDefaults standardUserDefaults] setObject:password forKey:@"password"];
                [[NSUserDefaults standardUserDefaults] synchronize];
                
                
                //返回主线程 拿到数据
                dispatch_async(dispatch_get_main_queue(), ^{
                    UIWindow *keyWindow = [UIApplication sharedApplication].keyWindow;
                    LoginViewController *login = [[LoginViewController alloc] init];
                    //            login.type = @"退出登录";
                    BaseNavigationViewController *nav = [[BaseNavigationViewController alloc] initWithRootViewController:login];
                    keyWindow.rootViewController = nav;
                    
                });
                
            }
            else
            {
                dispatch_async(dispatch_get_main_queue(), ^{
                    success(responseObject);
                });
                
            }
            // [hud removeFromSuperview];
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error)
         {
             //  [hud removeFromSuperview];
             //返回主线程 拿到数据
             dispatch_async(dispatch_get_main_queue(), ^{
                 failure();
                 // [hud removeFromSuperview];
                 
             });
             
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
        
    });
}


+(void)uploadFileWithUrl:(NSString *)url params :(NSDictionary *)params succeed:(void (^)(id response))success fail:(void (^)(void))failure
{
    //GCD 异步操作
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        AFHTTPSessionManager *session = [YSSAFHTTPSessionManager sharedManager];
        
        NSMutableDictionary * paramsDic = [NSMutableDictionary dictionary];
        for (NSString *key in params)
        {
            id value = [params objectForKey:key];
            if (![value isKindOfClass:[NSData class]])
            {
                NSLog(@"key====%@ value===%@",key,value);
                [paramsDic setObject:value forKey:key];
            }
            //            else
            //            {
            //                NSLog(@"datakey====%@ value===%@",key,value);
            //
            //            }
            
        }
        [session POST:url parameters:paramsDic constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
            
            for (NSString *key in params)
            {
                id value = [params objectForKey:key];
                if ([value isKindOfClass:[NSData class]])
                {
                    //                    [formData appendPartWithFormData:value name:key];
                    [formData appendPartWithFileData:value name:key fileName:key mimeType:@"jpg/mp4/mp3/wav"];
                }
                
            }
        } progress:^(NSProgress * _Nonnull uploadProgress) {
            NSLog(@"uploadPress====%@",uploadProgress);
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            NSLog(@"params====%@",params);
            
            //    NSDictionary * dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves error:nil];
            //返回主线程 拿到数据
            dispatch_async(dispatch_get_main_queue(), ^{
                success(responseObject);
                
            });
            
            NSLog(@"response===%@",responseObject);
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            NSLog(@"error===%@",error);
            NSDictionary * errorDic = [NSDictionary dictionaryWithObject:@"netError" forKey:@"retCode"];
            //返回主线程 拿到数据
            dispatch_async(dispatch_get_main_queue(), ^{
                success(errorDic);
                
            });
            
            
        }];
        
    });
    
}
+(void)downloadFileWithMotherName:(NSString *)motherName params:(NSDictionary *)params
                          succeed:(void (^)(id response))success
                             fail:(void (^)(void))failure {
    
    AppDelegate *app = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    MBProgressHUD *hud = nil;
    if (app.window) {
        hud = [MBProgressHUD showHUDAddedTo:app.window animated:YES];
    }
    else
    {
        hud = [MBProgressHUD showHUDAddedTo:app.window.rootViewController.view animated:YES];
    }
    hud.mode = MBProgressHUDModeDeterminate;
    hud.detailsLabel.text = @"下载中...";
    
    AFURLSessionManager *manager = [YSSAFHTTPSessionManager sharedManager];
    NSString *urlStr = [NSString stringWithFormat:@"%@?account=%@&token=%@&basePathType=%@&file_path=%@",motherName,params[@"account"],params[@"token"],params[@"basePathType"],params[@"file_path"]];
    NSURL *URL = [NSURL URLWithString:urlStr];
    NSURLRequest *request = [NSURLRequest requestWithURL:URL];
    NSURLSessionDownloadTask *downloadTask = [manager downloadTaskWithRequest:request progress:^(NSProgress * _Nonnull downloadProgress) {
        //监听下载进度
        //completedUnitCount 已经下载的数据大小
        //totalUnitCount     文件数据的中大小
        dispatch_async(dispatch_get_main_queue(), ^{
            hud.progress = 1.0 * downloadProgress.completedUnitCount / downloadProgress.totalUnitCount;
        });
        //        NSLog(@"%.1f",hud.progress);
    } destination:^NSURL *(NSURL *targetPath, NSURLResponse *response) {
        
        NSURL *documentsDirectoryURL = [[NSFileManager defaultManager] URLForDirectory:NSCachesDirectory inDomain:NSUserDomainMask appropriateForURL:nil create:NO error:nil];
        
        NSArray *docArr = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
        NSString *docPath = docArr.lastObject;
        NSFileManager *fileManager = [NSFileManager defaultManager];
        
        NSString *filePath = [docPath stringByAppendingPathComponent:@"Download/"];
        
        if (![[NSFileManager defaultManager]fileExistsAtPath:filePath]) {
            [fileManager createDirectoryAtPath:filePath withIntermediateDirectories:YES attributes:nil error:nil];
        }
        if ([params[@"basePathType"] integerValue] == 8) {
            return [documentsDirectoryURL URLByAppendingPathComponent:[NSString stringWithFormat:@"Download/%@",[[response suggestedFilename] stringByAppendingString:@".zip"]]];
        }
        else
        {
            return [documentsDirectoryURL URLByAppendingPathComponent:[NSString stringWithFormat:@"Download/%@",[response suggestedFilename]]];
        }
        
    } completionHandler:^(NSURLResponse *response, NSURL *filePath, NSError *error) {
        [hud hideAnimated:YES];
        if (error)
        {
            AFNetworkReachabilityManager *manager = [AFNetworkReachabilityManager sharedManager];
            [manager startMonitoring];
            [manager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
                if (status != AFNetworkReachabilityStatusNotReachable) {
                    failure();
                } else {
                    //没网
                    failure();
                    //MBShow(@"网络连接异常");
                    NSLog(@"网络错误");
                }
            }];
            NSLog(@"网络错误");
            [manager stopMonitoring];
        }
        else
        {
            /**
             *filePath:下载后文件的保存路径
             */
            NSLog(@"%@",filePath);
            success(filePath);
        }
    }];
    [downloadTask resume];
}
+ (void)downLoadFileWithUrl:(NSString *)url
                    succeed:(void (^)(id response))success
                       fail:(void (^)(void))failure
{
    
    AFURLSessionManager *manager = [YSSAFHTTPSessionManager sharedManager];
    NSURL *URL = [NSURL URLWithString:url];
    NSURLRequest *request = [NSURLRequest requestWithURL:URL];
    NSURLSessionDownloadTask *downloadTask = [manager downloadTaskWithRequest:request progress:^(NSProgress * _Nonnull downloadProgress) {
        //监听下载进度
        //completedUnitCount 已经下载的数据大小
        //totalUnitCount     文件数据的中大小
        //        NSLog(@"%.1f",1.0 * downloadProgress.completedUnitCount / downloadProgress.totalUnitCount);
        //        NSLog(@"111 === %lld   222 === %lld",downloadProgress.completedUnitCount,downloadProgress.totalUnitCount);
        //        dispatch_async(dispatch_get_main_queue(), ^{
        //
        ////             NSLog(@"%.1f",1.0 * downloadProgress.completedUnitCount / downloadProgress.totalUnitCount);
        //        });
        
    } destination:^NSURL *(NSURL *targetPath, NSURLResponse *response) {
        
        NSString*path= [MyMBHud savaReadBookWithPath:response.suggestedFilename];
        //NSLog(@"--==-0------%@---------%@",path,paths);
        
        return [NSURL fileURLWithPath:path];
        
    } completionHandler:^(NSURLResponse *response, NSURL *filePath, NSError *error) {
        //        [hud hideAnimated:YES];
        if (error)
        {
            AFNetworkReachabilityManager *manager = [AFNetworkReachabilityManager sharedManager];
            [manager startMonitoring];
            [manager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
                if (status != AFNetworkReachabilityStatusNotReachable) {
                    failure();
                } else {
                    //没网
                    failure();
                    //MBShow(@"网络连接异常");
                    NSLog(@"网络错误");
                }
            }];
            [manager stopMonitoring];
            success(@"ERROR");
        }
        else
        {
            NSString *FilePath = [filePath path];
            success(FilePath);
        }
    }];
    [downloadTask resume];
}


@end

