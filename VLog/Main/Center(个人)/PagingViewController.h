//
//  OCExampleViewController.h
//  JXPagingView
//
//  Created by jiaxin on 2018/8/27.
//  Copyright © 2018年 jiaxin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JXPagerView.h"
//#import "PagingViewTableHeaderView.h"
#import "UserInfoHeader.h"
#import "SmoothListCollectionViewController.h"
#import "VLIndexViewController.h"
#import "JXCategoryTitleView.h"

static const CGFloat JXTableHeaderViewHeight = 300;
static const CGFloat JXheightForHeaderInSection = 50;

@interface PagingViewController : UIViewController <JXPagerViewDelegate, JXPagerMainTableViewGestureDelegate>

@property (nonatomic, strong) JXPagerView *pagerView;
@property (nonatomic, strong) UserInfoHeader *userHeaderView;
@property (nonatomic, strong, readonly) JXCategoryTitleView *categoryView;
@property (nonatomic, assign) BOOL isNeedFooter;
@property (nonatomic, assign) BOOL isNeedHeader;
- (JXPagerView *)preferredPagingView;

@end
