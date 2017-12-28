//
//  ReadStatusView.m
//  Read
//
//  Created by inveno on 17/4/27.
//  Copyright © 2017年 Read. All rights reserved.
//

#import "ReadStatusView.h"

@implementation ReadStatusView

- (instancetype)initWithFrame:(CGRect)frame image:(NSString *)image title:(NSString *)title
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initSubView:image title:title];
    }
    return self;
}
+(void)showReadStatusWithStatus:(ReadStatusType)type inView:(UIView *)view WithFrame:(CGRect)frame
{
    ReadStatusView *loading = [view viewWithTag:987654322];
    if (type == readStatusFinish) {
        if (loading!=nil) {
            [loading removeFromSuperview];
            return;
        }
    }
    if (loading == nil && type != readStatusFinish) {
        loading = [[ReadStatusView alloc] initWithFrame:CGRectEqualToRect(frame, CGRectZero)?view.bounds:frame image:type == ReadStatusNoData?@"nodata":@"There is no network" title:type == ReadStatusNoData?@"暂无数据":@"网络连接异常\n请检查设置再重试"];
        loading.backgroundColor = [UIColor whiteColor];
        loading.tag = 987654322;
        [view addSubview:loading];
    }
}

- (void) initSubView:(NSString *)image title:(NSString *)title{
    UIImageView *img = [[UIImageView alloc] initWithImage:[UIImage imageNamed:image]];
    [self addSubview:img];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectZero];
    label.font = [UIFont systemFontOfSize:36];
    label.textColor = [UIColor colorWithHexString:@"#575757"];
    label.textAlignment = NSTextAlignmentCenter;
    [self setAttrString:title label:label];
    [self addSubview:label];
    
    img.frame = CGRectMake((self.width - img.image.size.width)/2, (self.height-img.image.size.height - label.height - 10)/2, img.image.size.width, img.image.size.height);
    label.frame = CGRectMake(0, img.bottom + 10, self.width, label.height);
    label.textAlignment = NSTextAlignmentCenter;
}
- (void)setAttrString:(NSString *)title label:(UILabel *)label
{
    NSMutableAttributedString *attributedString  = [[NSMutableAttributedString alloc] initWithString:title];
    NSMutableParagraphStyle *paragraph = [[ NSMutableParagraphStyle alloc ] init];
    paragraph.alignment = NSTextAlignmentLeft;
    paragraph.lineBreakMode = NSLineBreakByTruncatingTail;
    paragraph.lineSpacing = 6;
    paragraph.hyphenationFactor = 1.0;
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraph range:NSMakeRange(0, attributedString.length)];
    label.numberOfLines = 0;
    label.attributedText = attributedString;
    [label sizeToFit];
}

@end
