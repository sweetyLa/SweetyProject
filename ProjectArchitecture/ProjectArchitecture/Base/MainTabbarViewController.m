//
//  MainTabbarViewController.m
//  EagleCloud
//
//  Created by    apple on 2017/11/7.
//  Copyright © 2017年 sweety. All rights reserved.
//

#import "MainTabbarViewController.h"
#import "MainTabbar.h"
#import "HomeViewController.h"
#import "ApplicationViewController.h"
#import "RecognitionViewController.h"
#import "FindViewController.h"
#import "MyViewController.h"
#import "BaseNavigationViewController.h"

@interface MainTabbarViewController ()

@end

@implementation MainTabbarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setUpAllChildViewController];

    // 设置自定义的tabbar
    [self setCustomtabbar];
    

}

// 添加所有子控制器
- (void)setUpAllChildViewController
{
    // 首页
    HomeViewController *homeVC = [[HomeViewController alloc] init];
    homeVC.title = @"首页";
    [self addChildController:homeVC title:@"首页" imageName:@"ic-yuedu-nor" selectedImageName:@"ic-yuedu-sel"];
    
    // 应用
    ApplicationViewController *applicationVC = [[ApplicationViewController alloc] init];
    [self addChildController:applicationVC title:@"应用" imageName:@"ic-yuedu-nor" selectedImageName:@"ic-yuedu-sel"];

    
    // 发现
    FindViewController *findVC = [[FindViewController alloc] init];
    [self addChildController:findVC title:@"发现" imageName:@"ic-yuedu-nor" selectedImageName:@"ic-yuedu-sel"];

    // 我的
    MyViewController *myVC = [[MyViewController alloc] init];
    [self addChildController:myVC title:@"我的" imageName:@"ic-yuedu-nor" selectedImageName:@"ic-yuedu-sel"];

}

- (UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size {
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


- (void)setCustomtabbar{
    
    MainTabbar *tabbar = [[MainTabbar alloc]init];
    
    [self setValue:tabbar forKeyPath:@"tabBar"];
    
    [tabbar.recognitionBtn addTarget:self action:@selector(recognitionBtnClick:) forControlEvents:UIControlEventTouchUpInside];

    
}

- (void)recognitionBtnClick:(UIButton *)btn{
    
    
    NSLog(@"点击了中间");
    
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"点击了中间按钮" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    
    [alert show];
    
    
    
}


- (void)addChildController:(UIViewController*)childController title:(NSString*)title imageName:(NSString*)imageName selectedImageName:(NSString*)selectedImageName
{
    
    childController.tabBarItem.image = [UIImage imageWithOringinalName:imageName];
    childController.tabBarItem.selectedImage = [UIImage imageWithOringinalName:selectedImageName];
    //    childCtrl.tabBarItem.imageInsets = UIEdgeInsetsMake(-3, 0, 2, 0);
    [childController.tabBarItem setTitlePositionAdjustment:UIOffsetMake(0, -1)];
    
    //设置标题
    childController.tabBarItem.title = title;
    childController.title = title;
    //指定一下属性
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    //    dic[NSForegroundColorAttributeName] = UIColorFromHex(0xd0011b);//指定字体
    dic[NSForegroundColorAttributeName] = [UIColor colorWithHexString:@"#4990e2"];
    dic[NSFontAttributeName] = [UIFont systemFontOfSize:22];
    
    //指定选中状态下文字颜色
    [childController.tabBarItem setTitleTextAttributes:dic forState:UIControlStateSelected];
    
    // 通过normal状态设置字体大小
    // 字体大小 跟 normal
    NSMutableDictionary *attrnor = [NSMutableDictionary dictionary];
    attrnor[NSFontAttributeName] = [UIFont systemFontOfSize:13.5 weight:UIFontWeightUltraLight];
    [childController.tabBarItem setTitleTextAttributes:attrnor forState:UIControlStateNormal];

    BaseNavigationViewController *nav = [[BaseNavigationViewController alloc]initWithRootViewController:childController];
    [self addChildViewController:nav];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
