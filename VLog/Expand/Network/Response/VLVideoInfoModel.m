//
//  VLVideoInfoModel.m
//  VLog
//
//  Created by szy on 2020/10/15.
//  Copyright © 2020 niuchao. All rights reserved.
//

#import "VLVideoInfoModel.h"

@implementation VLVideoInfoModel

+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"video_desc" : [VLVideoInfo_DescModel class]};
}

- (void)setVideo_type:(NSString *)video_type{
    _video_type = video_type;
    self.videoType = [video_type integerValue];
}


@end

@implementation VLVideoInfo_DescModel

+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"tagId" : @"id"};
}

@end
