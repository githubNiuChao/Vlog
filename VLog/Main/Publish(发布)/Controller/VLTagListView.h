//
//  VLTagListView.h
//  VLog
//
//  Created by szy on 2020/10/20.
//  Copyright © 2020 niuchao. All rights reserved.
//

#import "NCHRefreshTableViewController.h"
#import "JXCategoryView.h"


NS_ASSUME_NONNULL_BEGIN
@interface VLTagListView : NCHRefreshTableViewController<JXCategoryListContentViewDelegate>

@end

@interface VLTagListViewCell : UITableViewCell
KProStrongType(UILabel, titleLabel)
KProStrongType(UIImageView, titleImage)
@end

NS_ASSUME_NONNULL_END
