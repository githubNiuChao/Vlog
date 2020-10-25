//
//  VLMessageLikeRequest.m
//  VLog
//
//  Created by szy on 2020/10/25.
//  Copyright © 2020 niuchao. All rights reserved.
//

#import "VLMessageLikeRequest.h"

@implementation VLMessageLikeRequest
- (NSString *)requestUrl{
    return API_VLOG_MESSAGE_LIKE_LIST;
}

- (YTKRequestMethod)requestMethod{
    return YTKRequestMethodGET;
}

@end
