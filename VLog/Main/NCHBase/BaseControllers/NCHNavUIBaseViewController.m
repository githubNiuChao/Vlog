//
//  NCHBaseViewController.m
//  PLMMPRJK
//
//  Created by NCH on 2017/3/29.
//  Copyright © 2017年 GoMePrjk. All rights reserved.
//

#import "NCHNavUIBaseViewController.h"
#import "NCHNavigationBar.h"
#import "NSObject+YYAddForKVO.h"


@implementation NCHNavUIBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    NCWeakSelf(self);
    [self.navigationItem addObserverBlockForKeyPath:NCKEY_PATH(self.navigationItem, title) block:^(id  _Nonnull obj, id  _Nonnull oldVal, NSString  *_Nonnull newVal) {
        if (newVal.length > 0 && ![newVal isEqualToString:oldVal]) {
            weakself.title = newVal;
        }
    }];
}


#pragma mark - 生命周期
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    
//    self.jk_navgationBar.jk_width = self.view.jk_width;
//    [self.view bringSubviewToFront:self.jk_navgationBar];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}

- (void)dealloc {
    [self.navigationItem removeObserverBlocksForKeyPath:NCKEY_PATH(self.navigationItem, title)];
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleDefault;
}

- (BOOL)prefersStatusBarHidden {
    return NO;
}

#pragma mark - DataSource
- (BOOL)navUIBaseViewControllerIsNeedNavBar:(NCHNavUIBaseViewController *)navUIBaseViewController {
    return YES;
}

/**头部标题*/
- (NSMutableAttributedString*)NCHNavigationBarTitle:(NCHNavigationBar *)navigationBar {
    return [self changeTitle:self.title ?: self.navigationItem.title];
}

/** 背景图片 */
//- (UIImage *)NCHNavigationBarBackgroundImage:(NCHNavigationBar *)navigationBar
//{
//
//}

/** 背景色 */
- (UIColor *)NCHNavigationBackgroundColor:(NCHNavigationBar *)navigationBar {
    return [UIColor whiteColor];
}

/** 是否显示底部黑线 */
- (BOOL)NCHNavigationIsHideBottomLine:(NCHNavigationBar *)navigationBar
{
    return NO;
}

/** 导航条的高度 */
- (CGFloat)NCHNavigationHeight:(NCHNavigationBar *)navigationBar {
    return [UIApplication sharedApplication].statusBarFrame.size.height + 44.0;
}


#pragma mark - Delegate
/** 左边的按钮的点击 */
-(void)leftButtonEvent:(UIButton *)sender navigationBar:(NCHNavigationBar *)navigationBar {
    NSLog(@"%s", __func__);
}
/** 右边的按钮的点击 */
-(void)rightButtonEvent:(UIButton *)sender navigationBar:(NCHNavigationBar *)navigationBar {
    NSLog(@"%s", __func__);
}
/** 中间如果是 label 就会有点击 */
-(void)titleClickEvent:(UILabel *)sender navigationBar:(NCHNavigationBar *)navigationBar {
    NSLog(@"%s", __func__);
}


#pragma mark 自定义代码

- (NSMutableAttributedString *)changeTitle:(NSString *)curTitle
{
    NSMutableAttributedString *title = [[NSMutableAttributedString alloc] initWithString:curTitle ?: @""];
    [title addAttribute:NSForegroundColorAttributeName value:[UIColor blackColor] range:NSMakeRange(0, title.length)];
    [title addAttribute:NSFontAttributeName value:[UIFont boldSystemFontOfSize:17] range:NSMakeRange(0, title.length)];
    return title;
}

@end






