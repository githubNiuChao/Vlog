//
//  VLBaseContentViewController.h
//  VLog
//
//  Created by szy on 2020/9/25.
//  Copyright © 2020 niuchao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JXCategoryView.h"
#import "VLBaseListViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface VLBaseContentViewController : UIViewController<JXCategoryListContainerViewDelegate>

@property (nonatomic, strong) NSArray *titles;
@property (nonatomic, strong) JXCategoryBaseView *categoryView;
@property (nonatomic, strong) JXCategoryListContainerView *listContainerView;

- (JXCategoryBaseView *)preferredCategoryView;
- (CGFloat)preferredCategoryViewHeight;


@end

NS_ASSUME_NONNULL_END
