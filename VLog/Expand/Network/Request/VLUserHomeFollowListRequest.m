//
//  VLUserHomeFollowListRequest.m
//  VLog
//
//  Created by szy on 2020/11/2.
//  Copyright © 2020 niuchao. All rights reserved.
//

#import "VLUserHomeFollowListRequest.h"

@implementation VLUserHomeFollowListRequest
- (NSString *)requestUrl{
    return API_VLOG_HOME_FOLLOWER_LIST;
}

- (YTKRequestMethod)requestMethod{
    return YTKRequestMethodGET;
}

@end
