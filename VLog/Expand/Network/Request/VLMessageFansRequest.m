//
//  VLMessageFansRequest.m
//  VLog
//
//  Created by szy on 2020/10/25.
//  Copyright © 2020 niuchao. All rights reserved.
//

#import "VLMessageFansRequest.h"

@implementation VLMessageFansRequest
- (NSString *)requestUrl{
    return API_VLOG_MESSAGE_FANS_LIST;
}

- (YTKRequestMethod)requestMethod{
    return YTKRequestMethodGET;
}

@end
