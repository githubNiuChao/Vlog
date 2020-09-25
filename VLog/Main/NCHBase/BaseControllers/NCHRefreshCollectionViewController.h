//
//  NCHRefreshCollectionViewController.h
//  PLMMPRJK
//
//  Created by HuXuPeng on 2017/4/11.
//  Copyright © 2017年 GoMePrjk. All rights reserved.
//

#import "NCHCollectionViewController.h"
#import "NCHAutoRefreshFooter.h"
#import "NCHNormalRefreshHeader.h"

@interface NCHRefreshCollectionViewController : NCHCollectionViewController

/// isMore=NO:HeaderisRefreshing
/// isMore=YES:FooterisRefreshing
- (void)loadMore:(BOOL)isMore;

// 结束刷新, 子类请求报文完毕调用
- (void)endHeaderFooterRefreshing;

@end
