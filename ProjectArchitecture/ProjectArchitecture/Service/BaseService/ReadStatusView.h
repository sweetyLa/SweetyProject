//
//  ReadStatusView.h
//  Read
//
//  Created by inveno on 17/4/27.
//  Copyright © 2017年 Read. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^RefreshBlock) (id refreshView);

typedef enum ReadStatusType
{
    ReadStatusNoNetWork = 0,//没有网络
    ReadStatusNoData = 1,//没有数据
    readStatusFinish = 2,//完成，意思就是隐藏，没有网络图片或者没有数据图片
    
}ReadStatusType;

@interface ReadStatusView : UIView

//默认:View的y是导航栏的y+hight,这时frame传CGRectZero，否则就传真实frame
+(void)showReadStatusWithStatus:(ReadStatusType)type inView:(UIView *)view WithFrame:(CGRect)frame;

@end
