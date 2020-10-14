//
//  NCHPopViewProtocol.h
//  VLog
//
//  Created by szy on 2020/10/13.
//  Copyright © 2020 niuchao. All rights reserved.
//

#import <Foundation/Foundation.h>
@class NCHPopView;

NS_ASSUME_NONNULL_BEGIN

@protocol NCHPopViewProtocol <NSObject>


/** 点击弹框 回调 */
- (void)NCH_PopViewBgClickForPopView:(NCHPopView *)popView;
/** 长按弹框 回调 */
- (void)NCH_PopViewBgLongPressForPopView:(NCHPopView *)popView;




// ****** 生命周期 ******
/** 将要显示 */
- (void)NCH_PopViewWillPopForPopView:(NCHPopView *)popView;
/** 已经显示完毕 */
- (void)NCH_PopViewDidPopForPopView:(NCHPopView *)popView;
/** 倒计时进行中 timeInterval:时长  */
- (void)NCH_PopViewCountDownForPopView:(NCHPopView *)popView forCountDown:(NSTimeInterval)timeInterval;
/** 倒计时倒计时完成  */
- (void)NCH_PopViewCountDownFinishForPopView:(NCHPopView *)popView;
/** 将要开始移除 */
- (void)NCH_PopViewWillDismissForPopView:(NCHPopView *)popView;
/** 已经移除完毕 */
- (void)NCH_PopViewDidDismissForPopView:(NCHPopView *)popView;
//***********************




@end

NS_ASSUME_NONNULL_END

