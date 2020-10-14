//
//  VLPhotoDetailRequest.m
//  VLog
//
//  Created by szy on 2020/10/14.
//  Copyright © 2020 niuchao. All rights reserved.
//

#import "VLPhotoDetailRequest.h"

@implementation VLPhotoDetailRequest

- (NSString *)requestUrl{
   return API_VLOG_DETAIL_INFO;
}

- (YTKRequestMethod)requestMethod{
    return YTKRequestMethodGET;
}
@end
