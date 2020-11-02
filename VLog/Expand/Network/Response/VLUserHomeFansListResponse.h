//
//  VLUserHomeFansListResponse.h
//  VLog
//
//  Created by szy on 2020/11/2.
//  Copyright © 2020 niuchao. All rights reserved.
//

#import <Foundation/Foundation.h>


NS_ASSUME_NONNULL_BEGIN

@class VLUserHomeFansListModel;

@interface VLUserHomeFansListResponse : NSObject
KProNSArrayType(VLUserHomeFansListModel,list)
KProStrongType(VLIndex_PageResponse,page)
KProStrongType(VLIndex_ContextResponse,context)

@end

@interface VLUserHomeFansListModel : NSObject

kProNSString(user_id)
kProNSString(user_name)
kProNSString(nickname)
kProNSString(headimg)
kProNSString(fans_count)
kProNSString(video_count)
KProBool(is_follow)

@end


NS_ASSUME_NONNULL_END
