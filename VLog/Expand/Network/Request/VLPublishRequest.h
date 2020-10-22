//
//  VLPublishRequest.h
//  VLog
//
//  Created by szy on 2020/10/21.
//  Copyright © 2020 niuchao. All rights reserved.
//

#import "NCHBaseRequest.h"

NS_ASSUME_NONNULL_BEGIN

@interface VLPublishRequest : NCHBaseRequest

- (id)initWithVideoUrl:(NSURL *)videoUrl;

//获取上传进度
@property(nonatomic,copy)void(^VLUploadProgressBlock)(VLPublishRequest *currentApi, NSProgress * progress);

@end

NS_ASSUME_NONNULL_END
