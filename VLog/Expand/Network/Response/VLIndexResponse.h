//
//  VLIndexResponse.h
//  VLog
//
//  Created by szy on 2020/10/12.
//  Copyright © 2020 niuchao. All rights reserved.
//

#import "NCHBaseRequestResponse.h"
#import "VLVideoInfoModel.h"

NS_ASSUME_NONNULL_BEGIN

@class
VLIndex_Cat_InfoResponse,
VLVideoInfoModel,
VLIndex_PageResponse,
VLIndex_ContextResponse
;
@interface VLIndexResponse : NCHBaseRequestResponse

KProStrongType(VLIndex_Cat_InfoResponse,cat_info)
KProNSArrayType(VLIndex_Cat_InfoResponse,cat_list)
kProNSString(tab_id)
kProNSString(short_video_hot_search)
KProNSArrayType(VLVideoInfoModel,list)
KProStrongType(VLIndex_PageResponse,page)
KProStrongType(VLIndex_ContextResponse,context)

@end

@interface VLIndex_Cat_InfoResponse : NSObject
KProNSInteger(cat_id)
kProNSString(cat_name)
KProNSInteger(parent_id)
KProNSInteger(cat_level)
KProNSInteger(is_show)
KProNSInteger(cat_sort)
kProNSString(cat_image)
KProNSInteger(width)
KProNSInteger(height)
KProNSArrayType(VLIndex_Cat_InfoResponse,children)
@end

@interface VLIndex_PageResponse : NSObject
kProNSString(page_key)
kProNSString(page_id)
KProNSInteger(default_page_size)
KProBool(count_disabled)
KProNSInteger(cur_page)
KProNSInteger(page_size)
KProNSArray(page_size_list)
KProNSInteger(record_count)
KProNSInteger(page_count)
KProNSInteger(offset)
kProNSString(url)
kProNSString(sql)
@end


#pragma mark - Context
@class
VLIndex_Context_UserInfoResponse,
VLIndex_Context_ConfigResponse;
@interface VLIndex_ContextResponse : NSObject

KProNSInteger(current_time)
KProStrongType(VLIndex_Context_UserInfoResponse,user_info)
KProStrongType(VLIndex_Context_ConfigResponse,config)
KProNSDictionary(cart)
kProNSString(szy_version)
@end

@class VLIndex_Context_UserInfo_UserRankResponse;
@interface VLIndex_Context_UserInfoResponse : NSObject
KProNSInteger(user_id)
kProNSString(user_name)
kProNSString(nickname)
kProNSString(headimg)
kProNSString(email)
KProNSInteger(email_validated)
kProNSString(mobile)
KProNSInteger(mobile_validated)
KProNSInteger(is_seller)
KProNSInteger(shop_id)
KProNSInteger(last_time)
kProNSString(last_ip)
kProNSString(last_region_code)
KProStrongType(VLIndex_Context_UserInfo_UserRankResponse, user_rank)

@end

@interface VLIndex_Context_UserInfo_UserRankResponse : NSObject
KProNSInteger(min_points)
KProNSInteger(max_points)
KProNSInteger(is_special)
KProNSInteger(type)
KProNSInteger(rank_id)
kProNSString(rank_name)
kProNSString(rank_img)
@end

@interface VLIndex_Context_ConfigResponse : NSObject
kProNSString(mall_logo)
kProNSString(site_name)
kProNSString(user_center_logo)
kProNSString(mall_region_code)
KProNSDictionary(mall_region_name)
kProNSString(mall_address)
kProNSString(site_icp)
kProNSString(site_copyright)
kProNSString(site_powered_by)
kProNSString(mall_phone)
kProNSString(mall_email)
kProNSString(mall_wx_qrcode)
kProNSString(mall_qq)
kProNSString(mall_wangwang)
kProNSString(default_user_portrait)
kProNSString(favicon)
kProNSString(aliim_enable)
kProNSString(evaluate_show)
kProNSString(is_webp)
kProNSString(aliim_appkey)
kProNSString(aliim_secret_key)
kProNSString(aliim_main_customer)
kProNSString(aliim_customer_logo)
kProNSString(aliim_welcome_words)
kProNSString(aliim_uid)
kProNSString(aliim_pwd)

@end

NS_ASSUME_NONNULL_END
