//
//  YSSHUD.m
//  StudentMobile
//
//  Created by panyuejia on 17/2/23.
//  Copyright © 2017年 panyuejia. All rights reserved.
//

#import "YSSHUD.h"


@implementation YSSHUD

-(void)layoutSubviews
{
    [super layoutSubviews];
    
    self.mode = MBProgressHUDModeCustomView;
    UIImageView *gifImageView = [[UIImageView alloc] initWithImage:[UIImage sd_animatedGIFNamed:@"loading"]];
    gifImageView.backgroundColor = [UIColor clearColor];
    self.customView = gifImageView;
    self.bezelView.backgroundColor = [UIColor clearColor];
//    [self hideAnimated:YES afterDelay:6];
}

@end
