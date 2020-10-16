//
//  VLUserHomeResponse.h
//  VLog
//
//  Created by szy on 2020/10/16.
//  Copyright © 2020 niuchao. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
@class VLIndex_Context_UserInfo_UserRankResponse;
@class VLUserInfoModel;
@class VLVideoInfoModel;
@class VLIndex_PageResponse;
@class VLIndex_ContextResponse;

@interface VLUserHomeResponse : NSObject
kProNSString(follow_count)
kProNSString(fans_count)
kProNSString(like_collection_count)
KProStrongType(VLIndex_Context_UserInfo_UserRankResponse, user_rank)
KProStrongType(VLUserInfoModel, user_info)
KProNSInteger(tab_id)
KProNSArrayType(VLVideoInfoModel,list)
KProStrongType(VLIndex_PageResponse,page)
KProStrongType(VLIndex_ContextResponse,context)
@end

NS_ASSUME_NONNULL_END
