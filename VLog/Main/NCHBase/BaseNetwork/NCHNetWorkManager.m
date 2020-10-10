//
//  NCHNetWorkManager.m
//  VLog
//
//  Created by szy on 2020/9/29.
//  Copyright © 2020 niuchao. All rights reserved.
//

#import "NCHNetWorkManager.h"
#import <AFNetworking/AFNetworking.h>
#if __has_include(<YTKNetwork/YTKNetwork.h>)
#import <YTKNetwork/YTKNetwork.h>
#else
#import "YTKNetwork.h"
#endif


#import "NCHRequestPublicArgument.h"

//0:生产 1:dev
#if DEBUG
//static BOOL kShowEnvironmentViewController = NO;
static NSInteger kDefaultNetworkType = 1;
#else
//static BOOL kShowEnvironmentViewController = NO;
static NSInteger kDefaultNetworkType = 0;
#endif

@interface NCHNetWorkManager ()

/**  环境数组  */
@property (nonatomic, strong) NSArray<NCHConnectPort *> *environmentArray;
/**  环境数组中下标  */
@property (nonatomic, assign) NSUInteger environmentType;

@end

@implementation NCHNetWorkManager

/**  单例  */
+ (instancetype)sharedInstance
{
    static dispatch_once_t onceToken;
    static NCHNetWorkManager *instance = nil;
    dispatch_once(&onceToken, ^{
        instance = [[super allocWithZone:NULL] init];
        // 网络环境设置,这里设置默认的环境类型,0:生产环境,1:测试环境

    });
    return instance;
}

- (instancetype)init
{
    if (self = [super init])
    {
        self.environmentType = kDefaultNetworkType;
        [self converContentTypeConfig];
        [NCHNetWorkManager monitorNetworkStatus];
    }
    return self;
}


- (NSArray<NCHConnectPort *> *)environmentArray{
    
    if (!_environmentArray) {
        NCHConnectPort *release = [[NCHConnectPort alloc] init];
        release.name = @"生产环境";
        release.requestBaseURL = @"https://www.68dsw.com";
        release.webBaseURL = @"";
        release.resourceBaseURL = @"";
        
        NCHConnectPort *dev = [[NCHConnectPort alloc] init];
        dev.name = @"开发环境";
        dev.requestBaseURL = @"http://m.68shop.me";
        dev.webBaseURL = @"";
        dev.resourceBaseURL = @"";
        
        _environmentArray = @[
                              //0 第一个位置（也就是下标为0的位置）必须为生产环境，不可以为其他环境！
                              release,
                              dev
                              ];
    }
    return _environmentArray;
}

#pragma mark - setter and getter

- (void)setEnvironmentType:(NSUInteger)environmentType
{
    _environmentType = environmentType;
    self.connectPort = self.environmentArray[environmentType];
}

- (void)converContentTypeConfig{
    
    [YTKNetworkConfig sharedConfig].baseUrl = self.connectPort.requestBaseURL;
    
    YTKNetworkAgent *agent = [YTKNetworkAgent sharedAgent];
    NSSet *acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript", @"text/plain", @"text/html", @"text/css", nil];
    NSString *keypath = @"jsonResponseSerializer.acceptableContentTypes";
    [agent setValue:acceptableContentTypes forKeyPath:keypath];
}

/**  拼接URL路径  */
+ (NSString *)URL:(NSString *)urlString
{
    return [NSURL URLWithString:urlString relativeToURL:[NSURL URLWithString:[NCHNetWorkManager sharedInstance].connectPort.requestBaseURL]].absoluteString;
}

/**  拼接H5 URL路径  */
+ (NSString *)HTML5URL:(NSString *)urlString
{
    return [NSURL URLWithString:urlString relativeToURL:[NSURL URLWithString:[NCHNetWorkManager sharedInstance].connectPort.webBaseURL]].absoluteString;
}
/**  拼接图片 URL路径  */
+ (NSURL *)imageURL:(NSString *)urlString
{
    return [NSURL URLWithString:urlString relativeToURL:[NSURL URLWithString:[NCHNetWorkManager sharedInstance].connectPort.resourceBaseURL]];
}


#pragma mark - 网络监听

/**  网络是否可用  */
+ (BOOL)isNetworkReachable
{
    return [AFNetworkReachabilityManager sharedManager].reachable;
}
/**  监听网络状态改变  */
+ (void)monitorNetworkStatus
{
    AFNetworkReachabilityManager *networkReachabilityManager = [AFNetworkReachabilityManager sharedManager];
    [networkReachabilityManager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        switch (status) {
            case AFNetworkReachabilityStatusUnknown:
            {
                [[NSNotificationCenter defaultCenter] postNotificationName:NCHNetWorkCannotAccessNotification object:nil];
            }
                break;
            case AFNetworkReachabilityStatusNotReachable:
            {
                [[NSNotificationCenter defaultCenter] postNotificationName:NCHNetWorkCannotAccessNotification object:nil];
            }
                break;
            case AFNetworkReachabilityStatusReachableViaWiFi:
            {
                [[NSNotificationCenter defaultCenter] postNotificationName:NCHNetWorkChangedToWiFiNotification object:nil];
            }
                break;
            case AFNetworkReachabilityStatusReachableViaWWAN:
            {
                [[NSNotificationCenter defaultCenter] postNotificationName:NCHNetWorkChangedToWWANNotification object:nil];
            }
                break;
        }
    }];
    
    [([NSNotificationCenter defaultCenter]) addObserver:self selector:@selector(handleNetWorkCannotAccessEvent) name:NCHNetWorkCannotAccessNotification object:nil];
    [([NSNotificationCenter defaultCenter]) addObserver:self selector:@selector(handleNetWorAccessEvent) name:NCHNetWorkChangedToWiFiNotification object:nil];
    [([NSNotificationCenter defaultCenter]) addObserver:self selector:@selector(handleNetWorAccessEvent) name:NCHNetWorkChangedToWWANNotification object:nil];
}
/**  处理无网络事件  */
+ (void)handleNetWorkCannotAccessEvent
{
    
}
/**  处理有网络事件  */
+ (void)handleNetWorAccessEvent
{
    
}

@end

@implementation NCHConnectPort

@end

//无法访问网络
NSString * const NCHNetWorkCannotAccessNotification = @"NCHNetWorkCannotAccessNotification";
//网络切换到WiFi
NSString * const NCHNetWorkChangedToWiFiNotification = @"NCHNetWorkChangedToWiFiNotification";
//网络切换到移动网络
NSString * const NCHNetWorkChangedToWWANNotification = @"NCHNetWorkChangedToWWANNotification";
