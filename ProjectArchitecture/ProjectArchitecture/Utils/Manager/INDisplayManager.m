//
//  HTDisplayManager.m
//  hotoday
//
//  Created by he15his on 15/11/25.
//  Copyright © 2015年 inveno. All rights reserved.
//

#import "INDisplayManager.h"

@implementation INDisplayManager

+ (void)setNavBarDisplay {
    //设置背景
    [[UINavigationBar appearance] setBackgroundImage:[UIImage imageWithColor:[INDisplayManager colorOfMain] size:CGSizeMake(Main_Screen_Width, 64)] forBarMetrics:UIBarMetricsDefault];
    //去掉黑线
    [[UINavigationBar appearance] setShadowImage:[[UIImage alloc] init]];
    //设置标题样式
    //    [[UINavigationBar appearance] setTitleTextAttributes:@{NSFontAttributeName:HTFont_Light(21.5),
    //                                                           NSForegroundColorAttributeName:[UIColor whiteColor]}];

    //设置返回按钮颜色
    [[UINavigationBar appearance] setTintColor:[INDisplayManager colorOfMain]];
//    //隐藏返回按钮文字
    [[UIBarButtonItem appearance] setBackButtonTitlePositionAdjustment:UIOffsetMake(0, -60)
                                                        forBarMetrics:UIBarMetricsDefault];
//    //设置返回按钮图片
    UIImage *backImage = [[UIImage imageNamed:@"back_btn_icon"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    [[UINavigationBar appearance] setBackIndicatorImage:backImage];
    [[UINavigationBar appearance] setBackIndicatorTransitionMaskImage:backImage];
    
    [[UIBarButtonItem appearance] setTintColor:[UIColor whiteColor]];
}

#pragma mark - Colors

+ (UIColor *)colorOfMain {
    return [UIColor colorWithHexString:@"#4a90e2"];
}
@end
