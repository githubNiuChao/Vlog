//
//  VLDetailResponse.h
//  VLog
//
//  Created by szy on 2020/10/16.
//  Copyright © 2020 niuchao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "VLDetailCommentModel.h"


NS_ASSUME_NONNULL_BEGIN
@class VLVideoInfoModel;
@class VLUserInfoModel;
@class VLIndex_Cat_InfoResponse;
@class VLIndex_ContextResponse;

@interface VLDetailResponse : NSObject

KProStrongType(VLVideoInfoModel,video_info)
KProStrongType(VLIndex_Cat_InfoResponse,video_cat_info)
KProStrongType(VLUserInfoModel,user_info)//视频作者内容
KProStrongType(VLUserInfoModel,current_user)//登陆作者内容
KProBool(is_follow)
kProNSString(like_count)
kProNSString(collection_count)
kProNSString(comment_count)
KProBool(is_like)
KProBool(is_collection)
KProNSArray(tag_list)
KProNSArray(img_size_list)
KProStrongType(VLIndex_ContextResponse,context)
KProNSArrayType(VLDetailCommentModel, comment_list)

@end

@interface VLDetail_TagListResponse : NSObject
KProNSInteger(tag_id)
KProNSInteger(video_id)
KProNSInteger(path_index)
kProNSString(tag_text)
KProNSInteger(goods_id)
KProNSInteger(brand_id)
KProNSInteger(top)
KProNSInteger(left)
@end

NS_ASSUME_NONNULL_END

