//
//  BaseTableview.m
//  EagleCloud
//
//  Created by    apple on 2017/11/8.
//  Copyright © 2017年 sweety. All rights reserved.
//

#import "BaseTableview.h"

@implementation BaseTableview

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (void)dealloc
{
    self.tableView = nil;
    self.delegate = nil;
    
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

- (void)setIsHeaderRefresh:(BOOL)isHeaderRefresh
{
    if (isHeaderRefresh == YES)
    {
        self.tableView.mj_header = [MJRefreshGifHeader headerWithRefreshingTarget:self refreshingAction:@selector(clickToUpdateData)];
    }
}
- (void)setIsFooterRefresh:(BOOL)isFooterRefresh
{
    if (isFooterRefresh == YES)
    {
        self.tableView.mj_footer = [MJRefreshBackFooter footerWithRefreshingTarget:self refreshingAction:@selector(clickToMore)];
    }
}
- (void)setIsNoData:(BOOL)isNoData
{
    if (isNoData == YES)
    {
        self.tableView.backgroundView.hidden = NO;
    }
    else
    {
        self.tableView.backgroundView.hidden = YES;
        
    }
}

- (id)initWithFrame:(CGRect)frame tableView:(UITableView *)tabelView;
{
    self = [self initWithFrame:frame];
    if (self)
    {
        if (tabelView)
        {
            self.tableView = tabelView;
            [self.tableView setBackgroundView:nil];
            [self.tableView setBackgroundColor:[UIColor clearColor]];
            
        }
        else
        {
            self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height) style:UITableViewStyleGrouped];
            [self.tableView setBackgroundColor:[UIColor clearColor]];
            
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
            
            [self.tableView setBackgroundView:noDataView];
            self.tableView.backgroundView.hidden = YES;
            
        }
        
    }
    
    return self;
    
}

- (void)clickToUpdateData
{
    //更新数据
    if ([self.delegate respondsToSelector:@selector(tableViewUpdateData)])
    {
        [self.delegate tableViewUpdateData];
    }
}
- (void)clickToMore
{
    //加载更多
    if ([self.delegate respondsToSelector:@selector(tableViewLoadMoreData)])
    {
        [self.delegate tableViewLoadMoreData];
    }
}


- (void)setFrame:(CGRect)frame
{
    [super setFrame:frame];
    [self.tableView setFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
    
    
    
}

- (void)setTableView:(UITableView *)tableView
{
    _tableView = tableView;
    [tableView setFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
    [self addSubview:tableView];
    
}

@end
