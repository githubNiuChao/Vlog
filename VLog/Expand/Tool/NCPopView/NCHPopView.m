//
//  NCHPopView.m
//  VLog
//
//  Created by szy on 2020/10/13.
//  Copyright © 2020 niuchao. All rights reserved.
//

#import "NCHPopView.h"
#import "UIView+NCHView.h"
#import "NCHPopViewManager.h"
#import "NCHTimer.h"
#import <objc/runtime.h>


//检查引用计数
//printf("Retain Count = %ld\n",CFGetRetainCount((__bridge CFTypeRef)(self)));

// 角度转弧度
#define DEGREES_TO_RADIANS(angle) ((angle) / 180.0 * M_PI)

@interface NCHPopViewBgView : UIButton

/** 是否隐藏背景 默认NO */
@property (nonatomic, assign) BOOL isHideBg;

@end

@implementation NCHPopViewBgView

- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event{
    UIView *hitView = [super hitTest:point withEvent:event];
    if(hitView == self && self.isHideBg){
        return nil;
    }
    return hitView;
}

@end

@interface NCHPopView () <UIGestureRecognizerDelegate>

/** 背景层 */
@property (nonatomic, strong) NCHPopViewBgView *backgroundView;
/** 自定义视图 */
@property (nonatomic, strong) UIView *customView;
/** 规避键盘偏移量 */
@property (nonatomic, assign) CGFloat avoidKeyboardOffset;
/** 是否弹出键盘 */
@property (nonatomic,assign,readonly) BOOL isShowKeyboard;
/** 是否加入了父容器 1.是 0.否*/
@property (nonatomic, assign) BOOL isAdd;
/** 代理池 */
@property (nonatomic,strong) NSMutableArray<id<NCHPopViewProtocol>> *delegateMarr;
/** 记录自定义view原始Y值 */
@property (nonatomic, assign) CGFloat customViewOriginY;


@end

@implementation NCHPopView


#pragma mark - ***** 初始化 *****

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self initSubViews];
    }
    return self;
}

- (void)initSubViews {
    //初始化配置
    _isClickBgDismiss = NO;
    _isObserverScreenRotation = YES;
    _bgAlpha = 0.25;
    _popStyle = NCHPopStyleNO;
    _dismissStyle = NCHDismissStyleNO;
    _popDuration = -0.1f;
    _dismissDuration = -0.1f;
    _hemStyle = NCHHemStyleCenter;
    _adjustX = 0;
    _adjustY = 0;
    _isClickFeedback = NO;
    _isAvoidKeyboard = YES;
    _avoidKeyboardSpace = 10;
    _bgColor = [UIColor blackColor];
    _identifier = @"";
    _isShowKeyboard = NO;
    _showTime = 0.0;
    _priority = 0;
    _isHideBg = NO;
    _isShowKeyboard = NO;
}

+ (nullable instancetype)initWithCustomView:(UIView *_Nonnull)customView {
    return [self initWithCustomView:customView popStyle:NCHPopStyleNO dismissStyle:NCHDismissStyleNO];
}


+ (nullable instancetype)initWithCustomView:(UIView *_Nonnull)customView
                                   popStyle:(NCHPopStyle)popStyle
                               dismissStyle:(NCHDismissStyle)dismissStyle {
    
    return [self initWithCustomView:customView
                         parentView:nil
                           popStyle:popStyle
                       dismissStyle:dismissStyle];
}

+ (nullable instancetype)initWithCustomView:(UIView *_Nonnull)customView
                                 parentView:(UIView *)parentView
                                   popStyle:(NCHPopStyle)popStyle
                               dismissStyle:(NCHDismissStyle)dismissStyle {
    // 检测自定义视图是否存在(check customView is exist)
    if (!customView) {
        return nil;
    }
    
    CGRect popViewFrame = CGRectZero;
    if (parentView) {
        popViewFrame =  parentView.bounds;
    }else {
        popViewFrame =  CGRectMake(0, 0, [[UIScreen mainScreen] bounds].size.width, [[UIScreen mainScreen] bounds].size.height);
    }
    
    NCHPopView *popView = [[NCHPopView alloc] initWithFrame:popViewFrame];
    popView.parentView = parentView?parentView:[UIApplication sharedApplication].keyWindow;
    popView.customView = customView;
    popView.backgroundView = [[NCHPopViewBgView alloc] initWithFrame:popView.bounds];
    popView.backgroundColor = [UIColor clearColor];
    popView.backgroundView.backgroundColor = [UIColor clearColor];
    popView.popStyle = popStyle;
    popView.dismissStyle = dismissStyle;
    
    [popView addSubview:popView.backgroundView];
    [popView.backgroundView addSubview:customView];
    
    
    //背景添加手势
//    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:popView action:@selector(popViewBgViewTap:)];
//    tap.delegate = popView;
//    [popView.backgroundView addGestureRecognizer:tap];
    
    [popView.backgroundView addTarget:popView action:@selector(popViewBgViewTap:) forControlEvents:UIControlEventTouchUpInside];;
    
    
//    UILongPressGestureRecognizer *customViewLP = [[UILongPressGestureRecognizer alloc] initWithTarget:popView action:@selector(bgLongPressEvent:)];
//    [popView.backgroundView addGestureRecognizer:customViewLP];
    
//    UITapGestureRecognizer *customViewTap = [[UITapGestureRecognizer alloc] initWithTarget:popView action:@selector(customViewClickEvent:)];
//    [popView.customView addGestureRecognizer:customViewTap];
    
    //键盘将要显示
    [[NSNotificationCenter defaultCenter] addObserver:popView selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    //键盘显示完毕
    [[NSNotificationCenter defaultCenter] addObserver:popView selector:@selector(keyboardDidShow:) name:UIKeyboardDidShowNotification object:nil];
    //键盘frame将要改变
    [[NSNotificationCenter defaultCenter] addObserver:popView selector:@selector(keyboardWillChangeFrame:) name:UIKeyboardWillChangeFrameNotification object:nil];
    //键盘frame改变完毕
    [[NSNotificationCenter defaultCenter] addObserver:popView selector:@selector(keyboardDidChangeFrame:) name:UIKeyboardDidChangeFrameNotification object:nil];
    //键盘将要收起
    [[NSNotificationCenter defaultCenter] addObserver:popView selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    //键盘收起完毕
    [[NSNotificationCenter defaultCenter] addObserver:popView selector:@selector(keyboardDidHide:) name:UIKeyboardDidHideNotification object:nil];
    //屏幕旋转
    [[NSNotificationCenter defaultCenter] addObserver:popView selector:@selector(statusBarOrientationChange:) name:UIApplicationDidChangeStatusBarOrientationNotification object:nil];
    
    //监听customView frame
    [popView.customView addObserver:popView forKeyPath:@"frame" options:NSKeyValueObservingOptionOld context:NULL];
    
    return popView;
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch {
    //判断如果点击的是tableView的cell，就把手势给关闭了
    NSLog(@"%@",[touch.view.superview isKindOfClass:[UICollectionViewCell class]]?@"YES":@"NO");
    if ([NSStringFromClass([touch.view class]) isEqualToString:@"UITableViewCellContentView"]) {
        return NO;//关闭手势
    }//否则手势存在
    
    
    return YES;
}

- (void)dealloc {
    
    [self.customView removeObserver:self forKeyPath:@"frame"];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
    [NCHPopViewManager removePopView:self];
    
    [self.delegateMarr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj respondsToSelector:@selector(NCH_PopViewDidDismissForPopView:)]) {
            [obj NCH_PopViewDidDismissForPopView:self];
        }
    }];
    
    if (self.popViewDidDismissBlock) {
        self.popViewDidDismissBlock();
    }
    
}

- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event{
    UIView *hitView = [super hitTest:point withEvent:event];
    if (hitView != self.customView) {
        if(hitView == self && self.isHideBg){
            return nil;
        }
    }
    return hitView;
}

#pragma mark - ***** 界面布局 *****

- (void)setCustomViewFrame {
    switch (self.hemStyle) {
        case NCHHemStyleTop ://贴顶
        {
            _customView.centerX = self.backgroundView.centerX+self.adjustX;
            _customView.y = self.adjustY;
        }
            break;
        case NCHHemStyleLeft ://贴左
        {
            _customView.x = self.adjustX;
            _customView.centerY = self.backgroundView.centerY+self.adjustY;
            
        }
            break;
        case NCHHemStyleBottom ://贴底
        {
            self.customView.centerX = self.backgroundView.centerX+self.adjustX;
            [self.customView layoutIfNeeded];
            _customView.y = self.backgroundView.height-self.customView.height+self.adjustY;
        }
            break;
        case NCHHemStyleRight ://贴右
        {
            _customView.x = self.backgroundView.width-self.customView.width+self.adjustX;
            _customView.centerY = self.backgroundView.centerY+self.adjustY;
        }
            break;
        default://居中
        {
            _customView.centerX = self.backgroundView.centerX+self.adjustX;
            _customView.centerY = self.backgroundView.centerY+self.adjustY;
        }
            break;
    }
    
}

#pragma mark - ***** setter 设置器/数据处理 *****

- (void)setHemStyle:(NCHHemStyle)hemStyle {
    _hemStyle = hemStyle;
    
}

- (void)setAdjustX:(CGFloat)adjustX {
    _adjustX = adjustX;
    [self setCustomViewFrame];
}

- (void)setAdjustY:(CGFloat)adjustY {
    _adjustY = adjustY;
    
    [self setCustomViewFrame];
    self.customViewOriginY = self.customView.y;
}

- (void)setIsObserverScreenRotation:(BOOL)isObserverScreenRotation {
    _isObserverScreenRotation = isObserverScreenRotation;
}

- (void)setBgAlpha:(CGFloat)bgAlpha {
    _bgAlpha = (bgAlpha <= 0.0f) ? 0.0f : ((bgAlpha > 1.0) ? 1.0 : bgAlpha);
    
}

- (void)setIsClickFeedback:(BOOL)isClickFeedback {
    _isClickFeedback = isClickFeedback;
}

- (void)setIsHideBg:(BOOL)isHideBg {
    _isHideBg = isHideBg;
    self.backgroundView.isHideBg = isHideBg;
    self.backgroundView.backgroundColor = [self getNewColorWith:self.bgColor alpha:0.0];
    
}

- (void)setShowTime:(NSTimeInterval)showTime {
    _showTime = showTime;
    
}

- (void)setDelegate:(id<NCHPopViewProtocol>)delegate {
    
    _delegate = delegate;
    if ([self.delegateMarr containsObject:delegate]) {
        return;
    }
    [self.delegateMarr addObject:delegate];
}

#pragma mark - ***** 公有api *****

#pragma mark - ***** pop 弹出 *****
- (void)pop {
    [self popWithStyle:self.popStyle duration:self.popDuration];
}

- (void)popWithStyle:(NCHPopStyle)popStyle {
    [self popWithStyle:popStyle duration:self.popDuration];

}

- (void)popWithDuration:(NSTimeInterval)duration {
    [self popWithStyle:self.popStyle duration:duration];
}

- (void)popWithStyle:(NCHPopStyle)popStyle duration:(NSTimeInterval)duration {
    [self popWithPopStyle:popStyle duration:duration isOutStack:NO];
}

- (void)popWithPopStyle:(NCHPopStyle)popStyle duration:(NSTimeInterval)duration isOutStack:(BOOL)isOutStack {
    
    [self setCustomViewFrame];
    
    self.customViewOriginY = self.customView.y;
    
    BOOL isPop = NO;
    
    if (self.isSingle) {//单显
        NSArray *popViewArr = [NCHPopViewManager getAllPopViewForPopView:self];
        for (id obj  in popViewArr) {//移除所有popView和移除定a时器
            NCHPopView *lastPopView;
            if ([obj isKindOfClass:[NSValue class]]) {
                NSValue *resObj = (NSValue *)obj;
                lastPopView  = resObj.nonretainedObjectValue;
            }else {
                lastPopView  = (NCHPopView *)obj;
            }
            [lastPopView dismissWithDismissStyle:NCHDismissStyleNO duration:0.2 isRemove:YES];
        }
        isPop = YES;
    }else {//多显
        if (!isOutStack) {//处理隐藏倒数第二个popView
            NSArray *popViewArr = [NCHPopViewManager getAllPopViewForPopView:self];
            if (popViewArr.count>=1) {
                id obj = popViewArr[popViewArr.count-1];
                NCHPopView *lastPopView;
                if ([obj isKindOfClass:[NSValue class]]) {
                    NSValue *resObj = (NSValue *)obj;
                    lastPopView  = resObj.nonretainedObjectValue;
                }else {
                    lastPopView  = (NCHPopView *)obj;
                }
                
                if (self.isStack) {//堆叠显示
                    isPop = YES;
                }else {//
                    if (self.priority >= lastPopView.priority) {//置顶显示
                        if (lastPopView.isShowKeyboard) {
                            [lastPopView endEditing:YES];
                        }
                        [lastPopView dismissWithDismissStyle:NCHDismissStyleNO duration:0.2 isRemove:NO];
                        isPop = YES;
                        
                    }else {//影藏显示
                        [NCHPopViewManager savePopView:self];
                        return;
                    }
                }
            }else {
                isPop = YES;
            }
        }
    }
    
    if (!isOutStack){
        [self.parentView addSubview:self];
    }
    
    if (!isOutStack){
        [self.delegateMarr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            //将要显示
            if ([obj respondsToSelector:@selector(NCH_PopViewWillPopForPopView:)]) {
                [obj NCH_PopViewWillPopForPopView:self];
            }
            
        }];
        
        if (self.popViewWillPopBlock) {
            self.popViewWillPopBlock();
        }
    }
    
    //动画处理
    [self popAnimationWithPopStyle:popStyle duration:duration];
    
    __weak typeof(self) ws = self;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(duration * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        if (!isOutStack){
            [self.delegateMarr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                //显示完毕
                if ([obj respondsToSelector:@selector(NCH_PopViewDidPopForPopView:)]) {
                    [obj NCH_PopViewDidPopForPopView:self];
                }
                
            }];
            
            if (ws.popViewDidPopBlock) {
                ws.popViewDidPopBlock();
            }
        }
        
        if (isPop){
            //计时任务
            [self startTimer];
        }
    });
    
    //保存popView
    if (!isOutStack) {
        [NCHPopViewManager savePopView:self];
    }
}

- (void)popAnimationWithPopStyle:(NCHPopStyle)popStyle duration:(NSTimeInterval)duration {
    
    
    __weak typeof(self) ws = self;
    NSTimeInterval defaultDuration = [self getPopDefaultDuration:popStyle];
    NSTimeInterval resDuration = (duration < 0.0f) ? defaultDuration : duration;
    if (popStyle == NCHPopStyleNO) {//无动画
        self.backgroundView.backgroundColor = [self getNewColorWith:self.bgColor alpha:0.0];
        self.customView.alpha = 0.0f;
        [UIView animateWithDuration:0.2 animations:^{
            self.backgroundView.backgroundColor =[self getNewColorWith:self.bgColor alpha:self.bgAlpha];
            self.customView.alpha = 1.0f;
        }];
    } else {//有动画
        
        //设置背景过渡动画
        self.backgroundView.backgroundColor = [self getNewColorWith:self.bgColor alpha:0.0];
        [UIView animateWithDuration:resDuration animations:^{
            ws.backgroundView.backgroundColor = [self getNewColorWith:self.bgColor alpha:self.bgAlpha];
        }];
        
        //自定义view过渡动画
        [self hanlePopAnimationWithDuration:resDuration*0.8 popStyle:popStyle];
    }
}

#pragma mark - ***** dismiss 移除 *****

- (void)dismiss {
    [self dismissWithStyle:self.dismissStyle duration:self.dismissDuration];
}

- (void)dismissWithStyle:(NCHDismissStyle)dismissStyle {
    [self dismissWithStyle:dismissStyle duration:self.dismissDuration];
}

- (void)dismissWithDuration:(NSTimeInterval)duration {
    [self dismissWithStyle:self.dismissStyle duration:duration];
}

- (void)dismissWithStyle:(NCHDismissStyle)dismissStyle duration:(NSTimeInterval)duration  {
    
    [self dismissWithDismissStyle:dismissStyle duration:duration isRemove:YES];
    
}

- (void)dismissWithDismissStyle:(NCHDismissStyle)dismissStyle
                       duration:(NSTimeInterval)duration
                       isRemove:(BOOL)isRemove {
    
    [self.delegateMarr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        if ([obj respondsToSelector:@selector(NCH_PopViewWillDismissForPopView:)]) {
            [obj NCH_PopViewWillDismissForPopView:self];
        }
        
    }];
    
    if (self.popViewWillDismissBlock) {
        self.popViewWillDismissBlock();
    }
    
    __block __weak typeof(self) ws = self;
    NSTimeInterval defaultDuration = [self getDismissDefaultDuration:dismissStyle];
    NSTimeInterval resDuration = (duration < 0.0f) ? defaultDuration : duration;
    [self dismissAnimationWithPopStyle:dismissStyle duration:resDuration];
    
    
    if (self.isSingle) {//单显
        
    }else {//多显
        
        if (isRemove && [NCHPopViewManager getAllPopViewForPopView:self].count>=2) {
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(resDuration * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                //  popView出栈
                if (!self.isStack) {
                    NSArray *popViewArr = [NCHPopViewManager getAllPopViewForPopView:self];
                    id obj = popViewArr[popViewArr.count-2];
                    NCHPopView *tPopView;
                    if ([obj isKindOfClass:[NSValue class]]) {
                        NSValue *resObj = (NSValue *)obj;
                        tPopView  = resObj.nonretainedObjectValue;
                        [tPopView popWithPopStyle:NCHPopStyleNO duration:0.25 isOutStack:YES];
                    }else {
                        tPopView  = (NCHPopView *)obj;
                        [tPopView.parentView addSubview:tPopView];
                        [NCHPopViewManager weakWithPopView:tPopView];
                        [tPopView popWithPopStyle:NCHPopStyleNO duration:0.25 isOutStack:YES];
                    }
                }
                
            });
        }
    }

    
    if (isRemove) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(resDuration * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [ws removeFromSuperview];
        });
    }
}

- (void)dismissAnimationWithPopStyle:(NCHDismissStyle)dismissStyle duration:(NSTimeInterval)duration {
    
    __block __weak typeof(self) ws = self;
    NSTimeInterval defaultDuration = [self getDismissDefaultDuration:dismissStyle];
    NSTimeInterval resDuration = (duration < 0.0f) ? defaultDuration : duration;
    if (dismissStyle == NCHPopStyleNO) {
        [UIView animateWithDuration:0.2 animations:^{
            ws.backgroundView.backgroundColor = [self getNewColorWith:self.bgColor alpha:0.0];
            ws.customView.alpha = 0.0f;
        }];
    } else {//有动画
        [UIView animateWithDuration:resDuration*0.8 animations:^{
            ws.backgroundView.backgroundColor = [self getNewColorWith:self.bgColor alpha:0.0];
        }];
        [self hanleDismissAnimationWithDuration:resDuration withDismissStyle:dismissStyle];
    }
}

#pragma mark - ***** 键盘弹出/收回 *****

- (void)keyboardWillShow:(NSNotification *)notification{
    
    _isShowKeyboard = YES;
    
    if (self.keyboardWillShowBlock) {
        self.keyboardWillShowBlock();
    }
    
    if (!self.isAvoidKeyboard) {
        return;
    }
    CGFloat customViewMaxY = self.customView.bottom+self.avoidKeyboardSpace;
    CGFloat duration = [notification.userInfo[UIKeyboardAnimationDurationUserInfoKey] floatValue];
    CGRect keyboardEedFrame = [notification.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    CGFloat keyboardMaxY = keyboardEedFrame.origin.y;
    self.isAvoidKeyboard = YES;
    self.avoidKeyboardOffset = customViewMaxY - keyboardMaxY;
    if (keyboardMaxY<customViewMaxY) {//键盘遮挡到弹框
        //执行动画
        [UIView animateWithDuration:duration animations:^{
            self.customView.y = self.customView.y - self.avoidKeyboardOffset;
        }];
    }
}

- (void)keyboardDidShow:(NSNotification *)notification{
    _isShowKeyboard = YES;
    if (self.keyboardDidShowBlock) {
        self.keyboardDidShowBlock();
    }
}

- (void)keyboardWillHide:(NSNotification *)notification{
    _isShowKeyboard = NO;
    
    if (self.keyboardWillHideBlock) {
        self.keyboardWillHideBlock();
    }
    
    if (!self.isAvoidKeyboard) {
        return;
    }
    
    CGFloat duration = [notification.userInfo[UIKeyboardAnimationDurationUserInfoKey] floatValue];
    [UIView animateWithDuration:duration animations:^{
        self.customView.y = self.customViewOriginY;
    }];
}

- (void)keyboardDidHide:(NSNotification *)notification{
    _isShowKeyboard = NO;
    if (self.keyboardDidHideBlock) {
        self.keyboardDidHideBlock();
    }
}

- (void)keyboardWillChangeFrame:(NSNotification *)notification{
    if (self.keyboardFrameWillChangeBlock) {
        CGRect keyboardBeginFrame = [notification.userInfo[UIKeyboardFrameBeginUserInfoKey] CGRectValue];
        CGRect keyboardEedFrame = [notification.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
        CGFloat duration = [notification.userInfo[UIKeyboardAnimationDurationUserInfoKey] floatValue];
        self.keyboardFrameWillChangeBlock(keyboardBeginFrame,keyboardEedFrame,duration);
    }
    
}

- (void)keyboardDidChangeFrame:(NSNotification *)notification{
    if (self.keyboardFrameDidChangeBlock) {
        CGRect keyboardBeginFrame = [notification.userInfo[UIKeyboardFrameBeginUserInfoKey] CGRectValue];
        CGRect keyboardEedFrame = [notification.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
        CGFloat duration = [notification.userInfo[UIKeyboardAnimationDurationUserInfoKey] floatValue];
        self.keyboardFrameDidChangeBlock(keyboardBeginFrame,keyboardEedFrame,duration);
    }
    
}

#pragma mark - ***** other 其他 *****

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    if([keyPath isEqualToString:@"frame"]) {
        CGRect newFrame = CGRectNull;
        CGRect oldFrame = CGRectNull;
        if([object valueForKeyPath:keyPath] != [NSNull null]) {
            //此处为获取新的frame
            newFrame = [[object valueForKeyPath:keyPath] CGRectValue];
            oldFrame = [[change valueForKeyPath:@"old"] CGRectValue];
            if (!CGSizeEqualToSize(newFrame.size, oldFrame.size)) {
                [self setCustomViewFrame];
            }
        }
    }
}

//按钮的压下事件 按钮缩小
- (void)bgLongPressEvent:(UIGestureRecognizer *)ges {
    
    //    [self.delegateMarr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
    //
    //        if ([obj respondsToSelector:@selector(NCH_PopViewBgLongPressForPopView:)]) {
    //            [obj NCH_PopViewBgLongPressForPopView:self];
    //        }
    //
    //    }];
    
    if (self.bgLongPressBlock) {
        self.bgLongPressBlock();
    }
    
    //    switch (ges.state) {
    //        case UIGestureRecognizerStateBegan:
    //        {
    //            CGFloat scale = 0.95;
    //            [UIView animateWithDuration:0.35 animations:^{
    //                ges.view.transform = CGAffineTransformMakeScale(scale, scale);
    //            }];
    //        }
    //            break;
    //        case UIGestureRecognizerStateEnded:
    //        case UIGestureRecognizerStateCancelled:
    //        {
    //            [UIView animateWithDuration:0.35 animations:^{
    //                ges.view.transform = CGAffineTransformMakeScale(1.0, 1.0);
    //            } completion:^(BOOL finished) {
    //            }];
    //        }
    //            break;
    //
    //        default:
    //            break;
    //    }
}

- (void)customViewClickEvent:(UIGestureRecognizer *)ges {
    
    if (self.isClickFeedback) {
        CGFloat scale = 0.95;
        
        [UIView animateWithDuration:0.25 animations:^{
            ges.view.transform = CGAffineTransformMakeScale(scale, scale);
        } completion:^(BOOL finished) {
            [UIView animateWithDuration:0.25 animations:^{
                ges.view.transform = CGAffineTransformMakeScale(1.0, 1.0);
            } completion:^(BOOL finished) {
                
            }];
        }];
    }
    
    
    
}



- (void)popViewBgViewTap:(UIButton *)tap {
    
    //    [self.delegateMarr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
    //
    //        if ([obj respondsToSelector:@selector(NCH_PopViewBgClickForPopView:)]) {
    //            [obj NCH_PopViewBgClickForPopView:self];
    //        }
    //
    //    }];
    
    
    if (self.bgClickBlock) {
        if (self.isShowKeyboard) {
            [self endEditing:YES];
        }
        self.bgClickBlock();
    }
    
    if (_isClickBgDismiss) {
        [self dismiss];
    }
}


- (void)hanlePopAnimationWithDuration:(NSTimeInterval)duration
                             popStyle:(NCHPopStyle)popStyle {
    
    self.alpha = 0;
    
    [UIView animateWithDuration:duration*0.5 animations:^{
        self.alpha = 1;
    }];
    
    
    __weak typeof(self) ws = self;
    switch (popStyle) {
        case NCHPopStyleScale:// < 缩放动画，先放大，后恢复至原大小
        {
            [self animationWithLayer:_customView.layer duration:((0.3*duration)/0.7) values:@[@0.0, @1.2, @1.0]]; // 另外一组动画值(the other animation values) @[@0.0, @1.2, @0.9, @1.0]
        }
            break;
        case NCHPopStyleSmoothFromTop:
        case NCHPopStyleSmoothFromBottom:
        case NCHPopStyleSmoothFromLeft:
        case NCHPopStyleSmoothFromRight:
        case NCHPopStyleSpringFromTop:
        case NCHPopStyleSpringFromLeft:
        case NCHPopStyleSpringFromBottom:
        case NCHPopStyleSpringFromRight:
        {
            CGPoint startPosition = self.customView.layer.position;
            if (popStyle == NCHPopStyleSmoothFromTop||popStyle == NCHPopStyleSpringFromTop) {
                self.customView.layer.position = CGPointMake(startPosition.x, -_customView.height*0.5);
            } else if (popStyle == NCHPopStyleSmoothFromLeft||popStyle == NCHPopStyleSpringFromLeft) {
                self.customView.layer.position = CGPointMake(-_customView.width*0.5, startPosition.y);
            } else if (popStyle == NCHPopStyleSmoothFromBottom||popStyle == NCHPopStyleSpringFromBottom) {
                self.customView.layer.position = CGPointMake(startPosition.x, CGRectGetMaxY(self.frame) + self.customView.height*0.5);
            } else {
                self.customView.layer.position = CGPointMake(CGRectGetMaxX(self.frame) + self.customView.width*0.5 , startPosition.y);
            }
            CGFloat damping = 1.0;
            if (popStyle == NCHPopStyleSpringFromTop||
                popStyle == NCHPopStyleSpringFromLeft||
                popStyle == NCHPopStyleSpringFromBottom||
                popStyle == NCHPopStyleSpringFromRight) {
                damping = 0.65;
            }
            
            [UIView animateWithDuration:duration delay:0 usingSpringWithDamping:damping initialSpringVelocity:1.0 options:UIViewAnimationOptionCurveEaseOut animations:^{
                ws.customView.layer.position = startPosition;
            } completion:nil];
        }
            break;
        case NCHPopStyleCardDropFromLeft:
        case NCHPopStyleCardDropFromRight:
        {
            CGPoint startPosition = self.customView.layer.position;
            if (popStyle == NCHPopStyleCardDropFromLeft) {
                self.customView.layer.position = CGPointMake(startPosition.x * 1.0, -_customView.height*0.5);
                self.customView.transform = CGAffineTransformMakeRotation(DEGREES_TO_RADIANS(15.0));
            } else {
                self.customView.layer.position = CGPointMake(startPosition.x * 1.0, -_customView.height*0.5);
                self.customView.transform = CGAffineTransformMakeRotation(DEGREES_TO_RADIANS(-15.0));
            }
            
            [UIView animateWithDuration:duration delay:0 usingSpringWithDamping:0.75 initialSpringVelocity:1.0 options:UIViewAnimationOptionCurveEaseIn animations:^{
                ws.customView.layer.position = startPosition;
            } completion:nil];
            
            [UIView animateWithDuration:duration*0.6 animations:^{
                ws.customView.layer.transform = CATransform3DMakeRotation(DEGREES_TO_RADIANS((popStyle == NCHPopStyleCardDropFromRight) ? 5.5 : -5.5), 0, 0, 0);
            } completion:^(BOOL finished) {
                [UIView animateWithDuration:duration*0.2 animations:^{
                    ws.customView.transform = CGAffineTransformMakeRotation(DEGREES_TO_RADIANS((popStyle == NCHPopStyleCardDropFromRight) ? -1.0 : 1.0));
                } completion:^(BOOL finished) {
                    [UIView animateWithDuration:duration*0.2 animations:^{
                        ws.customView.transform = CGAffineTransformMakeRotation(0.0);
                    } completion:nil];
                }];
            }];
        }
            break;
            
        default:
            break;
    }
}

- (void)hanleDismissAnimationWithDuration:(NSTimeInterval)duration
                         withDismissStyle:(NCHDismissStyle)dismissStyle {
    
    [UIView animateWithDuration:duration*0.8 animations:^{
        self.alpha = 0;
    }];
    
    __weak typeof(self) ws = self;
    switch (dismissStyle) {
        case NCHDismissStyleScale:
        {
            [self animationWithLayer:self.customView.layer duration:((0.2*duration)/0.8) values:@[@1.0, @0.66, @0.33, @0.01]];
        }
            break;
        case NCHDismissStyleSmoothToTop:
        case NCHDismissStyleSmoothToBottom:
        case NCHDismissStyleSmoothToLeft:
        case NCHDismissStyleSmoothToRight:
        {
            CGPoint startPosition = self.customView.layer.position;
            CGPoint endPosition = self.customView.layer.position;
            if (dismissStyle == NCHDismissStyleSmoothToTop) {
                endPosition = CGPointMake(startPosition.x, -(_customView.height*0.5));
            } else if (dismissStyle == NCHDismissStyleSmoothToBottom) {
                endPosition = CGPointMake(startPosition.x, CGRectGetMaxY(self.frame) + _customView.height*0.5);
            } else if (dismissStyle == NCHDismissStyleSmoothToLeft) {
                endPosition = CGPointMake(-_customView.width*0.5, startPosition.y);
            } else {
                endPosition = CGPointMake(CGRectGetMaxX(self.frame) + _customView.width*0.5, startPosition.y);
            }
            
            [UIView animateWithDuration:duration delay:0 usingSpringWithDamping:1.0 initialSpringVelocity:1.0 options:UIViewAnimationOptionCurveEaseOut animations:^{
                ws.customView.layer.position = endPosition;
            } completion:nil];
        }
            break;
        case NCHDismissStyleCardDropToLeft:
        case NCHDismissStyleCardDropToRight:
        {
            CGPoint startPosition = self.customView.layer.position;
            BOOL isLandscape = UIInterfaceOrientationIsLandscape([UIApplication sharedApplication].statusBarOrientation);
            __block CGFloat rotateEndY = 0.0f;
            [UIView animateWithDuration:duration delay:0 usingSpringWithDamping:0.5 initialSpringVelocity:1.0 options:UIViewAnimationOptionCurveEaseIn animations:^{
                if (dismissStyle == NCHDismissStyleCardDropToLeft) {
                    ws.customView.transform = CGAffineTransformMakeRotation(M_1_PI * 0.75);
                    if (isLandscape) rotateEndY = fabs(ws.customView.frame.origin.y);
                    ws.customView.layer.position = CGPointMake(startPosition.x, CGRectGetMaxY(ws.frame) + startPosition.y + rotateEndY);
                } else {
                    ws.customView.transform = CGAffineTransformMakeRotation(-M_1_PI * 0.75);
                    if (isLandscape) rotateEndY = fabs(ws.customView.frame.origin.y);
                    ws.customView.layer.position = CGPointMake(startPosition.x * 1.25, CGRectGetMaxY(ws.frame) + startPosition.y + rotateEndY);
                }
            } completion:nil];
        }
            break;
        case NCHDismissStyleCardDropToTop:
        {
            CGPoint startPosition = self.customView.layer.position;
            CGPoint endPosition = CGPointMake(startPosition.x, -startPosition.y);
            [UIView animateWithDuration:duration*0.2 animations:^{
                ws.customView.layer.position = CGPointMake(startPosition.x, startPosition.y + 50.0f);
            } completion:^(BOOL finished) {
                [UIView animateWithDuration:duration*0.8 animations:^{
                    ws.customView.layer.position = endPosition;
                } completion:nil];
            }];
        }
            break;
        default:
            break;
    }
}

- (NSTimeInterval)getPopDefaultDuration:(NCHPopStyle)popStyle {
    NSTimeInterval defaultDuration = 0.0f;
    if (popStyle == NCHPopStyleNO) {
        defaultDuration = 0.2f;
    } else if (popStyle == NCHPopStyleScale) {
        defaultDuration = 0.3f;
    } else if (popStyle == NCHPopStyleSmoothFromTop ||
               popStyle == NCHPopStyleSmoothFromLeft ||
               popStyle == NCHPopStyleSmoothFromBottom ||
               popStyle == NCHPopStyleSmoothFromRight ||
               popStyle == NCHPopStyleSpringFromTop ||
               popStyle == NCHPopStyleSpringFromLeft ||
               popStyle == NCHPopStyleSpringFromBottom ||
               popStyle == NCHPopStyleSpringFromRight ||
               popStyle == NCHPopStyleCardDropFromLeft ||
               popStyle == NCHPopStyleCardDropFromRight) {
        defaultDuration = 0.5f;
    }
    return defaultDuration;
}

- (NSTimeInterval)getDismissDefaultDuration:(NCHDismissStyle)dismissStyle {
    NSTimeInterval defaultDuration = 0.0f;
    if (dismissStyle == NCHDismissStyleNO) {
        defaultDuration = 0.25f;
    } else if (dismissStyle == NCHDismissStyleScale) {
        defaultDuration = 0.25f;
    } else if (dismissStyle == NCHDismissStyleSmoothToTop ||
               dismissStyle == NCHDismissStyleSmoothToBottom ||
               dismissStyle == NCHDismissStyleSmoothToLeft ||
               dismissStyle == NCHDismissStyleSmoothToRight ||
               dismissStyle == NCHDismissStyleCardDropToLeft ||
               dismissStyle == NCHDismissStyleCardDropToRight ||
               dismissStyle == NCHDismissStyleCardDropToTop) {
        defaultDuration = 1.0f;
    }
    return defaultDuration;
}

- (void)animationWithLayer:(CALayer *)layer duration:(CGFloat)duration values:(NSArray *)values {
    CAKeyframeAnimation *KFAnimation = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
    KFAnimation.duration = duration;
    KFAnimation.removedOnCompletion = NO;
    KFAnimation.fillMode = kCAFillModeForwards;
    //    KFAnimation.delegate = self;//造成强应用 popView释放不了
    NSMutableArray *valueArr = [NSMutableArray arrayWithCapacity:values.count];
    for (NSUInteger i = 0; i<values.count; i++) {
        CGFloat scaleValue = [values[i] floatValue];
        [valueArr addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(scaleValue, scaleValue, scaleValue)]];
    }
    KFAnimation.values = valueArr;
    KFAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
    
    [layer addAnimation:KFAnimation forKey:nil];
}

- (UIColor *)NCH_BlackWithAlpha: (CGFloat)alpha {
    return [UIColor colorWithRed:0 green:0 blue:0 alpha:alpha];
}

// 改变UIColor的Alpha
- (UIColor *)getNewColorWith:(UIColor *)color alpha:(CGFloat)alpha {
    
    if (self.isHideBg) {
        return UIColor.clearColor;
    }
    
    CGFloat red = 0.0;
    CGFloat green = 0.0;
    CGFloat blue = 0.0;
    CGFloat resAlpha = 0.0;
    [color getRed:&red green:&green blue:&blue alpha:&resAlpha];
    UIColor *newColor = [UIColor colorWithRed:red green:green blue:blue alpha:alpha];
    return newColor;
}

- (void)startTimer {
    if (self.showTime>0) {
        __weak typeof(self) ws = self;
        NSString *idStr = [NSString stringWithFormat:@"NCHPopView_%p",self];
        [NCHTimer addMinuteTimerForTime:self.showTime identifier:idStr handle:^(NSString * _Nonnull day, NSString * _Nonnull hour, NSString * _Nonnull minute, NSString * _Nonnull second, NSString * _Nonnull ms) {
            
            if (ws.popViewCountDownBlock) {
                ws.popViewCountDownBlock(ws, [second doubleValue]);
            }
            [self.delegateMarr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                if ([obj respondsToSelector:@selector(NCH_PopViewCountDownForPopView:forCountDown:)]) {
                    [obj NCH_PopViewCountDownForPopView:self forCountDown:[second doubleValue]];
                }
            }];
        } finish:^(NSString * _Nonnull identifier) {
            [self.delegateMarr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                if ([obj respondsToSelector:@selector(NCH_PopViewCountDownFinishForPopView:)]) {
                    [obj NCH_PopViewCountDownFinishForPopView:ws];
                }
                
            }];
            [self dismiss];
            
        } pause:^(NSString * _Nonnull identifier) {
            
        }];
        
    }
}

/** 删除指定代理 */
- (void)removeForDelegate:(id<NCHPopViewProtocol>)delegate {
    if (delegate) {
        if ([self.delegateMarr containsObject:delegate]) {
            [self.delegateMarr removeObject:delegate];
            if (self.delegateMarr.count<=0) {
                self.delegate = nil;
            }
        }
    }
}
/** 删除代理池 删除所有代理 */
- (void)removeAllDelegate {
    if (self.delegateMarr.count>0) {
        [self.delegateMarr removeAllObjects];
        self.delegate = nil;
    }
}

#pragma mark - ***** 横竖屏改变 *****

- (void)statusBarOrientationChange:(NSNotification *)notification {
    if (self.isObserverScreenRotation) {
        CGRect originRect = self.customView.frame;
        self.frame = CGRectMake(0, 0, [[UIScreen mainScreen] bounds].size.width, [[UIScreen mainScreen] bounds].size.height);
        self.backgroundView.frame = self.bounds;
        self.customView.frame = originRect;
        [self setCustomViewFrame];
    }
}

#pragma mark - ***** 懒加载 *****

- (NSMutableArray<id<NCHPopViewProtocol>> *)delegateMarr {
    if(_delegateMarr) return _delegateMarr;
    _delegateMarr = [NSMutableArray array];
    return _delegateMarr;
}

@end

