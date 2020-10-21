//
//  NCHNavigationController.m
//  VLog
//
//  Created by szy on 2020/9/12.
//  Copyright © 2020 niuchao. All rights reserved.
//


#import "NCHNavigationController.h"

@interface NCHNavigationController ()

/** 系统的右划返回功能的代理记录 */
//@property (nonatomic, strong) id popGesDelegate;

@end

@implementation NCHNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 不让自控制器控制系统导航条
//    self.fd_viewControllerBasedNavigationBarAppearanceEnabled = NO;
    self.navigationBar.translucent = NO;
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if (self.childViewControllers.count != 0) {
        viewController.hidesBottomBarWhenPushed = YES;
    }
    
    [super pushViewController:viewController animated:animated];
}
@end


