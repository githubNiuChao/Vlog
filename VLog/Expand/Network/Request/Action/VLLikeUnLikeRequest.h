//
//  VLLikeUnLikeRequest.h
//  VLog
//
//  Created by szy on 2020/10/28.
//  Copyright © 2020 niuchao. All rights reserved.
//

#import "NCHBaseRequest.h"

NS_ASSUME_NONNULL_BEGIN

@interface VLLikeUnLikeRequest : NCHBaseRequest
KProBool(isLike)
KProBool(isLikeRequest)

@end

NS_ASSUME_NONNULL_END
