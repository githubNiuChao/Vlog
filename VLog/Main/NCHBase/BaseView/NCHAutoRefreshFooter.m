//
//  NCHAutoRefreshFooter.m
//  VLog
//
//  Created by szy on 2020/9/12.
//  Copyright © 2020 niuchao. All rights reserved.
//

//

#import "NCHAutoRefreshFooter.h"

@implementation NCHAutoRefreshFooter

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self setupUIOnce];
    }
    return self;
}

- (void)awakeFromNib
{
    [super awakeFromNib];
    [self setupUIOnce];
}

- (void)setupUIOnce
{
    self.automaticallyChangeAlpha = YES;
    self.refreshingTitleHidden = YES;
    [self setTitle:@"" forState:MJRefreshStateIdle];
}

// MJBug fix
- (void)endRefreshing {
    [super endRefreshing];
    self.state = MJRefreshStateIdle;

}

- (void)layoutSubviews
{
    [super layoutSubviews];
}

@end
