//
//  VLUserHomeFansTableViewCell.h
//  VLog
//
//  Created by szy on 2020/11/2.
//  Copyright © 2020 niuchao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "VLFollowUnFollowRequest.h"
#import "VLUserHomeFansListResponse.h"


NS_ASSUME_NONNULL_BEGIN

@interface VLUserHomeFansTableViewCell : UITableViewCell


KProStrongType(UIButton, followButton)

KProStrongType(, fansModel)
@end

NS_ASSUME_NONNULL_END
