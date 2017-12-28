//
//  Common.m
//  EagleCloud
//
//  Created by    apple on 2017/11/8.
//  Copyright © 2017年 sweety. All rights reserved.
//

#import "Common.h"

@implementation Common

/**
 自适应高度
 
 @param text 文本内容
 @param font 字体大小
 @param width 宽度
 @return 高度
 */
+ (CGFloat)heightWithText:(NSString *)text Font:(CGFloat)font width:(CGFloat)width
{
    CGSize sizeText =[text boundingRectWithSize:CGSizeMake(width, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:font]} context:nil].size;
    
    return sizeText.height + 20;
}

/**
 自适应宽度
 
 @param text 文本内容
 @param font 字体
 @param width 宽度
 @return 宽度
 */
+ (CGFloat)widthWithText:(NSString *)text Font:(UIFont *)font width:(CGFloat)width
{
    CGSize sizeText =[text boundingRectWithSize:CGSizeMake(width, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:font} context:nil].size;
    
    return sizeText.width;
}

//获取当前屏幕显示的viewcontroller
+ (UIViewController *)getCurrentVC
{
    UIViewController *result = nil;
    
    UIWindow * window = [[UIApplication sharedApplication] keyWindow];
    if (window.windowLevel != UIWindowLevelNormal)
    {
        NSArray *windows = [[UIApplication sharedApplication] windows];
        for(UIWindow * tmpWin in windows)
        {
            if (tmpWin.windowLevel == UIWindowLevelNormal)
            {
                window = tmpWin;
                break;
            }
        }
    }
    
    UIView *frontView = [[window subviews] objectAtIndex:0];
    id nextResponder = [frontView nextResponder];
    
    if ([nextResponder isKindOfClass:[UIViewController class]])
        result = nextResponder;
    else
        result = window.rootViewController;
    
    return result;
}

//验证手机号
+(BOOL)validateMobile:(NSString *)mobileNum
{
    NSString * regularExpression = @"^(((13[0-9]{1})|(15[0-9]{1})|(17[0-9]{1})|(18[0-9]{1})|(14[0-9]{1}))+\\d{8})$";
    NSPredicate * predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@" , regularExpression];
    return [predicate evaluateWithObject:mobileNum];

}


@end
