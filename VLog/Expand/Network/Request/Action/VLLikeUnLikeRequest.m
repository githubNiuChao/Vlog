//
//  VLLikeUnLikeRequest.m
//  VLog
//
//  Created by szy on 2020/10/28.
//  Copyright © 2020 niuchao. All rights reserved.
//

#import "VLLikeUnLikeRequest.h"

@implementation VLLikeUnLikeRequest

- (instancetype)initWithIsLikeRequest:(BOOL)isLikeRequest
{
    self = [super init];
    if (self) {
        if (isLikeRequest) {
            [self setArgument:@"1" forKey:@"relation_type"];
        }else{
            [self setArgument:@"2" forKey:@"relation_type"];
        }
    }
    return self;
}

- (NSString *)requestUrl{
    if (_isLike) {
    return API_VLOG_LIKE_ACTION;
    }else{
    return API_VLOG_UNLIKE_ACTION;
    }
}

- (YTKRequestMethod)requestMethod{
    return YTKRequestMethodGET;
}

@end
