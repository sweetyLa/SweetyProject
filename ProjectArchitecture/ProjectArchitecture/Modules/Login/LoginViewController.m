//
//  LoginViewController.m
//  EagleCloud
//
//  Created by    apple on 2017/11/7.
//  Copyright © 2017年 sweety. All rights reserved.
//

#import "LoginViewController.h"
#import "MainTabbarViewController.h"

@interface LoginViewController ()

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
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

- (IBAction)loginAction:(id)sender
{
    UIWindow * window = [[UIApplication sharedApplication].delegate window];
    window.rootViewController = [[MainTabbarViewController alloc] init];
}


@end
