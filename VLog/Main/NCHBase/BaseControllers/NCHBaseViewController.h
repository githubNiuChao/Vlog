//
//  LNCHBBaseViewController.h
//  VLog
//
//  Created by szy on 2020/9/12.
//  Copyright © 2020 niuchao. All rights reserved.
//

//

#import <UIKit/UIKit.h>
#import "NCHRequestBaseViewController.h"


@interface NCHBaseViewController : NCHRequestBaseViewController

/**是否显示返回按钮,默认情况是YES*/
@property (nonatomic, assign) BOOL isShowLiftBack;
/**是否隐藏导航栏*/
@property (nonatomic, assign) BOOL isHidenNaviBar;


- (instancetype)initWithTitle:(NSString *)title;

- (void) initNavigationBarTransparent;

- (void) setBackgroundColor:(UIColor *)color;

- (void) setTranslucentCoverWtih:(UIBlurEffectStyle)effectStyle;

- (void) setStatusBarHidden:(BOOL) hidden;

- (void) setStatusBarBackgroundColor:(UIColor *)color;

- (void) setNavigationBarTitle:(NSString *)title;

- (void) setNavigationBarTitleColor:(UIColor *)color;

- (void) setNavigationBarBackgroundColor:(UIColor *)color;

- (void) setNavigationBarBackgroundImage:(UIImage *)image;

- (void) setStatusBarStyle:(UIStatusBarStyle)style;

- (void) setNavigationBarShadowImage:(UIImage *)image;

- (void) back;

- (CGFloat) navagationBarHeight;

- (void) setLeftBarButton:(NSString *)imageName ;
- (void) initLeftBackButton:(NSString *)imageName ;
- (void) initLeftDismissButton:(NSString *)imageName ;

- (void) setBackgroundImage:(NSString *)imageName;

@end
