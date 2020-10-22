//
//  VLTopicResponse.m
//  VLog
//
//  Created by szy on 2020/10/22.
//  Copyright © 2020 niuchao. All rights reserved.
//

#import "VLTopicResponse.h"

@implementation VLTopicResponse

+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"cat_list" : [VLIndex_Cat_InfoResponse class]};
}
@end
