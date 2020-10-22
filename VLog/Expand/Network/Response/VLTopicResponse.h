//
//  VLTopicResponse.h
//  VLog
//
//  Created by szy on 2020/10/22.
//  Copyright © 2020 niuchao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "VLIndexResponse.h"

NS_ASSUME_NONNULL_BEGIN
@class VLIndex_Cat_InfoResponse;
@interface VLTopicResponse : NSObject

KProNSArrayType(VLIndex_Cat_InfoResponse,data)

@end

NS_ASSUME_NONNULL_END
