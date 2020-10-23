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
    if (self.isFolllow) {
        return API_VLOG_INDEX_FOLLOW;
    }else{
        return API_VLOG_INDEX_FIND;
    }
}

- (YTKRequestMethod)requestMethod{
    return YTKRequestMethodPOST;
}

@end
