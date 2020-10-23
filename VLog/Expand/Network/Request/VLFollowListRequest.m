//
//  VLFollowListRequest.m
//  VLog
//
//  Created by szy on 2020/10/23.
//  Copyright © 2020 niuchao. All rights reserved.
//

#import "VLFollowListRequest.h"

@implementation VLFollowListRequest

- (NSString *)requestUrl{
   return API_VLOG_INDEX_FOLLOW_RECOMMEND;
}

- (YTKRequestMethod)requestMethod{
    return YTKRequestMethodGET;
}
@end
