//
//  Common.h
//  EagleCloud
//
//  Created by    apple on 2017/11/8.
//  Copyright © 2017年 sweety. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Common : NSObject

// 高度
+ (CGFloat)heightWithText:(NSString *)text Font:(CGFloat)font width:(CGFloat)width;
// 宽度
+ (CGFloat)widthWithText:(NSString *)text Font:(UIFont *)font width:(CGFloat)width;
//获取当前屏幕显示的viewcontroller
+ (UIViewController *)getCurrentVC;
//验证手机号
+(BOOL)validateMobile:(NSString *)mobileNum;

@end
