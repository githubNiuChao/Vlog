//
//  VLIndexResponse.m
//  VLog
//
//  Created by szy on 2020/10/12.
//  Copyright © 2020 niuchao. All rights reserved.
//

#import "VLIndexResponse.h"

@implementation VLIndexResponse
+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"cat_list" : [VLIndex_Cat_InfoResponse class],
             @"list" : [VLIndex_ListResponse class]};
}
@end

@implementation VLIndex_Cat_InfoResponse
+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"children" : [VLIndex_Cat_InfoResponse class]};
}

@end

@implementation VLIndex_ListResponse

@end

@implementation VLIndex_PageResponse

@end

@implementation VLIndex_ContextResponse

@end

@implementation VLIndex_Context_UserInfoResponse

@end

@implementation VLIndex_Context_UserInfo_UserRankResponse

@end

@implementation VLIndex_Context_ConfigResponse

@end
