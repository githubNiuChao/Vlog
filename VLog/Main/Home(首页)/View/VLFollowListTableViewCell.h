//
//  VLFollowListTableViewCell.h
//  VLog
//
//  Created by szy on 2020/9/29.
//  Copyright © 2020 niuchao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "VLFollowResponse.h"

NS_ASSUME_NONNULL_BEGIN

@interface StackSubView : UIView

KProStrongType(VLVideoInfoModel, videoModel)

KProStrongType(UIImageView, videoIcon);//视频标志
KProStrongType(UIImageView, imageView);
KProStrongType(UILabel, titleLabel);

@end
@class StackSubView;
@class VLIndex_Context_UserInfoResponse;
@interface VLFollowListTableViewCell : UITableViewCell

KProNSInteger(indexPathRow)
KProStrongType(VLFollowListModel, dataModel)
@end



NS_ASSUME_NONNULL_END
