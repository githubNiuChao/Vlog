//
//  NCHBaseRequest.m
//  VLog
//
//  Created by szy on 2020/9/29.
//  Copyright © 2020 niuchao. All rights reserved.
//

#import "NCHBaseRequest.h"
#import <CommonCrypto/CommonCryptor.h>
#import "NCHRequestPublicArgument.h"
#import "NCHBaseRequestResponse.h"
#import "NCHNetWorkManager.h"

NSString * const NCHRequestHeaderField_SzyVersion_Key = @"szy_version";
NSString * const NCHRequestHeaderField_UserAgent_Key = @"User-Agent";

@interface NCHBaseRequest ()

/**  是否已经处理过请求参数,比如添加公共参数  */
@property (nonatomic, assign) BOOL finishedHandleArgument;

@end

@implementation NCHBaseRequest


#pragma mark - 重新父类方法
- (instancetype)init
{
    self = [super init];
    if (self)
    {
        _argumentsDictionary = [[NSMutableDictionary alloc] init];
        _shouldAddPublicArguments = NO;
        _shouldAddMACArguments = NO;
        _finishedHandleArgument = NO;
        _isAES = NO;
        _errorMessage = kDefaultErrorInfo;
    }
    return self;
}

- (NSTimeInterval)requestTimeoutInterval
{
    return 60.f;
}

- (NSString *)baseUrl
{
    return [NCHNetWorkManager sharedInstance].connectPort.requestBaseURL;
}

- (YTKRequestMethod)requestMethod {
    return YTKRequestMethodGET;
}

- (YTKRequestSerializerType)requestSerializerType {
    return YTKRequestSerializerTypeHTTP;
}

- (YTKResponseSerializerType)responseSerializerType {
    return YTKResponseSerializerTypeJSON;
}

- (NSDictionary *)requestHeaderFieldValueDictionary
{
    return @{NCHRequestHeaderField_SzyVersion_Key: @"5.5",NCHRequestHeaderField_UserAgent_Key:@"szyapp/ios"};
}

///封装请求
- (void)nch_startWithCompletionBlockWithSuccess:(NCHBaseRequestCompletionBlock)success failure:(NCHBaseRequestCompletionBlock)failure{
    NSLog(@"Request:👍👍👍👍👍👍👍👍👍%@%@",self.baseUrl,self.requestUrl);
    NSLog(@"RequestArgument:👍👍👍👍👍👍👍👍👍%@",self.requestArgument);
    
    [self startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
        NCHBaseRequestResponse *baseRespose = [NCHBaseRequestResponse yy_modelWithJSON:request.responseObject];
        if (baseRespose.code != 0) {
            [UIWindow showTips:baseRespose.message];
        }
        success(request,baseRespose);
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        NCHBaseRequestResponse *baseRespose = [[NCHBaseRequestResponse alloc]init];;
        baseRespose.message = @"请求失败";
        [UIWindow showTips:baseRespose.message];
        failure(request,baseRespose);
    }];
}

/// 处理公共参数
- (id )requestArgument
{
    // 先判断是否已经处理过参数
    if (self.finishedHandleArgument)
    {
        return self.argumentsDictionary;
    }
    
    NSMutableDictionary *mDict = self.argumentsDictionary;
    
    // 处理公共参数
    if (self.shouldAddPublicArguments)
    {
        [mDict addEntriesFromDictionary:[[NCHRequestPublicArgument new] mj_keyValues]];
    }
    // 处理MAC
    if (self.shouldAddMACArguments)
    {
        mDict[@"sign"] = [self macForDictionary:mDict];
    }
    
    self.finishedHandleArgument = YES;
    return mDict;
}

- (BOOL)statusCodeValidator
{
    // 解析data数据
    id baseResopnes = self.responseJSONObject;
    if (baseResopnes)
    {
        if ([baseResopnes respondsToSelector:@selector(isTokenInvalid)] && [(id <NCHBaseRequestResponse>)baseResopnes isTokenInvalid]){
            [self tokenDidInvalid];
        }
        
        if ([baseResopnes respondsToSelector:@selector(isVersonInvalid)] && [(id <NCHBaseRequestResponse>)baseResopnes isVersonInvalid]){
            [self versonDidInvalid];
        }
        
        if ([baseResopnes respondsToSelector:@selector(isServerNotResponse)] && [(id <NCHBaseRequestResponse>)baseResopnes isServerNotResponse]){
            [self serverDidNotResponse];
        }
        
        if ([baseResopnes respondsToSelector:@selector(isRequestSuccess)]){
            BOOL success = [(id <NCHBaseRequestResponse>)baseResopnes isRequestSuccess];
            if (success) [self requestDidSuccess];
            return success;
        }
    }
    return [super statusCodeValidator];
}


// 解析data数据
//- (id)analysisData
//{
//    NSDictionary *reponseObj = nil;
//    reponseObj = self.isAES ? [self responseObjectWithDecryp:self.responseJSONObject] :self.responseJSONObject;
//    // 解析data
//    Class baseResopnesDataClass = NSClassFromString([self baseResopnesDataModelClassName]);
//    NSDictionary *baseResopnesDataDictionary = [self.class lt_propertyNameForClass:baseResopnesDataClass];
//    if (baseResopnesDataDictionary)
//    {
//        Class dataModelClass = NSClassFromString(baseResopnesDataDictionary.allKeys.firstObject);
//        NSString *baseResopnesDataName = baseResopnesDataDictionary.allValues.firstObject;
//        id baseResopnesData = [dataModelClass.class modelWithJSON:reponseObj];
//        if (baseResopnesData)
//        {
//            [self setValue:baseResopnesData forKey:baseResopnesDataName];
//        }
//    }
//
//    // 解析全部数据
//    // 找到类名
//    Class baseResopnesClass = NSClassFromString([self baseResopnesModelClassName]);
//    // 找到属性字典
//    NSDictionary *baseResopnesDictionary = [self.class lt_propertyNameForClass:baseResopnesClass];
//    if (baseResopnesDictionary)
//    {
//        Class modelClass = NSClassFromString(baseResopnesDictionary.allKeys.firstObject);
//        NSString *baseResopnesName = baseResopnesDictionary.allValues.firstObject;
//        // 解析数据
//        id baseResopnes = [modelClass.class modelWithJSON:reponseObj];
//        if (baseResopnes)
//        {
//            [self setValue:baseResopnes forKey:baseResopnesName];
//            if ([baseResopnes isKindOfClass:[NCHBaseRequestResponse class]])
//            {
//                self.errorMessage = ((NCHBaseRequestResponse *)baseResopnes).errorMessage;
//            }
//            return baseResopnes;
//        }
//    }
//
//    if (!baseResopnesClass)
//    {
//        NSLog(@"请求%@没有解析json对应的model", NSStringFromClass(self.class));
//    }
//
//    return nil;
//}

/// 添加请求参数
- (void)setArgument:(id)value forKey:(NSString*)key
{
    if (value == NULL || [value isKindOfClass:[NSNull class]] || key == NULL || [key isKindOfClass:[NSNull class]])
    {
        NSString *error = [NSString stringWithFormat:@"%@--401-->setArgument:key: 参数%@为空,检测调用代码块...", NSStringFromClass(self.class), key];
        NSLog(@"%@", error);
        return;
    }
    self.argumentsDictionary[key] = value;
}



- (NSString *)baseResopnesModelClassName
{
    return @"NCHBaseRequestResponse";
}

- (NSString *)baseResopnesDataModelClassName
{
    return @"NCHBaseRequestResponse";
}

#pragma mark - 加解密/签名
/**
 签名参数串
 @param dict 参数
 @return 返回签名后的参数
 */
- (NSString *)macForDictionary:(NSMutableDictionary *)dict
{
    // 先排序
    NSArray *keys = [dict allKeys];
    NSArray *sortedArray = [keys sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2){
        return [obj1 compare:obj2 options:NSNumericSearch];
    }];
    
    // 再加盐
    NSString *salt = @"salt";
    NSMutableString *result = [NSMutableString stringWithString:salt];
    for (NSString *key in sortedArray)
    {
        [result appendString:[NSString stringWithFormat:@"%@%@",key,[dict objectForKey:key]]];
    }
    return result.jk_md5String;
}

- (id)responseObjectWithDecryp:(id)reponse
{
    id deReponse = [reponse mutableCopy];
    // 这里进行aes解密
    return deReponse;
}

#pragma mark - code处理
/**  在 isRequestSuccess 为 YES 的情况下会调用这个方法,默认什么都不做,子类可以重写这个  */
- (void)requestDidSuccess
{
    
}
/**  在 isVersonInvalid 为 YES 的情况下会调用这个方法,默认什么都不做,子类可以重写这个  */
- (void)versonDidInvalid
{
    
}
/**  在 isTokenInvalid 为 YES 的情况下会调用这个方法,默认什么都不做,子类可以重写这个  */
- (void)tokenDidInvalid
{
    
}
/**  在 isServerNotResponse 为 YES 的情况下会调用这个方法,默认什么都不做,子类可以重写这个  */
- (void)serverDidNotResponse
{
    
}
@end



@implementation YTKBaseRequest (PostMan)

- (NSString *)postManString
{
    if (self.requestMethod == YTKRequestMethodGET)
    {
        return [NSString stringWithFormat:@"<%@: %p>{ URL: %@ } { method: %@ } { arguments: %@ } { header: %@ }", NSStringFromClass([self class]), self, self.currentRequest.URL, self.currentRequest.HTTPMethod, self.requestArgument, self.requestHeaderFieldValueDictionary];
    }
    else
    {
        NSDictionary *dict = [self requestArgument];
        __block NSMutableString *argumentsString = @"?".mutableCopy;
        __block NSMutableArray *arguments = @[].mutableCopy;
        [dict enumerateKeysAndObjectsUsingBlock:^(NSString * _Nonnull key, NSString * _Nonnull obj, BOOL * _Nonnull stop) {
            NSString *argment = [NSString stringWithFormat:@"%@=%@", key, obj];
            [arguments addObject:argment];
        }];
        [argumentsString appendString:[arguments componentsJoinedByString:@"&"]];
        NSString *urlStr = [NSString stringWithFormat:@"%@%@", self.currentRequest.URL.absoluteString, argumentsString];
        return [NSString stringWithFormat:@"<%@: %p>{ URL: %@ } { method: %@ } { arguments: %@ }  { header: %@ }", NSStringFromClass([self class]), self, urlStr, self.currentRequest.HTTPMethod, self.requestArgument, self.requestHeaderFieldValueDictionary];
    }
}

@end
