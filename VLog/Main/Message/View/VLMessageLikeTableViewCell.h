//
//  VLMessageLikeTableViewCell.h
//  VLog
//
//  Created by szy on 2020/10/25.
//  Copyright © 2020 niuchao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "VLMessageLikeResponse.h"
#import "VLMessageFansResponse.h"

#import "VLFollowUnFollowRequest.h"

NS_ASSUME_NONNULL_BEGIN

@interface VLMessageLikeTableViewCell : UITableViewCell

KProStrongType(UIButton, followButton)
KProStrongType(UIImageView, rightImageView)

KProStrongType(VLMessageLikeResponse, lieModel)
KProStrongType(VLMessageFansResponse, followModel)
@end

NS_ASSUME_NONNULL_END
