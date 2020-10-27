//
//  VLDetailResponse.m
//  VLog
//
//  Created by szy on 2020/10/16.
//  Copyright © 2020 niuchao. All rights reserved.
//

#import "VLDetailResponse.h"

@implementation VLDetailResponse
+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"comment_list" : [VLDetailCommentModel class]};
}
@end

@implementation VLDetail_TagListResponse


@end
