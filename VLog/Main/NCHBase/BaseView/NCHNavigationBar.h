//
//  NCHNavigationBar.h
//  VLog
//
//  Created by szy on 2020/9/12.
//  Copyright © 2020 niuchao. All rights reserved.
//


#import <UIKit/UIKit.h>


@class NCHNavigationBar;
// 主要处理导航条
@protocol  NCHNavigationBarDataSource<NSObject>

@optional

/**头部标题*/
- (NSMutableAttributedString*)NCHNavigationBarTitle:(NCHNavigationBar *)navigationBar;

/** 背景图片 */
- (UIImage *)NCHNavigationBarBackgroundImage:(NCHNavigationBar *)navigationBar;
 /** 背景色 */
- (UIColor *)NCHNavigationBackgroundColor:(NCHNavigationBar *)navigationBar;
/** 是否显示底部黑线 */
- (BOOL)NCHNavigationIsHideBottomLine:(NCHNavigationBar *)navigationBar;
/** 导航条的高度 */
- (CGFloat)NCHNavigationHeight:(NCHNavigationBar *)navigationBar;


/** 导航条的左边的 view */
- (UIView *)NCHNavigationBarLeftView:(NCHNavigationBar *)navigationBar;
/** 导航条右边的 view */
- (UIView *)NCHNavigationBarRightView:(NCHNavigationBar *)navigationBar;
/** 导航条中间的 View */
- (UIView *)NCHNavigationBarTitleView:(NCHNavigationBar *)navigationBar;
/** 导航条左边的按钮 */
- (UIImage *)NCHNavigationBarLeftButtonImage:(UIButton *)leftButton navigationBar:(NCHNavigationBar *)navigationBar;
/** 导航条右边的按钮 */
- (UIImage *)NCHNavigationBarRightButtonImage:(UIButton *)rightButton navigationBar:(NCHNavigationBar *)navigationBar;
@end


@protocol NCHNavigationBarDelegate <NSObject>

@optional
/** 左边的按钮的点击 */
-(void)leftButtonEvent:(UIButton *)sender navigationBar:(NCHNavigationBar *)navigationBar;
/** 右边的按钮的点击 */
-(void)rightButtonEvent:(UIButton *)sender navigationBar:(NCHNavigationBar *)navigationBar;
/** 中间如果是 label 就会有点击 */
-(void)titleClickEvent:(UILabel *)sender navigationBar:(NCHNavigationBar *)navigationBar;
@end


@interface NCHNavigationBar : UIView

/** 底部的黑线 */
@property (weak, nonatomic) UIView *bottomBlackLineView;

/** <#digest#> */
@property (weak, nonatomic) UIView *titleView;

/** <#digest#> */
@property (weak, nonatomic) UIView *leftView;

/** <#digest#> */
@property (weak, nonatomic) UIView *rightView;

/** <#digest#> */
@property (nonatomic, copy) NSMutableAttributedString *title;

/** <#digest#> */
@property (weak, nonatomic) id<NCHNavigationBarDataSource> dataSource;

/** <#digest#> */
@property (weak, nonatomic) id<NCHNavigationBarDelegate> NCHDelegate;

/** <#digest#> */
@property (weak, nonatomic) UIImage *backgroundImage;

@end
