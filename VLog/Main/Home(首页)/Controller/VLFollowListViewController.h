//
//  VLFollowListViewController.h
//  VLog
//
//  Created by szy on 2020/9/29.
//  Copyright © 2020 niuchao. All rights reserved.
//

#import "NCHRefreshTableViewController.h"
#import "VLFollowListTableViewCell.h"
#import "JXCategoryListContainerView.h"

NS_ASSUME_NONNULL_BEGIN

@interface VLFollowListViewController : NCHRefreshTableViewController<
JXCategoryListContentViewDelegate,
JXCategoryListContainerViewDelegate,
JXCategoryViewDelegate,
VLFollowListTableViewCellDelegate
>

@end

NS_ASSUME_NONNULL_END
