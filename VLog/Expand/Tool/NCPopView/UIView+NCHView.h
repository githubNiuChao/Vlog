//
//  UIView+NCHView.h
//  VLog
//
//  Created by szy on 2020/10/13.
//  Copyright © 2020 niuchao. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
    NCHBorderTypeTop,
    NCHBorderTypeLeft,
    NCHBorderTypeRight,
    NCHBorderTypeBottom
} NCHBorderType;



@interface UIView (NCHView)

/** 获取/设置view的x坐标 */
@property (nonatomic, assign) CGFloat x;
/** 获取/设置view的x坐标 */
@property (nonatomic, assign) CGFloat y;
/** 获取/设置view的x坐标 */
@property (nonatomic, assign) CGFloat width;
/** 获取/设置view的x坐标 */
@property (nonatomic, assign) CGFloat height;
/** 获取/设置view的x坐标 */
@property (nonatomic, assign) CGFloat centerX;
/** 获取/设置view的x坐标 */
@property (nonatomic, assign) CGFloat centerY;
/** 获取/设置view的x坐标 */
@property (nonatomic, assign) CGFloat top;
/** 获取/设置view的左边坐标 */
@property (nonatomic, assign) CGFloat left;
/** 获取/设置view的底部坐标Y */
@property (nonatomic, assign) CGFloat bottom;
/** 获取/设置view的右边坐标 */
@property (nonatomic, assign) CGFloat right;
/** 获取/设置view的size */
@property (nonatomic, assign) CGSize size;


/** 屏幕大小 */
CGSize NCHScreenSize();
/** 屏幕宽度 */
CGFloat NCHScreenWidth();
/** 屏幕高度 */
CGFloat NCHScreenHeight();
/** 屏幕bounds */
CGRect NCHScreenBounds();
/** 获取相对屏幕的宽度 */
CGFloat NCHAutoWidth(CGFloat width);
/** 获取相对屏幕的高度 */
CGFloat NCHAutoHeight(CGFloat height);
/** 获取相对指定view的宽度 */
CGFloat NCHAutoWidthForView(CGFloat width,UIView *tagView);
/** 获取相对指定view的高度 */
CGFloat NCHAutoHeightForView(CGFloat height,UIView *tagView);

static inline CGSize QTSizeMake(CGFloat width, CGFloat height);
static inline CGPoint QTPointMake(CGFloat x, CGFloat y);
static inline CGRect QTRectMake(CGFloat x, CGFloat y, CGFloat width, CGFloat height);

/** 是否是苹果X */
BOOL NCH_IsIphoneX();
/** 是否是苹果XR */
BOOL NCH_IsIphoneXR();
/** 是否是苹果XS */
BOOL NCH_IsIphoneXS();
/** 是否是苹果XS_Max */
BOOL NCH_IsIphoneXS_Max();
/** 是否是苹果X系列(刘海屏系列) */
BOOL NCH_IsIphoneX_ALL();
/** 状态栏高度 X:44 非X:20 */
CGFloat NCHStatusBarHeight();
/** 导航栏高度 X:88 非X:64 */
CGFloat NCHNavBarHeight();
/** 底部导航栏高度 X:83 非X:49 */
CGFloat NCHTabBarHeight();
/** 状态栏高度 X:34 非X:0 */
CGFloat NCHTabBarBottomMargin();
/** 底部贴边控件高度 */
CGFloat NCHBottomHemViewHeight(CGFloat height);
/** 底部控件下间距 (间距小于20使用) */
CGFloat NCHBottomHemViewMargin(CGFloat margin);





/** 根据nib文件转UIView对象 */
+ (instancetype)getNibView:(NSString *)nibName;
/** 设置圆角 */
- (void)NCH_RoundCorners:(UIRectCorner)corners radius:(CGFloat)radius;
/** 截屏生成图片 */
- (nullable UIImage *)NCH_SnapshotImage;
/** 获取当前控制器 */
- (UIViewController *)getCurrVc;
/**
 Create a snapshot PDF of the complete view hierarchy.
 This method should be called in main thread.
 */
- (nullable NSData *)snapshotPDF;
/**
 Remove all subviews.
 
 @warning Never call this method inside your view's drawRect: method.
 */
- (void)removeAllSubviews;
/**  设置阴影 可以指定位置 方向 */
- (void) makeInsetShadow;
- (void) makeInsetShadowWithRadius:(float)radius Alpha:(float)alpha;
- (void) makeInsetShadowWithRadius:(float)radius Color:(nullable UIColor *)color Directions:(nullable NSArray *)directions;


/** 添加多边框 可设置颜色 大小 方向 */
- (void)addBorderWithColor:(UIColor *)color
                      size:(CGFloat)size
               borderTypes:(NSArray *)types;
/** 添加单边框 可设置颜色 大小 方向 */
- (void)addBorderLayerWithColor:(UIColor *)color
                           size:(CGFloat)size
                     borderType:(NCHBorderType)boderType;



@end
