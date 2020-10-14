//
//  NCHPopViewManager.h
//  VLog
//
//  Created by szy on 2020/10/13.
//  Copyright © 2020 niuchao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@class NCHPopView;


static NSString * _Nonnull const NCHPopView_ParentView = @"NCHPopView_ParentView";
static NSString * _Nonnull const NCHPopView_Key = @"NCHPopView_Key";
static NSString * _Nonnull const NCHPopView_PopView = @"NCHPopView_PopView";


typedef void(^NCHPopViewManagerTimerBlock)(NSTimeInterval interval);




NS_ASSUME_NONNULL_BEGIN

@interface NCHPopViewManager : NSObject


/** 单例 */
NCHPopViewManager *NCHPopViewM(void);


/** 保存popView */
+ (void)savePopView:(NCHPopView *)popView;

/** 获取全局(整个app内)所有popView */
+ (NSArray *)getAllPopView;
/** 获取当前页面所有popView */
+ (NSArray *)getAllPopViewForParentView:(UIView *)view;
/** 获取当前页面指定编队的所有popView */
+ (NSArray *)getAllPopViewForPopView:(UIView *)popView;
/**
    读取popView (有可能会跨编队读取弹框)
    建议使用getPopViewForGroupId:forkey: 方法进行精确读取
 */
+ (NCHPopView *)getPopViewForKey:(NSString *)key;



/** 移除popView */
+ (void)removePopView:(NCHPopView *)popView;
/**
   移除popView 通过唯一key (有可能会跨编队误删弹框)
   建议使用removePopViewForGroupId:forkey: 方法进行精确删除
*/
+ (void)removePopViewForKey:(NSString *)key;
/** 移除所有popView */
+ (void)removeAllPopView;


/** 弱化popView 仅供内部调用 */
+ (void)weakWithPopView:(NCHPopView *)popView;


@end

NS_ASSUME_NONNULL_END
