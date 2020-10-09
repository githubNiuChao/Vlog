//
//  NCHRequestPublicArgument.m
//  VLog
//
//  Created by szy on 2020/9/29.
//  Copyright © 2020 niuchao. All rights reserved.
//

#import "NCHRequestPublicArgument.h"

NSString * const NCHRequestPublicArgument_SzyVersion_Key = @"szy_version";
NSString * const NCHRequestPublicArgument_UserAgent_Key = @"User-Agent";


@implementation NCHRequestPublicArgument{
    NSDictionary *_arguments;
}

+ (NCHRequestPublicArgument *)filterWithArguments:(NSDictionary *)arguments {
    return [[self alloc] initWithArguments:arguments];
}

- (id)initWithArguments:(NSDictionary *)arguments {
    self = [super init];
    if (self) {
        _arguments = arguments;
    }
    return self;
}


- (NSString *)filterUrl:(NSString *)originUrl withRequest:(YTKBaseRequest *)request {
    return [self urlStringWithOriginUrlString:originUrl appendParameters:_arguments];
}

- (NSString *)urlStringWithOriginUrlString:(NSString *)originUrlString appendParameters:(NSDictionary *)parameters {
    NSString *paraUrlString = AFQueryStringFromParameters(parameters);

    if (!(paraUrlString.length > 0)) {
        return originUrlString;
    }

    BOOL useDummyUrl = NO;
    static NSString *dummyUrl = nil;
    NSURLComponents *components = [NSURLComponents componentsWithString:originUrlString];
    if (!components) {
        useDummyUrl = YES;
        if (!dummyUrl) {
            dummyUrl = @"http://www.dummy.com";
        }
        components = [NSURLComponents componentsWithString:dummyUrl];
    }

    NSString *queryString = components.query ?: @"";
    NSString *newQueryString = [queryString stringByAppendingFormat:queryString.length > 0 ? @"&%@" : @"%@", paraUrlString];

    components.query = newQueryString;

    if (useDummyUrl) {
        return [components.URL.absoluteString substringFromIndex:dummyUrl.length - 1];
    } else {
        return components.URL.absoluteString;
    }
}


//
//
//- (instancetype)init
//{
//    self = [super init];
//    if (self)
//    {
//        _szy_version = ([[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"]);
//        _ = [NSString stringWithFormat:@"%ld", (long)([[NSDate date] timeIntervalSince1970])];
//    }
//    return self;
//}


@end
