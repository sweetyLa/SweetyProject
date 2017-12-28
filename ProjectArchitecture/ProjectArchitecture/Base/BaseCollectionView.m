//
//  BaseCollectionView.m
//  EagleCloud
//
//  Created by    apple on 2017/11/8.
//  Copyright © 2017年 sweety. All rights reserved.
//

#import "BaseCollectionView.h"

@implementation BaseCollectionView

- (void)dealloc
{
    self.collectionView = nil;
    self.delegate = nil;
    
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        
    }
    return self;
}
- (void)setIsHeaderRefresh:(BOOL)isHeaderRefresh
{
    if (isHeaderRefresh == YES)
    {
        self.collectionView.mj_header = [MJRefreshGifHeader headerWithRefreshingTarget:self refreshingAction:@selector(clickToUpdateData)];
    }
}
- (void)setIsFooterRefresh:(BOOL)isFooterRefresh
{
    if (isFooterRefresh == YES)
    {
        self.collectionView.mj_footer = [MJRefreshBackFooter footerWithRefreshingTarget:self refreshingAction:@selector(clickToMore)];
    }
}
- (void)setIsNoData:(BOOL)isNoData
{
    if (isNoData == YES)
    {
        self.collectionView.backgroundView.hidden = NO;
    }
    else
    {
        self.collectionView.backgroundView.hidden = YES;
        
    }
}
- (id)initWithFrame:(CGRect)frame collectionView:(UICollectionView *)collectionView
{
    self = [self initWithFrame:frame];
    if (self)
    {
        if (collectionView)
        {
            self.collectionView = collectionView;
            [self.collectionView setBackgroundView:nil];
            [self.collectionView setBackgroundColor:[UIColor clearColor]];
            
        }
        else
        {
            
            _layout = [[UICollectionViewFlowLayout alloc] init];
            _layout.scrollDirection = UICollectionViewScrollDirectionVertical;
            
            self.collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height) collectionViewLayout:_layout];
            [self.collectionView setBackgroundColor:[UIColor clearColor]];
            
            UIView * noDataView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
            
            UIImage * noDataImg = [UIImage imageNamed:@"nodata"];
            UIImageView * noDataIV = [[UIImageView alloc]initWithFrame:CGRectMake((self.width-noDataImg.size.width)/2, (self.height-noDataImg.size.height)/2, noDataImg.size.width, noDataImg.size.height)];
            [noDataIV setImage:noDataImg];
            [noDataView addSubview:noDataIV];
            
            
            UILabel * nodataLab = [[UILabel alloc]initWithFrame:CGRectMake(0, noDataIV.bottom+10, self.width, 19)];
            nodataLab.font = [UIFont systemFontOfSize:36];
            nodataLab.textColor = [UIColor colorWithHexString:@"#575757"];
            nodataLab.textAlignment = NSTextAlignmentCenter;
            nodataLab.text = @"暂无数据";
            [noDataView addSubview:nodataLab];
            
            [self.collectionView setBackgroundView:noDataView];
            self.collectionView.backgroundView.hidden = YES;
        }
        
    }
    
    return self;
    
}
- (void)clickToUpdateData
{
    //更新数据
    if ([self.delegate respondsToSelector:@selector(collectionViewUpdateData)])
    {
        [self.delegate collectionViewUpdateData];
    }
}
- (void)clickToMore
{
    //加载更多
    if ([self.delegate respondsToSelector:@selector(collectionViewLoadMoreData)])
    {
        [self.delegate collectionViewLoadMoreData];
    }
}


- (void)setFrame:(CGRect)frame
{
    [super setFrame:frame];
    [self.collectionView setFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
    
    
}

- (void)setCollectionView:(UICollectionView *)collectionView
{
    _collectionView = collectionView;
    [collectionView setFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
    [self addSubview:collectionView];
    
}


@end
