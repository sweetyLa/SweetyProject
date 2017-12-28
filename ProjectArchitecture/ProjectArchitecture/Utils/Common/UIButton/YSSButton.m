//
//  YSSButton.m
//  StudentMobile
//
//  Created by panyuejia on 17/2/15.
//  Copyright © 2017年 panyuejia. All rights reserved.
//

#import "YSSButton.h"

@implementation YSSButton
- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        // 文本靠右
        self.titleLabel.textAlignment = NSTextAlignmentRight;
        // 改变图片内容模糊
//        self.imageView.contentMode = UIViewContentModeLeft;


        
    }
    return self;
}

//-(void)layoutSubviews
//{
//    [super layoutSubviews];
//    
//    // 设置字控件的位置
//    self.titleLabel.frame = CGRectMake(0, 0, 0, 0);
//    self.imageView.frame = CGRectMake(0, 0, 0, 0);
//}

-(void)changeImageFrame:(CGRect )rect{
    _imgeRect=rect;
//    change=1;
    [self layoutSubviews];
}

-(void)changeTitleFrame:(CGRect )rect{
    _titleRect=rect;
//    change=1;
    [self layoutSubviews];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    self.titleLabel.frame = _titleRect;
    self.imageView.frame = _imgeRect;
    

}

@end
