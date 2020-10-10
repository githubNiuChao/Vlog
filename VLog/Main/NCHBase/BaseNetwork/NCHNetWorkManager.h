//
//  NCHNetWorkManager.h
//  VLog
//
//  Created by szy on 2020/9/29.
//  Copyright © 2020 niuchao. All rights reserved.
//

#import <Foundation/Foundation.h>

@class NCHNetWorkManager, NCHConnectPort;

NS_ASSUME_NONNULL_BEGIN

@interface NCHNetWorkManager : NSObject

/**  单例  */
+ (instancetype)sharedInstance;
/**  当前连接url对象  */
@property (nonatomic, strong) NCHConnectPort *connectPort;

/**  网络库配置,必须调用  */
- (void)converContentTypeConfig;
/**  网络是否可用  */
+ (BOOL)isNetworkReachable;
/**  处理无网络事件  */
+ (void)handleNetWorkCannotAccessEvent;
/**  处理有网络事件  */
+ (void)handleNetWorAccessEvent;

/**  拼接URL路径  */
+ (NSString *)URL:(NSString *)urlString;
/**  拼接H5 URL路径  */
+ (NSString *)HTML5URL:(NSString *)urlString;
/**  拼接图片 URL路径  */
+ (NSURL *)imageURL:(NSString *)urlString;


@end

@interface NCHConnectPort : NSObject

/**  中文名字  */
@property (nonatomic, copy) NSString *name;
/**  网络请求 baseURL  */
@property (nonatomic, copy) NSString *requestBaseURL;
/**  网页 H5 baseURL  */
@property (nonatomic, copy) NSString *webBaseURL;
/**  资源（如：图片等） baseURL  */
@property (nonatomic, copy) NSString *resourceBaseURL;

@end

#pragma mark - 网络通知
//无法访问网络
extern NSString * const NCHNetWorkCannotAccessNotification;
//网络切换到WiFi
extern NSString * const NCHNetWorkChangedToWiFiNotification;
//网络切换到移动网络
extern NSString * const NCHNetWorkChangedToWWANNotification;


NS_ASSUME_NONNULL_END
