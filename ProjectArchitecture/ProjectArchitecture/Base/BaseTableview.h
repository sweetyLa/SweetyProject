//
//  BaseTableview.h
//  EagleCloud
//
//  Created by    apple on 2017/11/8.
//  Copyright © 2017年 sweety. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseTableview : UIView

@property (nonatomic, assign)id delegate;
@property (nonatomic, retain)UITableView *tableView;

//是否有下拉刷新
@property (nonatomic,assign) BOOL isHeaderRefresh;
//是否有上拉加载
@property (nonatomic,assign) BOOL isFooterRefresh;
//是否是无数据,如果数据为空，则加载空页面
@property (nonatomic,assign) BOOL isNoData;


- (id)initWithFrame:(CGRect)frame tableView:(UITableView *)tabelView;

@end

@protocol BaseTableViewDelegate <NSObject>

@optional
//刷新数据
- (void)tableViewUpdateData;
//加载更多数据
- (void)tableViewLoadMoreData;

@end
