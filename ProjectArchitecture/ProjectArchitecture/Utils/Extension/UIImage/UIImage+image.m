//
//  UIImage+image.m
//  EagleCloud
//
//  Created by    apple on 2017/11/7.
//  Copyright © 2017年 sweety. All rights reserved.
//

#import "UIImage+image.h"

@implementation UIImage (image)

+ (instancetype)imageWithOringinalName:(NSString *)imageName
{
    UIImage *image =[UIImage imageNamed:imageName];
    // 图片不渲染
    return [image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
}
//裁剪rect之后的图片
- (UIImage *)imageAtRect:(CGRect)rect
{
    
    CGImageRef imageRef = CGImageCreateWithImageInRect([self CGImage], rect);
    UIImage* subImage = [UIImage imageWithCGImage: imageRef];
    CGImageRelease(imageRef);
    
    return subImage;
}
//裁剪rect之后的图片
- (UIImage *)getPartOfImage:(UIImage *)img rect:(CGRect)partRect
{
    CGImageRef imageRef = img.CGImage;
    CGImageRef imagePartRef = CGImageCreateWithImageInRect(imageRef, partRect);
    UIImage * retImg = [UIImage imageWithCGImage:imagePartRef];
    CGImageRelease(imagePartRef);
    return retImg;
}

+ (UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size {
    UIGraphicsBeginImageContextWithOptions(size, 0, [UIScreen mainScreen].scale);
    [color set];
    UIRectFill(CGRectMake(0, 0, size.width, size.height));
    UIImage *pureColorImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return pureColorImage;
}


@end
