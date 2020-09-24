//
//  NCHRefreshTableViewController.h
//  PLMMPRJK
//
//  Created by HuXuPeng on 2017/4/11.
//  Copyright © 2017年 GoMePrjk. All rights reserved.
//

#import "NCHTableViewController.h"
#import "NCHAutoRefreshFooter.h"
#import "NCHNormalRefreshHeader.h"

@interface NCHRefreshTableViewController : NCHTableViewController

- (void)loadMore:(BOOL)isMore;


// 结束刷新, 子类请求报文完毕调用
- (void)endHeaderFooterRefreshing;

@end
