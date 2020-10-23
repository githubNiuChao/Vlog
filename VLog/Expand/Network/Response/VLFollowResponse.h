//
//  VLFollowResponse.h
//  VLog
//
//  Created by szy on 2020/10/23.
//  Copyright © 2020 niuchao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "VLIndexResponse.h"
#import "VLVideoInfoModel.h"

NS_ASSUME_NONNULL_BEGIN
@class
VLFollowListModel,
VLIndex_PageResponse,
VLIndex_ContextResponse,
VLIndex_Context_UserInfoResponse;

@interface VLFollowResponse : NSObject

KProNSArrayType(VLFollowListModel,list)
KProStrongType(VLIndex_PageResponse,page)
KProStrongType(VLIndex_ContextResponse,context)

@end

@interface VLFollowListModel : NSObject
kProNSString(user_id)
kProNSString(video_count)
KProNSArrayType(VLVideoInfoModel,video_list)
KProNSArrayType(VLIndex_Context_UserInfoResponse,user_info)

@end


NS_ASSUME_NONNULL_END
