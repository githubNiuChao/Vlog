//
//  VLPhotoDetailResponse.h
//  VLog
//
//  Created by szy on 2020/10/14.
//  Copyright © 2020 niuchao. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
@class VLVideoInfoModel;
@class VLDetail_UserInfoResponse;
@class VLIndex_Cat_InfoResponse;
@class VLIndex_ContextResponse;

@interface VLPhotoDetailResponse : NSObject

KProStrongType(VLVideoInfoModel,video_info)
KProStrongType(VLIndex_Cat_InfoResponse,video_cat_info)
KProStrongType(VLDetail_UserInfoResponse,user_info)
KProStrongType(VLDetail_UserInfoResponse,current_user)
KProBool(is_follow)
kProNSString(like_count)
kProNSString(collection_count)
KProBool(is_like)
KProBool(is_collection)
KProNSArray(tag_list)
KProNSArray(img_size_list)
KProStrongType(VLIndex_ContextResponse,context)
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

@interface VLDetail_UserInfoResponse : NSObject
KProNSInteger(birthday)
KProNSInteger(user_id)
kProNSString(user_name)
kProNSString(mobile)
kProNSString(email)
KProNSInteger(is_seller)
KProNSInteger(shop_id)
KProNSInteger(store_id)
//kProNSString(init_password)
KProNSInteger(comstore_id)
KProNSInteger(multi_store_id)
kProNSString(password)
kProNSString(password_reset_token)
kProNSString(salt)
kProNSString(nickname)
KProNSInteger(sex)
kProNSString(address_now)
kProNSString(detail_address)
kProNSString(headimg)
kProNSString(faceimg1)
kProNSString(faceimg2)
kProNSString(user_money)
kProNSString(user_money_limit)
kProNSString(frozen_money)
kProNSString(pay_point)
kProNSString(frozen_point)
KProNSInteger(rank_point)
KProNSInteger(address_id)
KProNSInteger(rank_id)
KProNSInteger(rank_start_time)
KProNSInteger(rank_end_time)
KProNSInteger(mobile_validated)
KProNSInteger(email_validated)
KProNSInteger(reg_time)
kProNSString(reg_ip)
KProNSInteger(last_time)
kProNSString(last_ip)
KProNSInteger(visit_count)
kProNSString(mobile_supplier)
kProNSString(mobile_province)
kProNSString(mobile_city)
kProNSString(reg_from)
kProNSString(surplus_password)
KProNSInteger(status)
kProNSString(auth_key)
KProNSInteger(type)
KProNSInteger(is_real)
KProNSInteger(shopping_status)
KProNSInteger(comment_status)
KProNSInteger(role_id)
KProNSInteger(auth_codes)
kProNSString(company_name)
kProNSString(company_region_code)
kProNSString(company_address)
//kProNSString(purpose_type)
kProNSString(referral_mobile)
kProNSString(employees)
kProNSString(industry)
kProNSString(nature)
kProNSString(contact_name)
kProNSString(department)
kProNSString(company_tel)
kProNSString(qq_key)
kProNSString(weibo_key)
kProNSString(weixin_key)
kProNSString(user_remark)
kProNSString(invite_code)
KProNSInteger(parent_id)
KProNSInteger(is_recommend)
kProNSString(customs_money)
kProNSString(self_introduction)

@end

NS_ASSUME_NONNULL_END
