//
//  VLLikeUnLikeRequest.h
//  VLog
//
//  Created by szy on 2020/10/28.
//  Copyright © 2020 niuchao. All rights reserved.
//

#import "NCHBaseRequest.h"

NS_ASSUME_NONNULL_BEGIN

static NSString * const VLRefreshLikeCollectListNotification = @"VLRefreshLikeCollectListNotification";

@interface VLLikeUnLikeRequest : NCHBaseRequest
///YES:点赞/收藏   NO：取消点赞/取消收藏
KProBool(isLike)
- (instancetype)initWithIsLikeRequest:(BOOL)isLikeRequest;
//发起请求
- (void)likeOrCollectRequestWhitID:(NSString *)videoId isLikeCollect:(BOOL)isLikeCollect;


@end

NS_ASSUME_NONNULL_END
