//
//  VLDetailCommentModel.h
//  VLog
//
//  Created by szy on 2020/10/19.
//  Copyright © 2020 niuchao. All rights reserved.
//

#define kProNSString(str)                @property (nonatomic, copy) NSString *str;
#define KProNSArrayType(type,arr)        @property (nonatomic, strong) NSArray <type * >*arr;
#define KProNSMutableArrayType(type,arr) @property (nonatomic, strong) NSMutableArray <type * >*arr;

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface VLDetailCommentModel : NSObject

kProNSString(comment_id)
kProNSString(parent_id)
kProNSString(reply_id)
kProNSString(video_id)
kProNSString(user_id)
kProNSString(content)
kProNSString(add_time)
kProNSString(audit_status)
kProNSString(audit_text)
kProNSString(headimg)
kProNSString(nickname)
kProNSString(reply_user)
KProNSArrayType(VLDetailCommentModel,children)

// 因为评论是动态的，因此要标识是否要更新缓存
@property (nonatomic, assign) BOOL shouldUpdateCache;


@end

NS_ASSUME_NONNULL_END
