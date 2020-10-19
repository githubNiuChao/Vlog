//
//  VLUserHomeViewController.h
//  VLog
//
//  Created by szy on 2020/10/19.
//  Copyright © 2020 niuchao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JXPagerView.h"

#import "VLUserHomeListViewController.h"
NS_ASSUME_NONNULL_BEGIN

static const CGFloat TableHeaderViewHeight = 220;
static const CGFloat HeaderInSectionHeight = 50;

@interface VLUserHomeViewController : UIViewController <JXPagerViewDelegate, JXPagerMainTableViewGestureDelegate>

@property (nonatomic, assign) BOOL isNeedFooter;
@property (nonatomic, assign) BOOL isNeedHeader;
- (JXPagerView *)preferredPagingView;

@end

NS_ASSUME_NONNULL_END
