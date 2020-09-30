//
//  NCHRequestBaseViewController.h
//  PLMMPRJK
//
//  Created by HuXuPeng on 2017/4/24.
//  Copyright © 2017年 GoMePrjk. All rights reserved.
//

#import "NCHTextViewController.h"
#import "Reachability.h"

@class NCHRequestBaseViewController;
@protocol NCHRequestBaseViewControllerDelegate <NSObject>

@optional
#pragma mark - 网络监听
/*
 NotReachable = 0,
 ReachableViaWiFi = 2,
 ReachableViaWWAN = 1,
 ReachableVia2G = 3,
 ReachableVia3G = 4,
 ReachableVia4G = 5,
 */
- (void)networkStatus:(NetworkStatus)networkStatus inViewController:(NCHRequestBaseViewController *)inViewController;

@end

@interface NCHRequestBaseViewController : NCHTextViewController<NCHRequestBaseViewControllerDelegate>
#pragma mark - 加载框

- (void)showLoading;

- (void)dismissLoading;

@end
