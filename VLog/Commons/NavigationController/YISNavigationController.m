//
//  YISNavigationController.m
//  VLog
//
//  Created by szy on 2020/9/14.
//  Copyright © 2020 niuchao. All rights reserved.
//

#import "YISNavigationController.h"

@interface YISNavigationController ()

@end

@implementation YISNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
//    self.navigationBar.translucent = NO;
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    if (self.viewControllers.count > 0) {
        //第二级则隐藏底部Tab
        viewController.hidesBottomBarWhenPushed = YES;
    }
    [super pushViewController:viewController animated:animated];
}


@end
