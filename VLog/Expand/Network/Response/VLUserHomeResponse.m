//
//  VLUserHomeResponse.m
//  VLog
//
//  Created by szy on 2020/10/16.
//  Copyright © 2020 niuchao. All rights reserved.
//

#import "VLUserHomeResponse.h"
#import "VLVideoInfoModel.h"

@implementation VLUserHomeResponse
+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"list" : [VLVideoInfoModel class]};
}
@end
