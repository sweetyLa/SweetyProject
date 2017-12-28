//
//  MainTabbar.m
//  EagleCloud
//
//  Created by    apple on 2017/11/7.
//  Copyright © 2017年 sweety. All rights reserved.
//

#import "MainTabbar.h"

@implementation MainTabbar

- (instancetype)init
{
    self = [super init];
    if (self) {
        
        
        
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setImage:[UIImage imageNamed:@"plus_Last"] forState:UIControlStateNormal];
        btn.bounds = CGRectMake(0, 0, 64, 64);
        self.recognitionBtn = btn;
        [self addSubview:btn];
        
        
        
    }
    return self;
}

- (void)layoutSubviews
{
    
    [super layoutSubviews];
    
    self.recognitionBtn.center = CGPointMake(self.bounds.size.width * 0.5, self.bounds.size.height * 0.3);
    
    int index = 0;
    CGFloat width = self.bounds.size.width / 5;
    
    for (UIView* sub in self.subviews) {
        
        if ([sub isKindOfClass:NSClassFromString(@"UITabBarButton")]) {
            
            sub.frame = CGRectMake(index * width, self.bounds.origin.y, width, self.bounds.size.height - 2);
            
            index++;
            
            if (index == 2) {
                index++;
            }
        }
    }
}



- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
    
    if (self.isHidden == NO) {
        
        CGPoint newPoint = [self convertPoint:point toView:self.recognitionBtn];
        
        if ( [self.recognitionBtn pointInside:newPoint withEvent:event]) {
            return self.recognitionBtn;
        }else{
            
            return [super hitTest:point withEvent:event];
        }
    }
    
    else {
        return [super hitTest:point withEvent:event];
    }
}


@end
