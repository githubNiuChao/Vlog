//
//  VLPublishTagListViewController.h
//  VLog
//
//  Created by szy on 2020/10/20.
//  Copyright © 2020 niuchao. All rights reserved.
//

#import "NCHBaseViewController.h"
#import "YSCTagModel.h"

NS_ASSUME_NONNULL_BEGIN

@class VLPublishTagListViewController;
@protocol VLPublishTagListViewControllerDelegate <NSObject>

- (void)publishTagListViewController:(VLPublishTagListViewController *)vc pusblishTagModel:(YSCTagModel*)tagModel;

@end

@interface VLPublishTagListViewController : NCHBaseViewController

@property (nonatomic, weak) id<VLPublishTagListViewControllerDelegate> delegate;

@property (nonatomic, assign) NSInteger path_index;
@property (nonatomic, assign) CGPoint tapPoint;


@end

NS_ASSUME_NONNULL_END
