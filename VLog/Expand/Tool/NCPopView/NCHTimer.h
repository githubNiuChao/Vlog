//
//  NCHTimer.h
//  VLog
//
//  Created by szy on 2020/10/13.
//  Copyright © 2020 niuchao. All rights reserved.
//

#import <Foundation/Foundation.h>



NS_ASSUME_NONNULL_BEGIN

typedef void(^NCHTimerChangeBlock)(NSString *day, NSString *hour, NSString *minute, NSString *second, NSString *ms);
typedef void(^NCHTimerFinishBlock)(NSString *identifier);
typedef void(^NCHTimerPauseBlock)(NSString *identifier);



/** 倒计时变化通知类型 */
typedef NS_ENUM(NSInteger, NCHTimerSecondChangeNFType) {
    NCHTimerSecondChangeNFTypeNone = 0,
    NCHTimerSecondChangeNFTypeMS,        //每100ms(毫秒) 发出一次
    NCHTimerSecondChangeNFTypeSecond,    //每1s(秒) 发出一次

};

@interface NCHTimer : NSObject


/** 单例 */
NCHTimer *NCHTimerM(void);

#pragma mark - ***** 配置计时任务通知回调 *****
/// 设置倒计时任务的通知回调
/// @param name 通知名
/// @param identifier 倒计时任务的标识
/// @param type 倒计时变化通知类型
+ (void)setNotificationForName:(NSString *)name identifier:(NSString *)identifier changeNFType:(NCHTimerSecondChangeNFType)type;

#pragma mark - ***** 添加计时任务(100ms回调一次) *****
/// 添加计时任务
/// @param time 时间长度
/// @param handle 每100ms回调一次
+ (void)addTimerForTime:(NSTimeInterval)time handle:(NCHTimerChangeBlock)handle;
/// 添加计时任务
/// @param time 时间长度
/// @param identifier 计时任务标识
/// @param handle 每100ms回调一次
+ (void)addTimerForTime:(NSTimeInterval)time
             identifier:(NSString *)identifier
                 handle:(NCHTimerChangeBlock)handle;
/// 添加计时任务
/// @param time 时间长度
/// @param identifier 计时任务标识
/// @param handle 每100ms回调一次
/// @param finishBlock 计时完成回调
/// @param pauseBlock 计时暂停回调
+ (void)addTimerForTime:(NSTimeInterval)time
             identifier:(NSString *)identifier
                 handle:(NCHTimerChangeBlock)handle
                 finish:(NCHTimerFinishBlock)finishBlock
                  pause:(NCHTimerPauseBlock)pauseBlock;
/// 添加计时任务,持久化到硬盘
/// @param time 时间长度
/// @param identifier 计时任务标识
/// @param handle 每100ms回调一次
+ (void)addDiskTimerForTime:(NSTimeInterval)time
                 identifier:(NSString *)identifier
                     handle:(NCHTimerChangeBlock)handle;
/// 添加计时任务,持久化到硬盘
/// @param time 添加计时任务,持久化到硬盘
/// @param identifier 计时任务标识
/// @param handle 每100ms回调一次
/// @param finishBlock 计时完成回调
/// @param pauseBlock 计时暂停回调
+ (void)addDiskTimerForTime:(NSTimeInterval)time
                 identifier:(NSString *)identifier
                     handle:(NCHTimerChangeBlock)handle
                     finish:(NCHTimerFinishBlock)finishBlock
                      pause:(NCHTimerPauseBlock)pauseBlock;



#pragma mark - ***** 添加计时任务(1s回调一次) *****
/// 添加计时任务
/// @param time 时间长度
/// @param handle 计时任务标识
+ (void)addMinuteTimerForTime:(NSTimeInterval)time handle:(NCHTimerChangeBlock)handle;
/// 添加计时任务
/// @param time 时间长度
/// @param identifier 计时任务标识
/// @param handle 每100ms回调一次
+ (void)addMinuteTimerForTime:(NSTimeInterval)time
                   identifier:(NSString *)identifier
                       handle:(NCHTimerChangeBlock)handle;

/// 添加计时任务
/// @param time 时间长度
/// @param identifier 计时任务标识
/// @param handle 每100ms回调一次
/// @param finishBlock 计时完成回调
/// @param pauseBlock 计时暂停回调
+ (void)addMinuteTimerForTime:(NSTimeInterval)time
                   identifier:(NSString *)identifier
                       handle:(NCHTimerChangeBlock)handle
                       finish:(NCHTimerFinishBlock)finishBlock
                        pause:(NCHTimerPauseBlock)pauseBlock;

/// 添加计时任务
/// @param time 时间长度
/// @param identifier 计时任务标识
/// @param handle 每100ms回调一次
/// @param finishBlock 计时完成回调
/// @param pauseBlock 计时暂停回调
+ (void)addDiskMinuteTimerForTime:(NSTimeInterval)time
                       identifier:(NSString *)identifier
                           handle:(NCHTimerChangeBlock)handle
                           finish:(NCHTimerFinishBlock)finishBlock
                            pause:(NCHTimerPauseBlock)pauseBlock;


#pragma mark - ***** 获取计时任务时间间隔 *****
/// 通过任务标识获取 任务时间间隔
/// @param identifier 计时任务标识
+ (NSTimeInterval)getTimeIntervalForIdentifier:(NSString *)identifier;


#pragma mark - ***** 暂停计时任务 *****
/// 通过标识暂停计时任务
/// @param identifier 计时任务标识
+ (BOOL)pauseTimerForIdentifier:(NSString *)identifier;
/// 暂停所有计时任务
+ (void)pauseAllTimer;

#pragma mark - ***** 重启计时任务 *****
/// 通过标识重启 计时任务
/// @param identifier 计时暂停回调
+ (BOOL)restartTimerForIdentifier:(NSString *)identifier;
/// 重启所有计时任务
+ (void)restartAllTimer;

#pragma mark - ***** 移除计时任务 *****
/// 通过标识移除计时任务
/// @param identifier 计时暂停回调
+ (BOOL)removeTimerForIdentifier:(NSString *)identifier;
/// 移除所有计时任务
+ (void)removeAllTimer;

#pragma mark - ***** 格式化时间 *****
/// 将毫秒数 格式化成  时:分:秒:毫秒
/// @param time 时间长度(毫秒单位)
/// @param handle 格式化完成回调
+ (void)formatDateForTime:(NSTimeInterval)time handle:(NCHTimerChangeBlock)handle;

@end

NS_ASSUME_NONNULL_END

