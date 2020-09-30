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
//- (BOOL)NCHNavigationIsHideBottomLine:(NCHNavigationBar *)navigationBar
//{
//    return NO;
//}

/** 导航条的高度 */
- (CGFloat)NCHNavigationHeight:(NCHNavigationBar *)navigationBar {
    return [UIApplication sharedApplication].statusBarFrame.size.height + 44.0;
}


/** 导航条的左边的 view */
//- (UIView *)NCHNavigationBarLeftView:(NCHNavigationBar *)navigationBar
//{
//
//}
/** 导航条右边的 view */
//- (UIView *)NCHNavigationBarRightView:(NCHNavigationBar *)navigationBar
//{
//
//}
/** 导航条中间的 View */
//- (UIView *)NCHNavigationBarTitleView:(NCHNavigationBar *)navigationBar
//{
//
//}
/** 导航条左边的按钮 */
//- (UIImage *)NCHNavigationBarLeftButtonImage:(UIButton *)leftButton navigationBar:(NCHNavigationBar *)navigationBar
//{
//
//}
/** 导航条右边的按钮 */
//- (UIImage *)NCHNavigationBarRightButtonImage:(UIButton *)rightButton navigationBar:(NCHNavigationBar *)navigationBar
//{
//
//}

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

//
//- (NCHNavigationBar *)jk_navgationBar {
//    // 父类控制器必须是导航控制器
//    if(!_jk_navgationBar && [self.parentViewController isKindOfClass:[UINavigationController class]])
//    {
//        NCHNavigationBar *navigationBar = [[NCHNavigationBar alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 0)];
//        [self.view addSubview:navigationBar];
//        _jk_navgationBar = navigationBar;
//
//        navigationBar.dataSource = self;
//        navigationBar.NCHDelegate = self;
//        navigationBar.hidden = ![self navUIBaseViewControllerIsNeedNavBar:self];
//    }
//    return _jk_navgationBar;
//}




- (void)setTitle:(NSString *)title {
    [super setTitle:title];
//    self.jk_navgationBar.title = [self changeTitle:title];
}

@end






