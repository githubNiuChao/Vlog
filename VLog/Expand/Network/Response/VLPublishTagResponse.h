//
//  VLPublishTagResponse.h
//  VLog
//
//  Created by szy on 2020/10/21.
//  Copyright © 2020 niuchao. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@class VLIndex_PageResponse;
@class VLIndex_ContextResponse;
@class VLPublishBrandTagModel;
@interface VLPublishBrandTagResponse : NSObject

KProNSArrayType(VLPublishBrandTagModel, list)
KProStrongType(VLIndex_PageResponse,page)
KProStrongType(VLIndex_ContextResponse,context)

@end

@interface VLPublishBrandTagModel : NSObject

kProNSString(brand_id)
kProNSString(brand_name)
kProNSString(brand_logo)
kProNSString(promotion_image)
kProNSString(brand_letter)
kProNSString(brand_banner)
kProNSString(site_url)
kProNSString(brand_desc)
kProNSString(is_recommend)
kProNSString(brand_sort)
kProNSString(is_show)
kProNSString(brand_apply)
kProNSString(other_brand_id)

@end

@class VLIndex_PageResponse;
@class VLIndex_ContextResponse;
@class VLPublishGoodsTagModel;
@interface VLPublishGoodsTagResponse : NSObject

KProNSArrayType(VLPublishGoodsTagModel, list)
KProStrongType(VLIndex_PageResponse,page)
KProStrongType(VLIndex_ContextResponse,context)

@end

@interface VLPublishGoodsTagModel : NSObject

kProNSString(goods_id)
kProNSString(goods_name)
kProNSString(goods_price)
kProNSString(market_price)
kProNSString(goods_image)

@end

NS_ASSUME_NONNULL_END
