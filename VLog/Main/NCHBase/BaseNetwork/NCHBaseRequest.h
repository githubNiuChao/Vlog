//
//  NCHBaseRequest.h
//  VLog
//
//  Created by szy on 2020/9/29.
//  Copyright © 2020 niuchao. All rights reserved.
//

#if __has_include(<YTKNetwork/YTKNetwork.h>)
#import <YTKNetwork/YTKNetwork.h>
#else
#import "YTKNetwork.h"
#endif
#import "NCHBaseRequestResponse.h"

static NSString * _Nonnull const kDefaultErrorInfo = @"当前太多人访问,请稍后重试";


NS_ASSUME_NONNULL_BEGIN

typedef void(^NCHBaseRequestCompletionBlock)(__kindof YTKBaseRequest *request,NCHBaseRequestResponse *baseResponse);

@interface NCHBaseRequest : YTKBaseRequest

/**  参数字典  */
@property (nonatomic, strong) NSMutableDictionary *argumentsDictionary;

@property (nonatomic, assign) BOOL shouldAddMACArguments;
/**  是否添加公共参数,默认为NO  */
@property (nonatomic, assign) BOOL shouldAddPublicArguments;

@property (nonatomic, assign) BOOL isAES; //默认为NO

@property(nonatomic, copy) NSString *errorMessage;

/**  添加请求参数  */
- (void)setArgument:(id)value forKey:(NSString *)key;
/**  封装请求方法  */
- (void)nch_startWithCompletionBlockWithSuccess:(nullable NCHBaseRequestCompletionBlock)success
                                    failure:(nullable NCHBaseRequestCompletionBlock)failure;

/**  请求后解析json后的对应的模型,可以是这个base的子类,建议不同的请求这个模型集成自NCHBaseRequestResponse  */
- (NSString *)baseResopnesModelClassName;
/**  请求后解析json字典data后的对应的模型,可以是这个base的子类,建议不同的请求这个模型集成自NCHBaseRequestResponse  */
- (NSString *)baseResopnesDataModelClassName;

#pragma mark - code处理
/**  在 isRequestSuccess 为 YES 的情况下会调用这个方法,默认什么都不做,子类可以重写这个  */
- (void)requestDidSuccess;
/**  在 isVersonInvalid 为 YES 的情况下会调用这个方法,默认什么都不做,子类可以重写这个  */
- (void)versonDidInvalid;
/**  在 isTokenInvalid 为 YES 的情况下会调用这个方法,默认什么都不做,子类可以重写这个  */
- (void)tokenDidInvalid;
/**  在 isServerNotResponse 为 YES 的情况下会调用这个方法,默认什么都不做,子类可以重写这个  */
- (void)serverDidNotResponse;

@end

@interface YTKBaseRequest (PostMan)

// 提供url字符串,方法提供给后台调试
- (NSString *)postManString;

@end

NS_ASSUME_NONNULL_END
