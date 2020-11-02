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

KProStrongType(VLUserHomeFansListModel, fansModel)
KProStrongType(VLUserHomeFansListModel, followModel)//关注列表

@end

NS_ASSUME_NONNULL_END
