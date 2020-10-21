//
//  NCHRefreshCollectionViewController.h
//  VLog
//
//  Created by szy on 2020/9/12.
//  Copyright © 2020 niuchao. All rights reserved.
//

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
