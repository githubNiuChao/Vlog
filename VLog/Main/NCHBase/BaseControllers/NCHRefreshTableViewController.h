//
//  NCHRefreshTableViewController.h
//  VLog
//
//  Created by szy on 2020/9/12.
//  Copyright © 2020 niuchao. All rights reserved.
//

//

#import "NCHTableViewController.h"
#import "NCHAutoRefreshFooter.h"
#import "NCHNormalRefreshHeader.h"

@interface NCHRefreshTableViewController : NCHTableViewController

- (void)loadMore:(BOOL)isMore;


// 结束刷新, 子类请求报文完毕调用
- (void)endHeaderFooterRefreshing;

@end
