//
//  VLVideoInfoModel.m
//  VLog
//
//  Created by szy on 2020/10/15.
//  Copyright © 2020 niuchao. All rights reserved.
//

#import "VLVideoInfoModel.h"

@implementation VLVideoInfoModel

- (void)setVideo_type:(NSString *)video_type{
    _video_type = video_type;
    _videoType = [video_type integerValue];
}

@end
