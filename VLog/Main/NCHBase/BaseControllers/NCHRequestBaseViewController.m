//
//  NCHRequestBaseViewController.m
//  VLog
//
//  Created by szy on 2020/9/12.
//  Copyright © 2020 niuchao. All rights reserved.
//


#import "NCHRequestBaseViewController.h"
#import "MBProgressHUD+NCH.h"

@interface NCHRequestBaseViewController ()

/** <#digest#> */
@property (nonatomic, strong) Reachability *reachHost;

@end

@implementation NCHRequestBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self reachHost];
}

#pragma mark - 加载框
- (void)showLoading
{
    [MBProgressHUD showProgressToView:self.view Text:@"加载中..."];
}

- (void)dismissLoading
{
    [MBProgressHUD hideHUDForView:self.view];
}

#pragma mark - 监听网络状态
- (Reachability *)reachHost
{
    if(_reachHost == nil)
    {
        _reachHost = [Reachability reachabilityWithHostName:@"www.baidu.com"];
        NCWeakSelf(self);
        [_reachHost setUnreachableBlock:^(Reachability * reachability){
            dispatch_async(dispatch_get_main_queue(), ^{
                [weakself networkStatus:reachability.currentReachabilityStatus inViewController:weakself];
            });
        }];
        
        [_reachHost setReachableBlock:^(Reachability * reachability){
            dispatch_async(dispatch_get_main_queue(), ^{
                [weakself networkStatus:reachability.currentReachabilityStatus inViewController:weakself];
            });
        }];
        [_reachHost startNotifier];
    }
    return _reachHost;
}


#pragma mark - NCHRequestBaseViewControllerDelegate
- (void)networkStatus:(NetworkStatus)networkStatus inViewController:(NCHRequestBaseViewController *)inViewController
{
    //判断网络状态
    switch (networkStatus) {
        case NotReachable:
            [MBProgressHUD showError:@"当前网络连接失败，请查看设置" ToView:self.view];
            break;
        case ReachableViaWiFi:
            NSLog(@"wifi上网2");
            break;
        case ReachableViaWWAN:
            NSLog(@"手机上网2");
            break;
        default:
            break;
    }
}


- (void)dealloc
{
    if ([self isViewLoaded]) {
        [MBProgressHUD hideHUDForView:self.view animated:NO];
    }
    [_reachHost stopNotifier];
    _reachHost = nil;
}

@end
