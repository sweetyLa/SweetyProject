//
//  MyMBHud.m
//  YS-Class
//
//  Created by 913 on 15/12/14.
//  Copyright © 2015年 913. All rights reserved.
//

#import "MyMBHud.h"

@implementation MyMBHud
//飘窗
+(void)getShowLableText:(NSString*)lableText;
{
    MBProgressHUD * hud =  [MBProgressHUD showHUDAddedTo:[[UIApplication sharedApplication] keyWindow] animated:YES];
    hud.userInteractionEnabled = NO;
    hud.mode =MBProgressHUDModeText;
    hud.offset = CGPointMake(0, Main_Screen_Height-30);
//    [hud.label setBackgroundColor:[UIColor redColor]];
    hud.label.text = lableText.length>0?lableText:@"";
    hud.label.numberOfLines = 0;
    [hud hideAnimated:YES afterDelay:1];
}

+(void)showErrorWithText:(NSString *)text
{
    MBProgressHUD * hud =  [MBProgressHUD showHUDAddedTo:[[UIApplication sharedApplication] keyWindow] animated:YES];
    hud.mode =MBProgressHUDModeText;
    hud.offset = CGPointMake(0, Main_Screen_Height-30);
    hud.label.text = text;
    [hud hideAnimated:YES afterDelay:1];
}
+(MBProgressHUD *)showLoadingLaberText:(NSString *)lableText View:(UIView *)view{
    
    MBProgressHUD * hud =  [MBProgressHUD showHUDAddedTo:view animated:YES];
    if (lableText) {
        hud.labelText = lableText;
    }
    [hud show:YES];
    return hud;
}
+(MBProgressHUD *)hiddenLoadingLaberText:(NSString *)lableText hud:(MBProgressHUD *)hud{
    if (lableText) {
        hud.mode = MBProgressHUDModeText;
        hud.labelText = lableText;
    }
    [hud hide:YES afterDelay:1.5];
    return hud;
}
+(MBProgressHUD *)hiddenLoadingWithNoDelayLaberText:(NSString *)lableText hud:(MBProgressHUD *)hud{
    if (lableText) {
        hud.mode = MBProgressHUDModeText;
        hud.labelText = lableText;
    }
    [hud hide:YES];
    return hud;
}

+(void)getShowLableText:(NSString*)lableText offset:(float)offset
{
    MBProgressHUD * hud =  [MBProgressHUD showHUDAddedTo:[[UIApplication sharedApplication] keyWindow] animated:YES];
    hud.mode =MBProgressHUDModeText;
    hud.yOffset = offset;
    hud.labelText=lableText;
    [hud hide:YES afterDelay:1];
}


+(void)getShowLaberText:(NSString *)lableText View:(UIView *)view
{
    MBProgressHUD * hud =  [MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.mode =MBProgressHUDModeText;
    //   NSLog(@"------%f-----",view.bounds.size.height);
    hud.yOffset = view.bounds.size.height/2.0/2.0;
    hud.labelText=lableText;
    [hud hide:YES afterDelay:1];
}

//时间戳转换为时间
+(NSString*)creatTimeString:(double)string format:(NSString *)formatStr
{
    
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:string];
    NSDateFormatter * fo =[[NSDateFormatter alloc]init];
    [fo setDateFormat:formatStr];
    NSString * target =[fo stringFromDate:date];
    return target ;
}
+(NSString*)dictionaryToJson:(NSDictionary *)dic
{
    NSError *parseError = nil;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dic options:NSJSONWritingPrettyPrinted error:&parseError];
    return [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    
}
// 将16进制字符串转换成uicolor
+(UIColor*)toUIColorByStr:(NSString*)colorStr
{
    
    NSString *cString = [[colorStr stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    //if ([cString hasPrefix:@"#"]) cString = [cString substringFromIndex:1];
    if ([cString length] != 6) return [UIColor blackColor];
    
    // Separate into r, g, b substrings
    NSRange range;
    range.location = 0;
    range.length = 2;
    NSString *rString = [cString substringWithRange:range];
    range.location = 2;
    NSString *gString = [cString substringWithRange:range];
    range.location = 4;
    NSString *bString = [cString substringWithRange:range];
    // Scan values
    unsigned int r, g, b;
    
    [[NSScanner scannerWithString:rString] scanHexInt:&r];
    [[NSScanner scannerWithString:gString] scanHexInt:&g];
    [[NSScanner scannerWithString:bString] scanHexInt:&b];
    
    return [UIColor colorWithRed:((float) r / 255.0f)
                           green:((float) g / 255.0f)
                            blue:((float) b / 255.0f)
                           alpha:1.0f];
}

//时间转换成时间戳
+(double)creatFoString:(NSString*)string
{
    NSDateFormatter * foo =[[NSDateFormatter alloc]init];
    [foo setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate *date1 = [foo dateFromString:string];
    //转成时间戳
    double timeSSP =[date1 timeIntervalSince1970];
    return timeSSP;
}
+(NSString*)creatString:(NSString*)string format:(NSString *)formatStr
{
    NSDateFormatter * foo =[[NSDateFormatter alloc]init];
    [foo setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate *date1 = [foo dateFromString:string];
    NSDateFormatter * foo1 =[[NSDateFormatter alloc]init];
    [foo1 setDateFormat:formatStr];
    NSString * target =[foo1 stringFromDate:date1];
    return target;
}
//存储电子书
+(NSString*)savaReadBookWithPath:(NSString*)bookId
{
    NSFileManager *manger=[NSFileManager defaultManager];
    NSString *dictoryPath=[NSHomeDirectory() stringByAppendingPathComponent:@"Documents/ReadBook"];
    if (![manger fileExistsAtPath:dictoryPath])
    {
        [manger createDirectoryAtPath:dictoryPath withIntermediateDirectories:YES attributes:nil error:nil];
    }
    NSString *filePath=[NSString stringWithFormat:@"%@/%@",dictoryPath,bookId];
//    if (![manger fileExistsAtPath:filePath])
//    {
//        [manger createFileAtPath:filePath contents:nil attributes:nil];
//    }
    return filePath;
}

//获取电子书
+(NSString*)getReadBookWithPath:(NSString*)bookId
{
    NSString *dictoryPath=[NSHomeDirectory() stringByAppendingPathComponent:@"Documents/ReadBook"];
    NSString *filePath=[NSString stringWithFormat:@"%@/%@",dictoryPath,bookId];
    return filePath;
    
}

//判断电子书是否存在
+(BOOL)judgeReadBookWithPath:(NSString*)bookId
{
    NSFileManager *manger=[NSFileManager defaultManager];
    NSString *dictoryPath=[NSHomeDirectory() stringByAppendingPathComponent:@"Documents/ReadBook"];
    NSString *filePath = [NSString stringWithFormat:@"%@/%@",dictoryPath,bookId];
    return [manger fileExistsAtPath:filePath];
}
//删除书籍
+ (void)DeleteBooksWithStr:(NSMutableArray *)bookStrArray
{
    for (NSString *bookStr in bookStrArray)
    {
        NSFileManager *manger=[NSFileManager defaultManager];
        if ([MyMBHud judgeReadBookWithPath:bookStr] == YES)
        {
            [manger removeItemAtPath:[MyMBHud getReadBookWithPath:bookStr] error:nil];
        }
        NSString *string = [bookStr componentsSeparatedByString:@"."].firstObject;
        NSString *dictoryPath=[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"];
        NSString *filePath = [NSString stringWithFormat:@"%@/%@",dictoryPath,string];
        if ([manger fileExistsAtPath:filePath])
        {
            [manger removeItemAtPath:filePath error:nil];
        }
        if ([[NSUserDefaults standardUserDefaults] objectForKey:bookStr])
        {
            [[NSUserDefaults standardUserDefaults] removeObjectForKey:bookStr];
        }
    }
}
// 根据下载颜色类型判断颜色类型
+(NSString *)colorWithType:(NSString *)type
{
    NSString *name;
    switch ([type intValue]) {
        case 1:
            name = @"D0011B";
            break;
        case 2:
            name = @"F6A623";
            break;
        case 3:
            name = @"8B572A";
            break;
        case 4:
            name = @"BD0FE1";
            break;
        case 5:
            name = @"4990E2";
            break;
        case 6:
            //4990E2
            name = @"D0011B";
            break;
            
        default:
            break;
    }
    return name;
}
+ (UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size {
    if (!color || size.width <=0 || size.height <=0) return nil;
    CGRect rect = CGRectMake(0.0f, 0.0f, size.width, size.height);
    UIGraphicsBeginImageContextWithOptions(rect.size,NO, 0);
    CGContextRef context =UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, color.CGColor);
    CGContextFillRect(context, rect);
    UIImage *image =UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}
//截取图片的某一部分
+(UIImage *)clipImageInRect:(CGRect)rect WithImg:(UIImage *)img;
{
    //屏幕分辨率
    CGFloat scale = 1;//[UIScreen mainScreen].scale;
    CGRect cropImageRect = CGRectMake(rect.origin.x * scale, rect.origin.y * scale, rect.size.width * scale, rect.size.height * scale);
    CGImageRef cgref = img.CGImage;
    CGImageRef imageRef = CGImageCreateWithImageInRect(cgref, cropImageRect);
    UIImage *thumbScale = [UIImage imageWithCGImage:imageRef];
    CGImageRelease(imageRef);
    return thumbScale;
}

@end
