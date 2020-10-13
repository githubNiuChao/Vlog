//
//  VLIndexViewController.h
//  VLog
//
//  Created by szy on 2020/9/24.
//  Copyright © 2020 niuchao. All rights reserved.
//

#import "NCHRefreshCollectionViewController.h"
#import "JXCategoryListContainerView.h"
#import "JXPagerView.h"

NS_ASSUME_NONNULL_BEGIN

typedef void(^reshtitle)(NSArray *titles);

@interface VLIndexViewController : NCHRefreshCollectionViewController
<
JXCategoryListContentViewDelegate,
JXPagerViewListViewDelegate
>

@property (nonatomic, assign) NSInteger catId;
@property (nonatomic,copy) reshtitle reshblock;

@end

NS_ASSUME_NONNULL_END
