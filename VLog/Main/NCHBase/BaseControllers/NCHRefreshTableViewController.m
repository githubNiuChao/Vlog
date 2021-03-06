//
//  NCHRefreshTableViewController.m
//  VLog
//
//  Created by szy on 2020/9/12.
//  Copyright © 2020 niuchao. All rights reserved.
//

//

#import "NCHRefreshTableViewController.h"


@interface NCHRefreshTableViewController ()

@end

@implementation NCHRefreshTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NCWeakSelf(self);
    self.tableView.mj_header = [NCHNormalRefreshHeader headerWithRefreshingBlock:^{
        [weakself loadIsMore:NO];
    }];
    self.tableView.mj_footer = [NCHAutoRefreshFooter footerWithRefreshingBlock:^{
        [weakself loadIsMore:YES];
    }];
    [self.tableView.mj_header beginRefreshing];
}


// 内部方法
- (void)loadIsMore:(BOOL)isMore
{
    // 控制只能下拉或者上拉
    if (isMore) {
        if ([self.tableView.mj_header isRefreshing]) {
            [self.tableView.mj_footer endRefreshing];
            return;
        }
        self.tableView.mj_header.hidden = YES;
        self.tableView.mj_footer.hidden = NO;
    }else
    {
        if ([self.tableView.mj_footer isRefreshing]) {
            [self.tableView.mj_header endRefreshing];
            return;
        }
        self.tableView.mj_header.hidden = NO;
        self.tableView.mj_footer.hidden = YES;
    }
    [self loadMore:isMore];
}


// 结束刷新
- (void)endHeaderFooterRefreshing
{
    NSLog(@"tableview----------------endHeaderFooterRefreshing");
    // 结束刷新状态
    ![self.tableView.mj_header isRefreshing] ?: [self.tableView.mj_header endRefreshing];
    ![self.tableView.mj_footer isRefreshing] ?: [self.tableView.mj_footer endRefreshing];
    self.tableView.mj_header.hidden = NO;
    self.tableView.mj_footer.hidden = NO;
}

// 子类需要调用调用
- (void)loadMore:(BOOL)isMore
{
//   NSAssert(0, @"子类必须重载%s", __FUNCTION__);
}


@end











