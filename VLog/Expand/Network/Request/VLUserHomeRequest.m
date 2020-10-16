//
//  VLUserHomeRequest.m
//  VLog
//
//  Created by szy on 2020/10/16.
//  Copyright © 2020 niuchao. All rights reserved.
//

#import "VLUserHomeRequest.h"

@implementation VLUserHomeRequest

- (NSString *)requestUrl{
   return API_VLOG_HOME_WORKS;
}

- (YTKRequestMethod)requestMethod{
    return YTKRequestMethodGET;
}

@end
