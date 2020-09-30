//
//  LNCHBBaseViewController.m
//  PLMMPRJK
//
//  Created by HuXuPeng on 2017/4/11.
//  Copyright © 2017年 GoMePrjk. All rights reserved.
//

#import "NCHBaseViewController.h"

@interface NCHBaseViewController ()

@end

@implementation NCHBaseViewController


#pragma mark - 生命周期
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor systemBackgroundColor];
    self.automaticallyAdjustsScrollViewInsets = NO;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (@available(iOS 11.0, *)){
            [[UIScrollView appearanceWhenContainedInInstancesOfClasses:@[[NCHBaseViewController class]]] setContentInsetAdjustmentBehavior:UIScrollViewContentInsetAdjustmentNever];
        }
    });
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    // 配置友盟统计
//    [NCHUMengHelper beginLogPageViewName:self.title ?: self.navigationItem.title];
    
}


- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
}


- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    
    // 配置友盟统计
//    [NCHUMengHelper endLogPageViewName:self.title ?: self.navigationItem.title];
}

- (instancetype)initWithTitle:(NSString *)title
{
    if (self = [super init]) {
        self.title = title.copy;
    }
    return self;
}

- (void)dealloc
{
    NSLog(@"dealloc---%@", self.class);
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end







