//
//  VLUserHomeFansListRequest.m
//  VLog
//
//  Created by szy on 2020/11/2.
//  Copyright © 2020 niuchao. All rights reserved.
//

#import "VLUserHomeFansListRequest.h"

@implementation VLUserHomeFansListRequest

- (NSString *)requestUrl{
    return API_VLOG_HOME_FANS_LIST;
}

- (YTKRequestMethod)requestMethod{
    return YTKRequestMethodGET;
}

@end
