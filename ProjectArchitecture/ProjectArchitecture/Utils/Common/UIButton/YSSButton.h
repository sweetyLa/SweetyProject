//
//  YSSButton.h
//  StudentMobile
//
//  Created by panyuejia on 17/2/15.
//  Copyright © 2017年 panyuejia. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YSSButton : UIButton
@property (assign, nonatomic) CGRect imgeRect;
@property (assign, nonatomic) CGRect titleRect;

-(void)changeImageFrame:(CGRect )rect;
-(void)changeTitleFrame:(CGRect )rect;

@end
