//
//  NCHPopView.h
//  VLog
//
//  Created by szy on 2020/10/13.
//  Copyright © 2020 niuchao. All rights reserved.
//


#import <UIKit/UIKit.h>
#import "NCHPopViewProtocol.h"


#define NCHPopViewWK(object)  __weak typeof(object) wk_##object = object;
#define NCHPopViewSS(object)  __strong typeof(object) object = weak##object;


/** 显示动画样式 */
typedef NS_ENUM(NSInteger, NCHPopStyle) {
    NCHPopStyleNO = 0,                 // 默认 无动画
    NCHPopStyleScale,                  // 缩放 先放大 后恢复至原大小
    NCHPopStyleSmoothFromTop,          // 顶部 平滑淡入动画
    NCHPopStyleSmoothFromLeft,         // 左侧 平滑淡入动画
    NCHPopStyleSmoothFromBottom,       // 底部 平滑淡入动画
    NCHPopStyleSmoothFromRight,        // 右侧 平滑淡入动画
    NCHPopStyleSpringFromTop,          // 顶部 平滑淡入动画 带弹簧
    NCHPopStyleSpringFromLeft,         // 左侧 平滑淡入动画 带弹簧
    NCHPopStyleSpringFromBottom,       // 底部 平滑淡入动画 带弹簧
    NCHPopStyleSpringFromRight,        // 右侧 平滑淡入动画 带弹簧
    NCHPopStyleCardDropFromLeft,       // 顶部左侧 掉落动画
    NCHPopStyleCardDropFromRight,      // 顶部右侧 掉落动画
};
/** 消失动画样式 */
typedef NS_ENUM(NSInteger, NCHDismissStyle) {
    NCHDismissStyleNO = 0,               // 默认 无动画
    NCHDismissStyleScale,                // 缩放
    NCHDismissStyleSmoothToTop,          // 顶部 平滑淡出动画
    NCHDismissStyleSmoothToLeft,         // 左侧 平滑淡出动画
    NCHDismissStyleSmoothToBottom,       // 底部 平滑淡出动画
    NCHDismissStyleSmoothToRight,        // 右侧 平滑淡出动画
    NCHDismissStyleCardDropToLeft,       // 卡片从中间往左侧掉落
    NCHDismissStyleCardDropToRight,      // 卡片从中间往右侧掉落
    NCHDismissStyleCardDropToTop,        // 卡片从中间往顶部移动消失
};
/** 主动动画样式(开发中) */
typedef NS_ENUM(NSInteger, NCHActivityStyle) {
    NCHActivityStyleNO = 0,               /// 无动画
    NCHActivityStyleScale,                /// 缩放
    NCHActivityStyleShake,                /// 抖动
};
/**弹框位置 */
typedef NS_ENUM(NSInteger, NCHHemStyle) {
    NCHHemStyleCenter = 0,
    NCHHemStyleTop,    //贴顶
    NCHHemStyleLeft,   //贴左
    NCHHemStyleBottom, //贴底
    NCHHemStyleRight,  //贴右
};


NS_ASSUME_NONNULL_BEGIN

@interface NCHPopView : UIView

/** 代理 支持多代理 */
@property (nonatomic, weak) id<NCHPopViewProtocol> _Nullable delegate;
/** 标识 默认为空 */
@property (nonatomic,copy) NSString *_Nullable identifier;
/** 弹框容器 默认是app UIWindow 可指定view作为容器 */
@property (nonatomic,weak) UIView * _Nullable parentView;
/** 弹框位置 默认NCHHemStyleCenter */
@property (nonatomic, assign) NCHHemStyle hemStyle;
/** 显示时动画弹框样式 默认NCHPopStyleNO */
@property (nonatomic) NCHPopStyle popStyle;
/** 移除时动画弹框样式 默认NCHDismissStyleNO */
@property (nonatomic) NCHDismissStyle dismissStyle;
/** 显示时动画时长，>= 0。不设置则使用默认的动画时长 */
@property (nonatomic, assign) NSTimeInterval popDuration;
/** 隐藏时动画时长，>= 0。不设置则使用默认的动画时长 */
@property (nonatomic, assign) NSTimeInterval dismissDuration;
/** 弹窗水平方向(X)偏移量校准 默认0 */
@property (nonatomic, assign) CGFloat adjustX;
/** 弹窗垂直方向(Y)偏移量校准 默认0 */
@property (nonatomic, assign) CGFloat adjustY;
/** 背景颜色 默认rgb(0,0,0) 透明度0.3 */
@property (nonatomic,strong) UIColor * _Nullable bgColor;
/** 显示时背景的透明度，取值(0.0~1.0)，默认为0.3 */
@property (nonatomic, assign) CGFloat bgAlpha;
/** 是否隐藏背景 默认NO */
@property (nonatomic, assign) BOOL isHideBg;
/** 显示时点击背景是否移除弹框，默认为NO。 */
@property (nonatomic, assign) BOOL isClickBgDismiss;
/** 是否监听屏幕旋转，默认为YES */
@property (nonatomic, assign) BOOL isObserverScreenRotation;
/** 是否支持点击回馈 默认NO (暂时关闭) */
@property (nonatomic, assign) BOOL isClickFeedback;
/** 是否规避键盘 默认YES */
@property (nonatomic, assign) BOOL isAvoidKeyboard;
/** 弹框和键盘的距离 默认10 */
@property (nonatomic, assign) CGFloat avoidKeyboardSpace;
/** 显示多长时间 默认0 不会消失 */
@property (nonatomic, assign) NSTimeInterval showTime;

//************ 群组相关属性 ****************
/** 群组标识 统一给弹框编队 方便独立管理 默认为nil,统一全局处理 */
@property (nonatomic,strong) NSString * _Nullable groupId;
/** 是否堆叠 默认NO  如果是YES  priority优先级不生效*/
@property (nonatomic,assign) BOOL isStack;
/** 单显示 默认NO  只会显示优先级最高的popView   */
@property (nonatomic, assign) BOOL isSingle;
/** 优先级 范围0~1000 (默认0,遵循先进先出) isStack和isSingle为NO的时候生效 */
@property (nonatomic, assign) CGFloat priority;
//****************************************

/** 点击背景 */
@property (nullable, nonatomic, copy) void(^bgClickBlock)(void);
/** 长按背景 */
@property (nullable, nonatomic, copy) void(^bgLongPressBlock)(void);

//以下键盘弹出/收起 第三方键盘会多次回调(百度,搜狗测试得出), 原生键盘回调一次

/** 键盘将要弹出 */
@property (nullable, nonatomic, copy) void(^keyboardWillShowBlock)(void);
/** 键盘弹出完毕 */
@property (nullable, nonatomic, copy) void(^keyboardDidShowBlock)(void);
/** 键盘frame将要改变 */
@property (nullable, nonatomic, copy) void(^keyboardFrameWillChangeBlock)(CGRect beginFrame,CGRect endFrame,CGFloat duration);
/** 键盘frame改变完毕 */
@property (nullable, nonatomic, copy) void(^keyboardFrameDidChangeBlock)(CGRect beginFrame,CGRect endFrame,CGFloat duration);
/** 键盘将要收起 */
@property (nullable, nonatomic, copy) void(^keyboardWillHideBlock)(void);
/** 键盘收起完毕 */
@property (nullable, nonatomic, copy) void(^keyboardDidHideBlock)(void);

//************ 生命周期回调(Block) ************
/** 将要显示 回调 */
@property (nullable, nonatomic, copy) void(^popViewWillPopBlock)(void);
/** 已经显示完毕 回调 */
@property (nullable, nonatomic, copy) void(^popViewDidPopBlock)(void);
/** 将要开始移除 回调 */
@property (nullable, nonatomic, copy) void(^popViewWillDismissBlock)(void);
/** 已经移除完毕 回调 */
@property (nullable, nonatomic, copy) void(^popViewDidDismissBlock)(void);
/** 倒计时 回调 */
@property (nullable, nonatomic, copy) void(^popViewCountDownBlock)(NCHPopView *popView,NSTimeInterval timeInterval);
//********************************************


/*
   以下是构建方法
   customView: 已定义view
   popStyle: 弹出动画
   dismissStyle: 移除动画
   parentView: 弹框父容器
 */
+ (nullable instancetype)initWithCustomView:(UIView *_Nonnull)customView;

+ (nullable instancetype)initWithCustomView:(UIView *)customView
                                   popStyle:(NCHPopStyle)popStyle
                               dismissStyle:(NCHDismissStyle)dismissStyle;

+ (nullable instancetype)initWithCustomView:(UIView *)customView
                                 parentView:(UIView *_Nullable)parentView
                                   popStyle:(NCHPopStyle)popStyle


                               dismissStyle:(NCHDismissStyle)dismissStyle;
/*
  以下是弹出方法
  popStyle: 弹出动画 优先级大于全局的popStyle 局部起作用
  duration: 弹出时间 优先级大于全局的popDuration 局部起作用
*/
- (void)pop;
- (void)popWithStyle:(NCHPopStyle)popStyle;
- (void)popWithDuration:(NSTimeInterval)duration;
- (void)popWithStyle:(NCHPopStyle)popStyle duration:(NSTimeInterval)duration;


/*
  以下是弹出方法
  dismissStyle: 弹出动画 优先级大于全局的dismissStyle 局部起作用
  duration: 弹出时间 优先级大于全局的dismissDuration 局部起作用
*/
- (void)dismiss;
- (void)dismissWithStyle:(NCHDismissStyle)dismissStyle;
- (void)dismissWithDuration:(NSTimeInterval)duration;
- (void)dismissWithStyle:(NCHDismissStyle)dismissStyle duration:(NSTimeInterval)duration;


/** 删除指定代理 */
- (void)removeForDelegate:(id<NCHPopViewProtocol>)delegate;
/** 删除代理池 删除所有代理 */
- (void)removeAllDelegate;

@end


NS_ASSUME_NONNULL_END
