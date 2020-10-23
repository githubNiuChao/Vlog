//
//  VLFollowResponse.m
//  VLog
//
//  Created by szy on 2020/10/23.
//  Copyright © 2020 niuchao. All rights reserved.
//

#import "VLFollowResponse.h"

@implementation VLFollowResponse

+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"list" : [VLFollowListModel class]};
}
@end

@implementation VLFollowListModel

+ (NSDictionary *)modelContainerPropertyGenericClass {
    
    return @{@"video_list" : [VLVideoInfoModel class],
             @"user_info" : [VLIndex_Context_UserInfoResponse class]};
}


@end
