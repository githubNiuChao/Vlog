//
//  VLFollowUnFollowRequest.m
//  VLog
//
//  Created by szy on 2020/10/25.
//  Copyright © 2020 niuchao. All rights reserved.
//

#import "VLFollowUnFollowRequest.h"

@implementation VLFollowUnFollowRequest

- (NSString *)requestUrl{
    if (_isFolleow) {
    return API_VLOG_FOLLOW_ACTION;
    }else{
    return API_VLOG_UNFOLLOW_ACTION;
    }
}

- (YTKRequestMethod)requestMethod{
    return YTKRequestMethodGET;
}


@end
