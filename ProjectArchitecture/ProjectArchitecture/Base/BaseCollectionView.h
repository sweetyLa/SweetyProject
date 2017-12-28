//
//  BaseCollectionView.h
//  EagleCloud
//
//  Created by    apple on 2017/11/8.
//  Copyright © 2017年 sweety. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseCollectionView : UIView

@property (nonatomic, assign) id delegate;
@property (nonatomic, retain) UICollectionView *collectionView;
@property (nonatomic,retain) UICollectionViewFlowLayout * layout;

//是否有下拉刷新
@property (nonatomic,assign) BOOL isHeaderRefresh;
//是否有上拉加载
@property (nonatomic,assign) BOOL isFooterRefresh;
//是否是无数据,如果数据为空，则加载空页面
@property (nonatomic,assign) BOOL isNoData;

- (id)initWithFrame:(CGRect)frame collectionView:(UICollectionView *)collectionView;

@end

@protocol BaseCollectionViewDelegate <NSObject>

@optional
//刷新数据
- (void)collectionViewUpdateData;
//加载更多数据
- (void)collectionViewLoadMoreData;


@end
