//
//  VLTopicRequest.m
//  VLog
//
//  Created by szy on 2020/10/22.
//  Copyright © 2020 niuchao. All rights reserved.
//

#import "VLTopicRequest.h"

@implementation VLTopicRequest

- (NSString *)requestUrl{
    return API_VLOG_PUBLISH_TOPIC;
}

- (YTKRequestMethod)requestMethod{
    return YTKRequestMethodGET;
}

@end
