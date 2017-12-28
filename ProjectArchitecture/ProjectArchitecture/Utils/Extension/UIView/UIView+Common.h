//
//  NSObject+Coding.h
//
//  实用的分类
//
//  Created by Leung
//  Copyright (c) 2015年 Leung. All rights reserved.
//


#import <UIKit/UIKit.h>


@interface UIView (Common)

/**
 *	@brief	获取视图中点横坐标
 *
 *	@return	坐标值
 */
- (CGFloat)centerX;
- (void)setCenterX:(CGFloat)x;

/**
 *	@brief	获取视图中点纵坐标
 *
 *	@return	坐标值
 */
- (CGFloat)centerY;
- (void)setCenterY:(CGFloat)y;

/**
 *	@brief	获取左上角横坐标
 *
 *	@return	坐标值
 */
- (CGFloat)left;
- (void)setLeft:(CGFloat)left;

/**
 *	@brief	获取左上角纵坐标
 *
 *	@return	坐标值
 */
- (CGFloat)top;
- (void)setTop:(CGFloat)top;

/**
 *	@brief	获取视图右下角横坐标
 *
 *	@return	坐标值
 */
- (CGFloat)right;
- (void)setRight:(CGFloat)right;

/**
 *	@brief	获取视图右下角纵坐标
 *
 *	@return	坐标值
 */
- (CGFloat)bottom;
- (void)setBottom:(CGFloat)bottom;

/**
 *	@brief	获取视图宽度
 *
 *	@return	宽度值（像素）
 */
- (CGFloat)width;
- (void)setWidth:(CGFloat)width;

/**
 *	@brief	获取视图高度
 *
 *	@return	高度值（像素）
 */
- (CGFloat)height;
- (void)setHeight:(CGFloat)height;

/**
 *	@brief	获取视图坐标
 *
 *	@return	坐标值（点）
 */
- (CGPoint)origin;
- (void)setOrigin:(CGPoint)origin;

/**
 *	@brief	获取视图大小
 *
 *	@return	大小
 */
- (CGSize)size;
- (void)setSize:(CGSize)size;

/**
 *	@brief	删除所有子对象
 */
- (void)removeAllSubviews;

/**
 *  @brief  设置 UIView 的圆角属性(设置完大小后使用)
 */
- (void)setRadiusWith:(UIRectCorner)rectCorner cornerRadii:(CGSize)size;

/**
 *  @brief  该view所在的 VC
 */
- (UIViewController *)viewController;

/**
 *  @brief  该view所在的 NavC
 */
- (UINavigationController *)navigationController;

/**
 *  @brief  获取当前view的截图
 **/
- (UIImage *)snapshot;


- (BOOL)isDisplayedInScreen;

/**
 *  控件修圆
 *
 *  @param angle 修圆的弧度数
 */
- (void)radiusWithAngle:(CGFloat)angle;

#pragma mark 毛玻璃效果
@end
