//
//  NCHBaseRequestResponse.m
//  VLog
//
//  Created by szy on 2020/9/29.
//  Copyright © 2020 niuchao. All rights reserved.
//

#import "NCHBaseRequestResponse.h"
#import "NCHBaseRequest.h"

//*********************** 状态码,这个是跟后台讨论的 ***********************
typedef NSString *NCHResponseCode NS_EXTENSIBLE_STRING_ENUM;
// 请求成功 code
static NCHResponseCode const kPublicResponseSuccessCode = @"200";
// token失效 code
static NCHResponseCode const kPublicResponseTokenInvalidCode = @"111111";
// 版本失效 code
static NCHResponseCode const kPublicResponseVersonInvalidCode = @"222222";
// 服务器500错误
static NCHResponseCode const kPublicResponseServerNotResponseCode = @"500";

@implementation NCHBaseRequestResponse

/**  错误信息,在请求失败时的错误信息,如果后台返回的 msg 有值就返回值,没有值就返回一个默认值:抱歉，当前访问用户过多，请稍后重试  */
- (NSString *)errorMessage
{
    NSString *errorMessage = self.message;
    if ([self isRequestSuccess])
    {
        errorMessage = nil;
    }
    else if ([self isTokenInvalid])
    {
        errorMessage = self.message;
    }
    else if ([self isVersonInvalid])
    {
        errorMessage = self.message;
    }
    else if ([self isServerNotResponse])
    {
        errorMessage = self.message ? : kDefaultErrorInfo;
    }
    
    return errorMessage;
}
/**  是否请求成功  */
- (BOOL)isRequestSuccess
{
    return [self.code isEqualToString:kPublicResponseSuccessCode];
}
/**  是否token失效  */
- (BOOL)isTokenInvalid
{
    return [self.code isEqualToString:kPublicResponseTokenInvalidCode];
}
/**  是否版本失效  */
- (BOOL)isVersonInvalid
{
    return [self.code isEqualToString:kPublicResponseTokenInvalidCode];
}
/**  是否服务器500错误  */
- (BOOL)isServerNotResponse
{
    return [self.code isEqualToString:kPublicResponseServerNotResponseCode];
}

@end

