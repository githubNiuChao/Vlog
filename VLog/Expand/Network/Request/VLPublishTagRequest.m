//
//  VLPublishTagRequest.m
//  VLog
//
//  Created by szy on 2020/10/21.
//  Copyright © 2020 niuchao. All rights reserved.
//

#import "VLPublishTagRequest.h"

@implementation VLPublishTagRequest

- (NSString *)requestUrl{
    return self.isGoods ? API_VLOG_PUBLISH_TAG_GOODS:API_VLOG_PUBLISH_TAG_BRAND;
}

- (YTKRequestMethod)requestMethod{
    return YTKRequestMethodGET;
}



@end
