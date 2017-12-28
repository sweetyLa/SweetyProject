//
//  DefineHeader.h
//  EagleCloud
//
//  Created by    apple on 2017/11/8.
//  Copyright © 2017年 sweety. All rights reserved.
//

#ifndef DefineHeader_h
#define DefineHeader_h

#define Main_Screen_Width [UIScreen mainScreen].bounds.size.width
#define Main_Screen_Height [UIScreen mainScreen].bounds.size.height
#define MBShow(aMessage) [MyMBHud getShowLableText:aMessage];
#define User_default [NSUserDefaults standardUserDefaults]
#define kWeakSelf __weak typeof(self) weakSelf = self;

#endif /* DefineHeader_h */
