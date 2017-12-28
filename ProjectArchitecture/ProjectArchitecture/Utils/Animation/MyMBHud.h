//
//  MyMBHud.h
//  YS-Class
//
//  Created by 913 on 15/12/14.
//  Copyright © 2015年 913. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MBProgressHUD.h"

@interface MyMBHud : NSObject

+(void)getShowLableText:(NSString*)lableText;
+(void)showErrorWithText:(NSString *)text;
+(void)getShowLableText:(NSString*)lableText offset:(float)offset;

+(void)getShowLaberText:(NSString *)lableText View:(UIView *)view;
+(MBProgressHUD *)showLoadingLaberText:(NSString *)lableText View:(UIView *)view;
+(MBProgressHUD *)hiddenLoadingLaberText:(NSString *)lableText hud:(MBProgressHUD *)hud;
//无延迟隐藏动画
+(MBProgressHUD *)hiddenLoadingWithNoDelayLaberText:(NSString *)lableText hud:(MBProgressHUD *)hud;
//时间戳转换为时间
+(NSString*)creatTimeString:(double)string format:(NSString *)formatStr;
//字典转json字符串
+(NSString*)dictionaryToJson:(NSDictionary *)dic;
// 将16进制字符串转换成uicolor
+(UIColor*)toUIColorByStr:(NSString*)colorStr;
//时间转换成时间戳
+(double)creatFoString:(NSString*)string;
//时间转换时间
+(NSString*)creatString:(NSString*)string format:(NSString *)formatStr;

//存储电子书
+(NSString*)savaReadBookWithPath:(NSString*)bookId;
//删除书籍
+ (void)DeleteBooksWithStr:(NSMutableArray *)bookStrArray;
//获取电子书
+(NSString*)getReadBookWithPath:(NSString*)bookId;

//判断电子书是否存在
+(BOOL)judgeReadBookWithPath:(NSString*)bookId;

// 根据下载颜色类型判断颜色类型
+(NSString *)colorWithType:(NSString *)type;
//改变tabbar的颜色
+ (UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size;
//截取图片的某一部分
+(UIImage *)clipImageInRect:(CGRect)rect WithImg:(UIImage *)img;

@end
