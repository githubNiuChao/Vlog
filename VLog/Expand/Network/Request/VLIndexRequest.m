//
//  VLIndexRequest.m
//  VLog
//
//  Created by szy on 2020/9/30.
//  Copyright © 2020 niuchao. All rights reserved.
//

#import "VLIndexRequest.h"


@implementation VLIndexRequest

- (NSString *)requestUrl{
   return API_SITE_LOGIN;
}

- (YTKRequestMethod)requestMethod{
    return YTKRequestMethodPOST;
}

@end
