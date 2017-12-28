//
//  NSObject+Coding.h
//
//  实用的分类
//
//  Created by Leung
//  Copyright (c) 2015年 Leung. All rights reserved.
//


#import "UIView+Common.h"


@implementation UIView (Common)

#pragma mark CenterX
- (CGFloat)centerX
{
    return self.center.x;
}

- (void)setCenterX:(CGFloat)x
{
    CGPoint center = self.center;
    center.x = x;
    self.center = center;
}

#pragma mark CenterY
- (CGFloat)centerY
{
    return self.center.y;
}

- (void)setCenterY:(CGFloat)y
{
    CGPoint center = self.center;
    center.y = y;
    self.center = center;
}

#pragma mark Left
- (CGFloat)left
{
    return self.frame.origin.x;
}

- (void)setLeft:(CGFloat)left
{
    CGRect frame = self.frame;
    frame.origin.x = left;
    self.frame = frame;
}

#pragma mark Top
- (CGFloat)top
{
    return self.frame.origin.y;
}

- (void)setTop:(CGFloat)top
{
    CGRect frame = self.frame;
    frame.origin.y = top;
    self.frame = frame;
}

#pragma mark Right
- (CGFloat)right
{
    return self.frame.origin.x + self.frame.size.width;
}

- (void)setRight:(CGFloat)right
{
    CGRect frame = self.frame;
    frame.origin.x = right - frame.size.width;
    self.frame = frame;
}

#pragma mark Bottom
- (CGFloat)bottom
{
    return self.frame.origin.y + self.frame.size.height;
}

- (void)setBottom:(CGFloat)bottom
{
    CGRect frame = self.frame;
    frame.origin.y = bottom - frame.size.height;
    self.frame = frame;
}

#pragma mark Width
- (CGFloat)width
{
    return self.frame.size.width;
}

- (void)setWidth:(CGFloat)width
{
    CGRect frame = self.frame;
    frame.size.width = width;
    self.frame = frame;
}

#pragma mark Height
- (CGFloat)height
{
    return self.frame.size.height;
}

- (void)setHeight:(CGFloat)height
{
    CGRect frame = self.frame;
    frame.size.height = height;
    self.frame = frame;
}

#pragma mark Origin
- (CGPoint)origin
{
    return self.frame.origin;
}
- (void)setOrigin:(CGPoint)origin
{
    CGRect frame = self.frame;
    frame.origin = origin;
    self.frame = frame;
}

/**
 *	@brief	获取视图大小
 *
 *	@return	大小
 */
- (CGSize)size
{
    return self.frame.size;
}
- (void)setSize:(CGSize)size
{
    CGRect frame = self.frame;
    frame.size = size;
    self.frame = frame;
}


#pragma mark Other
- (void)removeAllSubviews
{
	while (self.subviews.count) 
    {
		UIView *child = self.subviews.lastObject;
		[child removeFromSuperview];
	}
}

- (void)setRadiusWith:(UIRectCorner)rectCorner cornerRadii:(CGSize)size
{
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:self.bounds byRoundingCorners:rectCorner cornerRadii:size];
    
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.frame = self.bounds;
    maskLayer.path = maskPath.CGPath;
    self.layer.mask = maskLayer;
}

- (UIViewController *)viewController
{
    UIResponder * responder = self;
    while (responder != nil) {
            if ([responder isKindOfClass:[UIViewController class]]) {
                return (UIViewController *)responder;
            }
            responder = responder.nextResponder;
    }
    
    return nil;
}

- (UINavigationController *)navigationController
{
    return self.viewController.navigationController;
}

- (UIImage *)snapshot
{
    UIGraphicsBeginImageContextWithOptions(self.bounds.size, YES, [UIScreen mainScreen].scale);
    
//    CGContextRef contextRef = UIGraphicsGetCurrentContext();
//    [self.layer renderInContext:contextRef];
    
    [self drawViewHierarchyInRect:self.bounds afterScreenUpdates:NO];
    
    UIImage * image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

- (BOOL)isDisplayedInScreen
{
    if (self == nil) {
        return FALSE;
    }
    
    CGRect screenRect = [UIScreen mainScreen].bounds;
    
    // 转换view对应window的Rect
    CGRect rect = [self convertRect:self.frame fromView:nil];
    if (CGRectIsEmpty(rect) || CGRectIsNull(rect)) {
        return FALSE;
    }
    
    // 若view 隐藏
    if (self.hidden) {
        return FALSE;
    }
    
    // 若没有superview
    if (self.superview == nil) {
        return FALSE;
    }
    
    // 若size为CGrectZero
    if (CGSizeEqualToSize(rect.size, CGSizeZero)) {
        return  FALSE;
    }
    
    // 获取 该view与window 交叉的 Rect
    CGRect intersectionRect = CGRectIntersection(rect, screenRect);
    if (CGRectIsEmpty(intersectionRect) || CGRectIsNull(intersectionRect)) {
        return FALSE;
    }
    
    return TRUE;
}

#pragma mark 毛玻璃
- (void)addGroundGlassWithFrame:(CGRect)frame
{
//    UIToolbar *toolBar = [[UIToolbar alloc] initWithFrame:frame];
//    toolBar.barStyle = UIBarStyleBlackTranslucent;
//    toolBar.userInteractionEnabled = NO;
//    [self addSubview:toolBar];
}
//
//- (void)removeGroundGlass
//{
//    for (UIView *view in self.subviews) {
//        if ([view isKindOfClass:[UIToolbar class]]) {
//            [view removeFromSuperview];
//            break;
//        }
//    }
//}

/**
 *  控件修圆
 *
 *  @param angle 修圆的弧度数
 */
- (void)radiusWithAngle:(CGFloat)angle
{
    self.layer.masksToBounds = YES;
    self.layer.cornerRadius = angle;
}




@end
