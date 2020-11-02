//
//  VLFollowUnFollowRequest.h
//  VLog
//
//  Created by szy on 2020/10/25.
//  Copyright © 2020 niuchao. All rights reserved.
//

#import "NCHBaseRequest.h"

NS_ASSUME_NONNULL_BEGIN

@interface VLFollowUnFollowRequest : NCHBaseRequest

KProBool(isFolleow)

- (void)followRequestWhitID:(NSString *)userId isFollow:(BOOL)isFollow;

@end

NS_ASSUME_NONNULL_END
