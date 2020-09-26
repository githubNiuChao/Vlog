//
//  YISPlusButton.m
//  iOSProject
//
//  Created by szy on 2020/9/2.
//  Copyright © 2020 github.com/NCH. All rights reserved.
//

#import "YISPlusButton.h"
#import "CYLTabBarController.h"
#import "YSCVlogPublishViewController.h"
#import "UIViewController+CYLTabBarControllerExtention.h"


@interface YISPlusButton () {
    CGFloat _buttonImageHeight;
}

@end

@implementation YISPlusButton

#pragma mark -
#pragma mark - Life Cycle

+ (void)load {
    //请在 `-[AppDelegate application:didFinishLaunchingWithOptions:]` 中进行注册，否则iOS10系统下存在Crash风险。
    //[super registerPlusButton];
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        self.adjustsImageWhenHighlighted = NO;
    }
    return self;
}

#pragma mark -
#pragma mark - CYLPlusButtonSubclassing Methods

/*
 Create a custom UIButton with title and add it to the center of our tab bar
 */
+ (id)plusButton {
    YISPlusButton *button = [[YISPlusButton alloc] init];
//    UIImage *normalButtonImage = [UIImage imageNamed:@"publish_add"];
//    UIImage *hlightButtonImage = [UIImage imageNamed:@"publish_add"];
//    [button setImage:normalButtonImage forState:UIControlStateNormal];
//    [button setImage:[hlightButtonImage imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate] forState:UIControlStateHighlighted];
//    [button setImage:[hlightButtonImage imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate] forState:UIControlStateSelected];
//    [button setTintColor:  [UIColor colorWithRed:0/255.0f green:255/255.0f blue:189/255.0f alpha:1]];
    UIImage *normalButtonBackImage = [UIImage imageNamed:@"publish_add"];
    [button setBackgroundImage:normalButtonBackImage forState:UIControlStateNormal];
    [button setBackgroundImage:normalButtonBackImage forState:UIControlStateSelected];
    [button sizeToFit]; // or set frame in this way `button.frame = CGRectMake(0.0, 0.0, 250, 100);`
    button.frame = CGRectMake(0.0, 20.0, 60, 60);
    
    // if you use `+plusChildViewController` , do not addTarget to plusButton.
    [button addTarget:button action:@selector(clickPublish) forControlEvents:UIControlEventTouchUpInside];
    return button;
}

#pragma mark -
#pragma mark - Event Response

- (void)clickPublish {
    CYLTabBarController *tabBarController = [self cyl_tabBarController];
    UIViewController *viewController = tabBarController.selectedViewController;
//
//    SINPublishViewController *publishVc = [[SINPublishViewController alloc] init];
//
//// 封装好了, 直接在 block 里边写动画
////    NCWeakSelf(self);
//    [PresentAnimator viewController:viewController presentViewController:[[NCHNavigationController alloc] initWithRootViewController:publishVc] presentViewFrame:[UIScreen mainScreen].bounds animated:YES completion:nil animatedDuration:0.5 presentAnimation:^(UIView *presentedView, UIView *containerView, void (^completionHandler)(BOOL finished)) {
//
//        containerView.transform = CGAffineTransformMakeTranslation(0, -SCREEN_HEIGHT);
//        [UIView animateWithDuration:0.5 animations:^{
//            containerView.transform = CGAffineTransformIdentity;
//        } completion:^(BOOL finished) {
//            completionHandler(finished);
//        }];
//
//    } dismissAnimation:^(UIView *dismissView, void (^completionHandler)(BOOL finished)) {
//
//        CGAffineTransform transform = CGAffineTransformMakeScale(0.2, 0.2);
//        [UIView animateWithDuration:1 animations:^{
//            dismissView.transform = CGAffineTransformRotate(transform, M_PI);
//        } completion:^(BOOL finished) {
//            completionHandler(finished);
//        }];
//    }];
    
    YSCVlogPublishViewController *publishViewController = [[YSCVlogPublishViewController alloc] init];
//    publishViewController.modalPresentationStyle = UIModalPresentationAutomatic;
    publishViewController.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    [viewController presentViewController:publishViewController animated:YES completion:nil];
//    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:nil action:nil];
//    [self.navigationController pushViewController:viewController animated:YES];
//    
//    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
}

#pragma mark - UIActionSheetDelegate
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
- (void)actionSheet:(UIActionSheet *)actionSheet didDismissWithButtonIndex:(NSInteger)buttonIndex {
    NSLog(@"buttonIndex = %@", @(buttonIndex));
}
#pragma clang diagnostic pop
#pragma mark - CYLPlusButtonSubclassing

//+ (UIViewController *)plusChildViewController {
//    UIViewController *plusChildViewController = [[UIViewController alloc] init];
//    plusChildViewController.view.backgroundColor = [UIColor redColor];
//    plusChildViewController.navigationItem.title = @"PlusChildViewController";
//    UIViewController *plusChildNavigationController = [[UINavigationController alloc]
//                                                   initWithRootViewController:plusChildViewController];
//    return plusChildNavigationController;
//}

+ (NSUInteger)indexOfPlusButtonInTabBar {
    return 2;
}

+ (BOOL)shouldSelectPlusChildViewController {
    BOOL isSelected = CYLExternPlusButton.selected;
    if (isSelected) {
//        HDLLogDebug("🔴类名与方法名：%@（在第%@行），描述：%@", @(__PRETTY_FUNCTION__), @(__LINE__), @"PlusButton is selected");
    } else {
//        HDLLogDebug("🔴类名与方法名：%@（在第%@行），描述：%@", @(__PRETTY_FUNCTION__), @(__LINE__), @"PlusButton is not selected");
    }
    return YES;
}

//+ (CGFloat)multiplierOfTabBarHeight:(CGFloat)tabBarHeight {
//    return 0.0;
//}

+ (CGFloat)constantOfPlusButtonCenterYOffsetForTabBarHeight:(CGFloat)tabBarHeight {
    return -10;
}

//+ (NSString *)tabBarContext {
//    return NSStringFromClass([self class]);
//}

@end
