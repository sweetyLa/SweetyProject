//
//  UIImage+image.h
//  EagleCloud
//
//  Created by    apple on 2017/11/7.
//  Copyright © 2017年 sweety. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (image)

// 加载最原始的图片, 没有渲染的
+ (instancetype)imageWithOringinalName:(NSString *)imageName;

- (UIImage *)imageAtRect:(CGRect)rect;

- (UIImage *)getPartOfImage:(UIImage *)img rect:(CGRect)partRect;

+ (UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size;

@end
