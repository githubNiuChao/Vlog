//
//  VLLikeCommentRequest.m
//  VLog
//
//  Created by szy on 2020/11/4.
//  Copyright © 2020 niuchao. All rights reserved.
//

#import "VLLikeCommentRequest.h"

@implementation VLLikeCommentRequest

- (NSString *)requestUrl{
    if (self.isLike) {
    return API_VLOG_LIKECOMMENT_ACTION;
    }else{
    return API_VLOG_UNLIKECOMMENT_ACTION;
    }
}

- (YTKRequestMethod)requestMethod{
    return YTKRequestMethodGET;
}


@end
