//
//  VLVideoInfoModel.h
//  VLog
//
//  Created by szy on 2020/10/15.
//  Copyright © 2020 niuchao. All rights reserved.
//

#import <Foundation/Foundation.h>
NS_ASSUME_NONNULL_BEGIN

typedef enum : NSUInteger {
    VLVideoInfoModelTypeImage = 0,
    VLVideoInfoModelTypeVideo = 1
} VLVideoInfoModelType;

@class VLVideoInfo_DescModel;
@interface VLVideoInfoModel : NSObject
kProNSString(video_id)
kProNSString(video_title)
KProNSArrayType(VLVideoInfo_DescModel,video_desc)
KProNSArray(video_path)
kProNSString(video_img)
kProNSString(video_type)
kProNSString(user_id)
kProNSString(cat_id1)
kProNSString(cat_id2)
kProNSString(publish_time)
kProNSString(publish_address)
kProNSString(publish_lng)
kProNSString(publish_lat)
kProNSString(province)
kProNSString(city)
kProNSString(city_code)
kProNSString(is_recommend)
kProNSString(audit_status)
kProNSString(audit_text)
kProNSString(clicks)
kProNSString(video_sort)
kProNSString(user_name)
kProNSString(nickname)
kProNSString(headimg)
kProNSString(like_count)
KProBool(is_like)
KProNSInteger(width)
KProNSInteger(height)
KProAssignType(NSInteger,imageCacheHeight)
KProAssignType(NSInteger,hobbysCacheHeight)
KProAssignType(VLVideoInfoModelType,videoType)
@end

@interface VLVideoInfo_DescModel : NSObject
kProNSString(tagId)
KProBool(is_tag)
kProNSString(name)
kProNSString(type)
@end


NS_ASSUME_NONNULL_END
